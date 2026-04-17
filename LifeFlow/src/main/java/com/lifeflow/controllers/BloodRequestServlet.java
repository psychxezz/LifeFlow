package com.lifeflow.controllers;

import com.lifeflow.model.User;
import com.lifeflow.service.BloodRequestService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/blood-requests")
public class BloodRequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final BloodRequestService bloodRequestService = new BloodRequestService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        if (loggedInUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        String keyword = request.getParameter("keyword");
        String bloodGroup = request.getParameter("bloodGroup");
        String city = request.getParameter("city");

        request.setAttribute("bloodRequests",
                bloodRequestService.searchBloodRequests(keyword, bloodGroup, city));

        request.setAttribute("keyword", keyword);
        request.setAttribute("bloodGroup", bloodGroup);
        request.setAttribute("city", city);

        request.getRequestDispatcher("/WEB-INF/pages/blood-requests.jsp").forward(request, response);
    }
}