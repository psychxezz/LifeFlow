package com.lifeflow.controllers;

import com.lifeflow.model.User;
import com.lifeflow.service.AuthService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final AuthService authService = new AuthService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    	String success = request.getParameter("success");
    	if ("registered".equals(success)) {
    	    request.setAttribute("successMessage", "Registration successful. Please log in.");
    	} else if ("reset".equals(success)) {
    	    request.setAttribute("successMessage", "Password reset successful. Please log in.");
    	}

        request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (isEmpty(email) || isEmpty(password)) {
            request.setAttribute("errorMessage", "Email and password are required.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }

        if (authService.isAccountLocked(email)) {
            request.setAttribute("errorMessage", "Your account is locked due to too many failed login attempts.");
            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
            return;
        }

        User user = authService.loginUser(email, password);

        if (user != null) {
            authService.resetFailedAttempts(email);

            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            session.setAttribute("userRole", user.getRole());
            session.setAttribute("userName", user.getFullName());
            session.setMaxInactiveInterval(30 * 60);

            if ("admin".equalsIgnoreCase(user.getRole())) {
                response.sendRedirect(request.getContextPath() + "/admin-dashboard");
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }

        } else {
            authService.increaseFailedAttempts(email);
            int attempts = authService.getFailedAttempts(email);

            if (attempts >= 3) {
                authService.lockAccount(email);
                request.setAttribute("errorMessage",
                        "Your account has been locked after 3 failed login attempts.");
            } else {
                request.setAttribute("errorMessage",
                        "Invalid credentials. Attempt " + attempts + " of 3.");
            }

            request.getRequestDispatcher("/WEB-INF/pages/login.jsp").forward(request, response);
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}