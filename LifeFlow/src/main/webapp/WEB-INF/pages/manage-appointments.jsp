<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.Appointment" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Appointments - Admin Console</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body style="background: var(--surface-base);">
<%
    User adminUser = (User) session.getAttribute("loggedInUser");
    if (adminUser == null || !"ADMIN".equalsIgnoreCase(adminUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

<nav class="v3-navbar admin-mode">
    <a class="v3-nav-brand" href="<%= request.getContextPath() %>/admin-dashboard">
        <svg width="28" height="28" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M16 3C16 3 6 12.5 6 19a10 10 0 0 0 20 0C26 12.5 16 3 16 3Z" fill="white"/>
            <path d="M16 10C16 10 10 16.5 10 20a6 6 0 0 0 12 0C22 16.5 16 10 16 10Z" fill="rgba(255,255,255,0.3)"/>
        </svg>
        Command Center
    </a>
    <div class="v3-nav-links" id="navbarLinks">
        <a href="<%= request.getContextPath() %>/home">Platform Home</a>
        <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/manage-users">Users</a>
        <a href="<%= request.getContextPath() %>/manage-donors">Donors</a>
        <a href="<%= request.getContextPath() %>/manage-blood-requests">Requests</a>
        <a href="<%= request.getContextPath() %>/manage-appointments" class="active">Appointments</a>
        <a href="<%= request.getContextPath() %>/view-messages">Messages</a>
        <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout" style="background: rgba(255,255,255,0.1); color: white;">Logout</a>
    </div>
</nav>

<div class="v3-admin-header reveal" style="padding: 3rem 5%; padding-bottom: 5rem;">
    <h1 class="v3-admin-title">Appointment Schedule</h1>
    <p class="v3-admin-subtitle">Approve, update, and manage all incoming donor session requests.</p>
</div>

<main class="v3-data-suite" style="margin-top: -4rem;">
    <div style="max-width: 1400px; margin: 0 auto; position: relative; z-index: 10;">
        
        <%
            String errorMessage   = (String) request.getAttribute("errorMessage");
            String successMessage = (String) request.getAttribute("successMessage");
            if (errorMessage != null) {
        %>
            <div class="v3-message error"><%= errorMessage %></div>
        <% } %>
        <% if (successMessage != null) { %>
            <div class="v3-message success"><%= successMessage %></div>
        <% } %>

        <div class="v3-table-wrapper reveal">
            <table>
                <thead>
                    <tr>
                        <th>Appt ID</th>
                        <th>Donor ID</th>
                        <th>Date</th>
                        <th>Location</th>
                        <th>Status</th>
                        <th style="text-align:right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Appointment> apptList = (List<Appointment>) request.getAttribute("appointments");
                        if (apptList != null && !apptList.isEmpty()) {
                            for (Appointment a : apptList) {
                                String statusClass = "badge-pending";
                                if ("Approved".equalsIgnoreCase(a.getStatus()) || "Completed".equalsIgnoreCase(a.getStatus())) statusClass = "badge-approved";
                                else if ("Cancelled".equalsIgnoreCase(a.getStatus())) statusClass = "badge-cancelled";
                    %>
                        <tr>
                            <td><span style="font-size:0.85rem; color:var(--text-muted);"><%= a.getAppointmentId() %></span></td>
                            <td><strong><%= a.getDonorId() %></strong></td>
                            <td><strong><%= a.getAppointmentDate() %></strong></td>
                            <td><%= a.getLocation() %></td>
                            <td><span class="badge <%= statusClass %>"><%= a.getStatus() %></span></td>
                            <td style="text-align:right;">
                                <% if (!"Approved".equalsIgnoreCase(a.getStatus()) && !"Completed".equalsIgnoreCase(a.getStatus())) { %>
                                    <form action="<%= request.getContextPath() %>/manage-appointments" method="post" style="display:inline;">
                                        <input type="hidden" name="appointmentId" value="<%= a.getAppointmentId() %>">
                                        <input type="hidden" name="donorId" value="<%= a.getDonorId() %>">
                                        <input type="hidden" name="appointmentDate" value="<%= a.getAppointmentDate() %>">
                                        <input type="hidden" name="appointmentTime" value="<%= a.getAppointmentTime() != null ? a.getAppointmentTime().toString().substring(0, 5) : "00:00" %>">
                                        <input type="hidden" name="location" value="<%= a.getLocation() %>">
                                        <input type="hidden" name="status" value="Approved">
                                        <button type="submit" class="btn btn-secondary" style="padding: 6px 12px; font-size: 0.8rem; border-color: var(--status-success); color: var(--status-success);">Approve</button>
                                    </form>
                                <% } %>

                                <% if (!"Cancelled".equalsIgnoreCase(a.getStatus())) { %>
                                    <form action="<%= request.getContextPath() %>/manage-appointments" method="post" style="display:inline; margin-left:8px;">
                                        <input type="hidden" name="appointmentId" value="<%= a.getAppointmentId() %>">
                                        <input type="hidden" name="donorId" value="<%= a.getDonorId() %>">
                                        <input type="hidden" name="appointmentDate" value="<%= a.getAppointmentDate() %>">
                                        <input type="hidden" name="appointmentTime" value="<%= a.getAppointmentTime() != null ? a.getAppointmentTime().toString().substring(0, 5) : "00:00" %>">
                                        <input type="hidden" name="location" value="<%= a.getLocation() %>">
                                        <input type="hidden" name="status" value="Cancelled">
                                        <button type="submit" class="btn btn-secondary" style="padding: 6px 12px; font-size: 0.8rem; border-color: var(--status-critical); color: var(--status-critical);">Cancel</button>
                                    </form>
                                <% } %>

                                <% if ("Approved".equalsIgnoreCase(a.getStatus())) { %>
                                    <form action="<%= request.getContextPath() %>/manage-appointments" method="post" style="display:inline; margin-left:8px;">
                                        <input type="hidden" name="appointmentId" value="<%= a.getAppointmentId() %>">
                                        <input type="hidden" name="donorId" value="<%= a.getDonorId() %>">
                                        <input type="hidden" name="appointmentDate" value="<%= a.getAppointmentDate() %>">
                                        <input type="hidden" name="appointmentTime" value="<%= a.getAppointmentTime() != null ? a.getAppointmentTime().toString().substring(0, 5) : "00:00" %>">
                                        <input type="hidden" name="location" value="<%= a.getLocation() %>">
                                        <input type="hidden" name="status" value="Completed">
                                        <button type="submit" class="btn btn-primary" style="padding: 6px 12px; font-size: 0.8rem;">Complete</button>
                                    </form>
                                <% } %>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="6" style="text-align:center; padding:3rem;">No appointments found.</td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</main>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        setTimeout(() => {
            document.querySelectorAll('.reveal').forEach(el => el.classList.add('active'));
        }, 50);
    });
</script>
</body>
</html>