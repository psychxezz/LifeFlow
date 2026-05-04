<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.BloodRequest" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blood Requests - LifeFlow</title>
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
        <a href="<%= request.getContextPath() %>/appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/blood-requests" class="active">Blood Requests</a>
        <a href="<%= request.getContextPath() %>/contact">Contact</a>
        <a href="<%= request.getContextPath() %>/about">About</a>
        <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout">Logout</a>
    </div>
</nav>

<div class="v3-page-header reveal">
    <div>
        <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">Urgent Requests</h1>
        <p style="color: var(--text-muted); font-size: 1.1rem;">Live feed of hospital blood requirements.</p>
    </div>
    <svg class="v3-page-header-svg" viewBox="0 0 200 120" fill="none" xmlns="http://www.w3.org/2000/svg">
        <rect x="40" y="20" width="120" height="80" rx="12" fill="white" style="filter:drop-shadow(0 10px 20px rgba(0,0,0,0.05))"/>
        <path d="M60 60 L80 60 L90 40 L110 80 L120 60 L140 60" stroke="var(--status-critical)" stroke-width="4" stroke-linecap="round" stroke-linejoin="round"/>
        <circle cx="170" cy="30" r="15" fill="var(--status-warning-bg)"/>
        <circle cx="30" cy="90" r="10" fill="var(--status-info-bg)"/>
    </svg>
</div>

<main class="v3-data-suite">
    <div style="max-width: 1400px; margin: 0 auto;">

        <div class="v3-toolbar reveal" style="animation-delay: 0.1s;">
            <form action="<%= request.getContextPath() %>/blood-requests" method="get" style="display:flex; gap:1rem; width:100%; align-items:flex-end; flex-wrap:wrap;">
                <div class="v3-form-group" style="margin:0; flex:1; min-width: 200px;">
                    <label for="keyword">Search</label>
                    <input type="text" name="keyword" id="keyword" placeholder="Hospital or patient name" value="<%= request.getAttribute("keyword") != null ? request.getAttribute("keyword") : "" %>">
                </div>
                <div class="v3-form-group" style="margin:0; width:150px;">
                    <label for="bloodGroup">Blood Group</label>
                    <select name="bloodGroup" id="bloodGroup">
                        <option value="">All</option>
                        <% 
                           String selectedBg = (String) request.getAttribute("bloodGroup");
                           String[] groups = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
                           for (String g : groups) {
                        %>
                            <option value="<%= g %>" <%= g.equals(selectedBg) ? "selected" : "" %>><%= g %></option>
                        <% } %>
                    </select>
                </div>
                <div class="v3-form-group" style="margin:0; width:150px;">
                    <label for="city">City</label>
                    <input type="text" name="city" id="city" placeholder="e.g. New York" value="<%= request.getAttribute("city") != null ? request.getAttribute("city") : "" %>">
                </div>
                <div style="display:flex; gap:12px;">
                    <button type="submit" class="btn btn-primary" style="height: 48px;">Filter</button>
                    <a href="<%= request.getContextPath() %>/blood-requests" class="btn btn-secondary" style="height: 48px;">Clear</a>
                </div>
            </form>
        </div>

        <div class="v3-table-wrapper reveal" style="animation-delay: 0.2s;">
            <table>
                <thead>
                    <tr>
                        <th>Patient & Hospital</th>
                        <th>Location</th>
                        <th>Required Group</th>
                        <th>Urgency</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<BloodRequest> requestsList = (List<BloodRequest>) request.getAttribute("bloodRequests");
                        if (requestsList != null && !requestsList.isEmpty()) {
                            for (BloodRequest br : requestsList) {
                                String uClass = "badge-normal";
                                if ("Urgent".equalsIgnoreCase(br.getUrgencyLevel())) uClass = "badge-urgent";
                                else if ("Critical".equalsIgnoreCase(br.getUrgencyLevel())) uClass = "badge-critical";

                                String sClass = "badge-open";
                                if ("Closed".equalsIgnoreCase(br.getRequestStatus()) || "Completed".equalsIgnoreCase(br.getRequestStatus())) sClass = "badge-closed";
                    %>
                        <tr>
                            <td>
                                <strong style="font-size:1.05rem;"><%= br.getPatientName() %></strong><br>
                                <span style="font-size: 0.85rem; color: var(--text-muted);"><%= br.getHospitalName() %></span>
                            </td>
                            <td><%= br.getCity() %></td>
                            <td><span style="color:var(--brand-primary-dark); font-weight:800; font-size:1.1rem;"><%= br.getBloodGroup() %></span></td>
                            <td><span class="badge <%= uClass %>"><%= br.getUrgencyLevel() %></span></td>
                            <td><span class="badge <%= sClass %>"><%= br.getRequestStatus() %></span></td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr>
                            <td colspan="5" style="text-align:center; padding: 4rem 2rem;">
                                <div style="color:var(--text-muted);">No matching blood requests found.</div>
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