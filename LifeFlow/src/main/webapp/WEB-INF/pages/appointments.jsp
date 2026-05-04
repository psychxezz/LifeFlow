<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.Appointment" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Appointments - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

<nav class="v3-navbar">
    <a class="v3-nav-brand" href="<%= request.getContextPath() %>/home">
        <svg width="28" height="28" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M16 3C16 3 6 12.5 6 19a10 10 0 0 0 20 0C26 12.5 16 3 16 3Z" fill="var(--brand-primary)"/>
            <path d="M16 10C16 10 10 16.5 10 20a6 6 0 0 0 12 0C22 16.5 16 10 16 10Z" fill="var(--brand-primary-light)"/>
        </svg>
        LifeFlow
    </a>
    <div class="v3-nav-links" id="navbarLinks">
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <a href="<%= request.getContextPath() %>/profile">Profile</a>
        <a href="<%= request.getContextPath() %>/appointments" class="active">Appointments</a>
        <a href="<%= request.getContextPath() %>/blood-requests">Blood Requests</a>
        <a href="<%= request.getContextPath() %>/contact">Contact</a>
        <a href="<%= request.getContextPath() %>/about">About</a>
        <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout">Logout</a>
    </div>
</nav>

<div class="v3-page-header reveal">
    <div>
        <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">My Appointments</h1>
        <p style="color: var(--text-muted); font-size: 1.1rem;">Schedule and track your upcoming blood donation sessions.</p>
    </div>
    <svg class="v3-page-header-svg" viewBox="0 0 200 120" fill="none" xmlns="http://www.w3.org/2000/svg">
        <rect x="20" y="20" width="160" height="80" rx="12" fill="white" style="filter:drop-shadow(0 10px 20px rgba(0,0,0,0.05))"/>
        <path d="M20 50 H180" stroke="var(--border-soft)" stroke-width="2"/>
        <rect x="40" y="10" width="12" height="20" rx="6" fill="var(--brand-primary)"/>
        <rect x="148" y="10" width="12" height="20" rx="6" fill="var(--brand-primary)"/>
        <rect x="40" y="65" width="20" height="20" rx="4" fill="var(--status-info-bg)"/>
        <rect x="70" y="65" width="20" height="20" rx="4" fill="var(--status-warning-bg)"/>
        <rect x="100" y="65" width="20" height="20" rx="4" fill="var(--surface-base)"/>
    </svg>
</div>

<main class="v3-data-suite">
    <div style="max-width: 1200px; margin: 0 auto;">
        
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

        <div class="v3-toolbar reveal" style="animation-delay: 0.1s;">
            <form action="<%= request.getContextPath() %>/appointments" method="post" style="display:flex; gap:1rem; width:100%; align-items:flex-end;">
                <input type="hidden" name="action" value="book">
                <div class="v3-form-group" style="margin:0; flex:1;">
                    <label for="appointmentDate">Date</label>
                    <input type="date" id="appointmentDate" name="appointmentDate" required>
                </div>
                <div class="v3-form-group" style="margin:0; flex:1;">
                    <label for="hospitalName">Hospital / Clinic</label>
                    <input type="text" id="hospitalName" name="hospitalName" placeholder="Where will you donate?" required>
                </div>
                <button type="submit" class="btn btn-primary" style="height: 48px; padding: 0 32px;">Book Session</button>
            </form>
        </div>

        <div class="v3-table-wrapper reveal" style="animation-delay: 0.2s;">
            <table>
                <thead>
                    <tr>
                        <th>Date</th>
                        <th>Location</th>
                        <th>Status</th>
                        <th style="text-align:right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<Appointment> appointmentList = (List<Appointment>) request.getAttribute("appointments");
                        if (appointmentList != null && !appointmentList.isEmpty()) {
                            for (Appointment appt : appointmentList) {
                                String statusClass = "badge-pending";
                                if ("Approved".equalsIgnoreCase(appt.getStatus()) || "Completed".equalsIgnoreCase(appt.getStatus())) statusClass = "badge-approved";
                                else if ("Cancelled".equalsIgnoreCase(appt.getStatus())) statusClass = "badge-cancelled";
                    %>
                        <tr>
                            <td><strong><%= appt.getAppointmentDate() %></strong></td>
                            <td><%= appt.getLocation() %></td>
                            <td><span class="badge <%= statusClass %>"><%= appt.getStatus() %></span></td>
                            <td style="text-align:right;">
                                <% if ("Pending".equalsIgnoreCase(appt.getStatus())) { %>
                                    <form action="<%= request.getContextPath() %>/appointments" method="post" style="display:inline;" onsubmit="return confirm('Cancel this appointment?');">
                                        <input type="hidden" name="action" value="cancel">
                                        <input type="hidden" name="appointmentId" value="<%= appt.getAppointmentId() %>">
                                        <button type="submit" class="btn btn-danger" style="padding: 6px 12px; font-size: 0.8rem;">Cancel</button>
                                    </form>
                                <% } else { %>
                                    <span style="color:var(--text-muted); font-size:0.85rem;">-</span>
                                <% } %>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="4" style="text-align:center; padding: 4rem 2rem;">
                                <div style="margin-bottom:1rem; opacity:0.5;">
                                    <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                                </div>
                                <div style="color:var(--text-muted);">You have no appointments scheduled.</div>
                            </td>
                        </tr>
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