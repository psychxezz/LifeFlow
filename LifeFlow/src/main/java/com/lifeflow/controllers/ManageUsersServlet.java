package com.lifeflow.controllers;

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

@WebServlet("/manage-users")
public class ManageUsersServlet extends HttpServlet {
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

        String keyword = request.getParameter("keyword");
        String role = request.getParameter("role");

        List<User> users = adminService.searchUsers(keyword, role);
        request.setAttribute("users", users);

        request.setAttribute("keyword", keyword);
        request.setAttribute("role", role);

        String message = request.getParameter("message");
        if (message != null) {
            request.setAttribute("successMessage", message);
        }

        request.getRequestDispatcher("/WEB-INF/pages/manage-users.jsp").forward(request, response);
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
        String userIdValue = request.getParameter("userId");

        if ("delete".equalsIgnoreCase(action) && userIdValue != null && !userIdValue.trim().isEmpty()) {
            int userId = Integer.parseInt(userIdValue);

            if (loggedInUser.getUserId() == userId) {
                response.sendRedirect(request.getContextPath() + "/manage-users?message=You cannot delete your own admin account.");
                return;
            }

            boolean deleted = adminService.deleteUserById(userId);

            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/manage-users?message=User deleted successfully.");
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-users?message=Failed to delete user.");
            }
            return;
        }

        response.sendRedirect(request.getContextPath() + "/manage-users");
    }
}