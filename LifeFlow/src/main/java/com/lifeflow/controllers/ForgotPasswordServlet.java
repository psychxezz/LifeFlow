package com.lifeflow.controllers;

import com.lifeflow.model.User;
import com.lifeflow.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String step = request.getParameter("step");

        if ("verifyEmail".equals(step)) {
            handleEmailVerification(request, response);
        } else if ("resetPassword".equals(step)) {
            handlePasswordReset(request, response);
        } else {
            request.setAttribute("errorMessage", "Invalid request.");
            request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp").forward(request, response);
        }
    }

    private void handleEmailVerification(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");

        if (email == null || email.trim().isEmpty()) {
            request.setAttribute("errorMessage", "Please enter your email address.");
            request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp").forward(request, response);
            return;
        }

        User user = userService.getUserByEmail(email);

        if (user == null) {
            request.setAttribute("errorMessage", "No account found with that email.");
            request.getRequestDispatcher("/WEB-INF/pages/forgot-password.jsp").forward(request, response);
            return;
        }

        request.setAttribute("email", email);
        request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp").forward(request, response);
    }

    private void handlePasswordReset(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String newPassword = request.getParameter("newPassword");
        String confirmPassword = request.getParameter("confirmPassword");

        if (email == null || email.trim().isEmpty()
                || newPassword == null || newPassword.trim().isEmpty()
                || confirmPassword == null || confirmPassword.trim().isEmpty()) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp").forward(request, response);
            return;
        }

        if (!newPassword.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "New password and confirm password do not match.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp").forward(request, response);
            return;
        }

        boolean updated = userService.updatePasswordByEmail(email, newPassword);

        if (updated) {
            response.sendRedirect(request.getContextPath() + "/login?success=reset");
        } else {
            request.setAttribute("errorMessage", "Failed to reset password.");
            request.setAttribute("email", email);
            request.getRequestDispatcher("/WEB-INF/pages/reset-password.jsp").forward(request, response);
        }
    }
}