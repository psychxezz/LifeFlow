package com.lifeflow.controllers;

import com.lifeflow.model.ContactMessage;
import com.lifeflow.model.User;
import com.lifeflow.service.AdminService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/view-messages")
public class ViewMessagesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AdminService adminService = new AdminService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String message = request.getParameter("message");
        if (message != null) {
            request.setAttribute("successMessage", message);
        }

        List<ContactMessage> messages = adminService.getAllContactMessages();
        request.setAttribute("messages", messages);

        request.getRequestDispatcher("/WEB-INF/pages/view-messages.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null || !"admin".equalsIgnoreCase(loggedInUser.getRole())) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equalsIgnoreCase(action)) {
            int messageId = Integer.parseInt(request.getParameter("messageId"));
            boolean deleted = adminService.deleteContactMessageById(messageId);

            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/view-messages?message=Message deleted successfully.");
            } else {
                response.sendRedirect(request.getContextPath() + "/view-messages?message=Failed to delete message.");
            }
            return;
        }

        response.sendRedirect(request.getContextPath() + "/view-messages");
    }
}