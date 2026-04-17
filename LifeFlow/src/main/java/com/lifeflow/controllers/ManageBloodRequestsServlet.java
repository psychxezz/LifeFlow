package com.lifeflow.controllers;

import com.lifeflow.model.BloodRequest;
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

@WebServlet("/manage-blood-requests")
public class ManageBloodRequestsServlet extends HttpServlet {
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
        String bloodGroup = request.getParameter("bloodGroup");
        String city = request.getParameter("city");
        String urgencyLevel = request.getParameter("urgencyLevel");
        String requestStatus = request.getParameter("requestStatus");

        List<BloodRequest> bloodRequests = adminService.searchBloodRequests(
                keyword, bloodGroup, city, urgencyLevel, requestStatus
        );

        request.setAttribute("bloodRequests", bloodRequests);
        request.setAttribute("keyword", keyword);
        request.setAttribute("bloodGroup", bloodGroup);
        request.setAttribute("city", city);
        request.setAttribute("urgencyLevel", urgencyLevel);
        request.setAttribute("requestStatus", requestStatus);

        String editIdValue = request.getParameter("editId");
        if (editIdValue != null && !editIdValue.trim().isEmpty()) {
            int requestId = Integer.parseInt(editIdValue);
            BloodRequest editRequest = adminService.getBloodRequestById(requestId);
            request.setAttribute("editRequest", editRequest);
        }

        String message = request.getParameter("message");
        if (message != null) {
            request.setAttribute("successMessage", message);
        }

        request.getRequestDispatcher("/WEB-INF/pages/manage-blood-requests.jsp").forward(request, response);
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
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            boolean deleted = adminService.deleteBloodRequestById(requestId);

            if (deleted) {
                response.sendRedirect(request.getContextPath() + "/manage-blood-requests?message=Blood request deleted successfully.");
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-blood-requests?message=Failed to delete blood request.");
            }
            return;
        }

        String requestIdValue = request.getParameter("requestId");
        String patientName = request.getParameter("patientName");
        String bloodGroup = request.getParameter("bloodGroup");
        String hospitalName = request.getParameter("hospitalName");
        String city = request.getParameter("city");
        String urgencyLevel = request.getParameter("urgencyLevel");
        int unitsRequired = Integer.parseInt(request.getParameter("unitsRequired"));
        String requestStatus = request.getParameter("requestStatus");

        BloodRequest bloodRequest = new BloodRequest();
        bloodRequest.setPatientName(patientName);
        bloodRequest.setBloodGroup(bloodGroup);
        bloodRequest.setHospitalName(hospitalName);
        bloodRequest.setCity(city);
        bloodRequest.setUrgencyLevel(urgencyLevel);
        bloodRequest.setUnitsRequired(unitsRequired);
        bloodRequest.setRequestStatus(requestStatus);

        boolean success;

        if (requestIdValue != null && !requestIdValue.trim().isEmpty()) {
            bloodRequest.setRequestId(Integer.parseInt(requestIdValue));
            success = adminService.updateBloodRequest(bloodRequest);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/manage-blood-requests?message=Blood request updated successfully.");
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-blood-requests?message=Failed to update blood request.");
            }
        } else {
            success = adminService.addBloodRequest(bloodRequest);

            if (success) {
                response.sendRedirect(request.getContextPath() + "/manage-blood-requests?message=Blood request added successfully.");
            } else {
                response.sendRedirect(request.getContextPath() + "/manage-blood-requests?message=Failed to add blood request.");
            }
        }
    }
}