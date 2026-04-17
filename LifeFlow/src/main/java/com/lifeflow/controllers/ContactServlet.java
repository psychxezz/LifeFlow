package com.lifeflow.controllers;

import com.lifeflow.model.ContactMessage;
import com.lifeflow.service.ContactService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/contact")
public class ContactServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final ContactService contactService = new ContactService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String messageText = request.getParameter("message");

        if (isEmpty(name) || isEmpty(email) || isEmpty(subject) || isEmpty(messageText)) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(request, response);
            return;
        }

        ContactMessage contactMessage = new ContactMessage();
        contactMessage.setName(name);
        contactMessage.setEmail(email);
        contactMessage.setSubject(subject);
        contactMessage.setMessage(messageText);

        boolean success = contactService.saveContactMessage(contactMessage);

        if (success) {
            request.setAttribute("successMessage", "Your message has been submitted successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to submit your message. Please try again.");
        }

        request.getRequestDispatcher("/WEB-INF/pages/contact.jsp").forward(request, response);
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}