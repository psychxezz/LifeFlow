<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.BloodRequest" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Blood Requests - Admin Console</title>
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
        <a href="<%= request.getContextPath() %>/manage-blood-requests" class="active">Requests</a>
        <a href="<%= request.getContextPath() %>/manage-appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/view-messages">Messages</a>
        <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout" style="background: rgba(255,255,255,0.1); color: white;">Logout</a>
    </div>
</nav>

<div class="v3-admin-header reveal" style="padding: 3rem 5%; padding-bottom: 5rem;">
    <h1 class="v3-admin-title">Request Dispatch</h1>
    <p class="v3-admin-subtitle">Publish new hospital requirements and close fulfilled dispatch orders.</p>
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

        <div class="v3-table-wrapper reveal" style="margin-bottom: 2rem; padding: 3rem;">
            <h2 style="font-size: 1.25rem; margin-bottom: 1.5rem; color: var(--text-strong);">Create Dispatch Request</h2>
            <form action="<%= request.getContextPath() %>/manage-blood-requests" method="post">
                <input type="hidden" name="action" value="create">
                
                <div class="v3-form-row">
                    <div class="v3-form-group">
                        <label for="patientName">Patient Name</label>
                        <input type="text" id="patientName" name="patientName" required>
                    </div>
                    <div class="v3-form-group">
                        <label for="bloodGroup">Blood Group Required</label>
                        <select id="bloodGroup" name="bloodGroup" required>
                            <option value="">Select Group</option>
                            <% String[] groups = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
                               for (String g : groups) { %>
                                <option value="<%= g %>"><%= g %></option>
                            <% } %>
                        </select>
                    </div>
                </div>

                <div class="v3-form-row">
                    <div class="v3-form-group">
                        <label for="hospitalName">Hospital / Clinic</label>
                        <input type="text" id="hospitalName" name="hospitalName" required>
                    </div>
                    <div class="v3-form-group">
                        <label for="city">City Location</label>
                        <input type="text" id="city" name="city" required>
                    </div>
                </div>

                <div class="v3-form-row">
                    <div class="v3-form-group">
                        <label for="urgencyLevel">Urgency Level</label>
                        <select id="urgencyLevel" name="urgencyLevel" required>
                            <option value="Normal">Normal</option>
                            <option value="Urgent">Urgent</option>
                            <option value="Critical">Critical</option>
                        </select>
                    </div>
                    <div class="v3-form-group">
                        <label for="unitsRequired">Units Required</label>
                        <input type="number" id="unitsRequired" name="unitsRequired" min="1" value="1" required>
                        <input type="hidden" name="requestStatus" value="Open">
                    </div>
                </div>

                <div style="display:flex; justify-content:flex-end;">
                    <button type="submit" class="btn btn-primary" style="padding: 14px 32px;">Publish Request</button>
                </div>
            </form>
        </div>

        <div class="v3-table-wrapper reveal" style="animation-delay: 0.1s;">
            <table>
                <thead>
                    <tr>
                        <th>Req ID</th>
                        <th>Patient</th>
                        <th>Hospital & City</th>
                        <th>Group</th>
                        <th>Urgency</th>
                        <th>Status</th>
                        <th style="text-align:right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<BloodRequest> reqList = (List<BloodRequest>) request.getAttribute("bloodRequests");
                        if (reqList != null && !reqList.isEmpty()) {
                            for (BloodRequest br : reqList) {
                                String uClass = "badge-normal";
                                if ("Urgent".equalsIgnoreCase(br.getUrgencyLevel())) uClass = "badge-urgent";
                                else if ("Critical".equalsIgnoreCase(br.getUrgencyLevel())) uClass = "badge-critical";

                                String sClass = "badge-open";
                                if ("Closed".equalsIgnoreCase(br.getRequestStatus()) || "Completed".equalsIgnoreCase(br.getRequestStatus())) sClass = "badge-closed";
                    %>
                        <tr>
                            <td><span style="font-size:0.85rem; color:var(--text-muted);"><%= br.getRequestId() %></span></td>
                            <td><strong><%= br.getPatientName() %></strong></td>
                            <td>
                                <div><%= br.getHospitalName() %></div>
                                <div style="font-size:0.85rem; color:var(--text-muted);"><%= br.getCity() %></div>
                            </td>
                            <td><span style="color:var(--brand-primary-dark); font-weight:800; font-size:1.1rem;"><%= br.getBloodGroup() %></span></td>
                            <td><span class="badge <%= uClass %>"><%= br.getUrgencyLevel() %></span></td>
                            <td><span class="badge <%= sClass %>"><%= br.getRequestStatus() %></span></td>
                            <td style="text-align:right;">
                                <% if ("Open".equalsIgnoreCase(br.getRequestStatus())) { %>
                                    <form action="<%= request.getContextPath() %>/manage-blood-requests" method="post" style="display:inline;">
                                        <input type="hidden" name="requestId" value="<%= br.getRequestId() %>">
                                        <input type="hidden" name="patientName" value="<%= br.getPatientName() %>">
                                        <input type="hidden" name="bloodGroup" value="<%= br.getBloodGroup() %>">
                                        <input type="hidden" name="hospitalName" value="<%= br.getHospitalName() %>">
                                        <input type="hidden" name="city" value="<%= br.getCity() %>">
                                        <input type="hidden" name="urgencyLevel" value="<%= br.getUrgencyLevel() %>">
                                        <input type="hidden" name="unitsRequired" value="<%= br.getUnitsRequired() %>">
                                        <input type="hidden" name="requestStatus" value="Closed">
                                        <button type="submit" class="btn btn-secondary" style="padding: 6px 12px; font-size: 0.8rem; border-color: var(--status-success); color: var(--status-success);">Close</button>
                                    </form>
                                <% } else { %>
                                    <form action="<%= request.getContextPath() %>/manage-blood-requests" method="post" style="display:inline;">
                                        <input type="hidden" name="requestId" value="<%= br.getRequestId() %>">
                                        <input type="hidden" name="patientName" value="<%= br.getPatientName() %>">
                                        <input type="hidden" name="bloodGroup" value="<%= br.getBloodGroup() %>">
                                        <input type="hidden" name="hospitalName" value="<%= br.getHospitalName() %>">
                                        <input type="hidden" name="city" value="<%= br.getCity() %>">
                                        <input type="hidden" name="urgencyLevel" value="<%= br.getUrgencyLevel() %>">
                                        <input type="hidden" name="unitsRequired" value="<%= br.getUnitsRequired() %>">
                                        <input type="hidden" name="requestStatus" value="Open">
                                        <button type="submit" class="btn btn-secondary" style="padding: 6px 12px; font-size: 0.8rem;">Re-Open</button>
                                    </form>
                                <% } %>
                                
                                <form action="<%= request.getContextPath() %>/manage-blood-requests" method="post" style="display:inline; margin-left:8px;" onsubmit="return confirm('Delete this request?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="requestId" value="<%= br.getRequestId() %>">
                                    <button type="submit" class="btn btn-danger" style="padding: 6px 12px; font-size: 0.8rem;">Delete</button>
                                </form>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="7" style="text-align:center; padding:3rem;">No blood requests found.</td></tr>
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