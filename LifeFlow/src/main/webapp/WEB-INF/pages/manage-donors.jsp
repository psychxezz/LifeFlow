<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.Donor" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Donors - Admin Console</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body style="background: var(--surface-base);">
<%
    User adminUser = (User) session.getAttribute("loggedInUser");
    if (adminUser == null || !"ADMIN".equalsIgnoreCase(adminUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    String editMode = request.getParameter("editId");
    List<Donor> donorList = (List<Donor>) request.getAttribute("donors");
    Donor donorToEdit = null;
    if (editMode != null && donorList != null) {
        for (Donor d : donorList) {
            if (String.valueOf(d.getDonorId()).equals(editMode)) {
                donorToEdit = d;
                break;
            }
        }
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
        <a href="<%= request.getContextPath() %>/manage-donors" class="active">Donors</a>
        <a href="<%= request.getContextPath() %>/manage-blood-requests">Requests</a>
        <a href="<%= request.getContextPath() %>/manage-appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/view-messages">Messages</a>
        <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout" style="background: rgba(255,255,255,0.1); color: white;">Logout</a>
    </div>
</nav>

<div class="v3-admin-header reveal" style="padding: 3rem 5%; padding-bottom: 5rem;">
    <h1 class="v3-admin-title">Donor Registry</h1>
    <p class="v3-admin-subtitle">Review donor records, update eligibility, and modify medical profiles.</p>
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

        <% if (donorToEdit != null) { %>
            <div class="v3-table-wrapper reveal" style="margin-bottom: 2rem; padding: 3rem;">
                <h2 style="font-size: 1.25rem; margin-bottom: 1.5rem; color: var(--text-strong);">Edit Donor Record: ID <%= donorToEdit.getDonorId() %></h2>
                <form action="<%= request.getContextPath() %>/manage-donors" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="donorId" value="<%= donorToEdit.getDonorId() %>">
                    
                    <div class="v3-form-row">
                        <div class="v3-form-group">
                            <label>User ID</label>
                            <input type="text" value="<%= donorToEdit.getUserId() %>" readonly style="opacity:0.7;">
                        </div>
                        <div class="v3-form-group">
                            <label for="bloodGroup">Blood Group</label>
                            <select name="bloodGroup" id="bloodGroup" required>
                                <% String[] groups = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
                                   for (String g : groups) { %>
                                    <option value="<%= g %>" <%= g.equals(donorToEdit.getBloodGroup()) ? "selected" : "" %>><%= g %></option>
                                <% } %>
                            </select>
                        </div>
                    </div>

                    <div class="v3-form-row">
                        <div class="v3-form-group">
                            <label for="gender">Gender</label>
                            <select name="gender" id="gender" required>
                                <option value="Male" <%= "Male".equals(donorToEdit.getGender()) ? "selected" : "" %>>Male</option>
                                <option value="Female" <%= "Female".equals(donorToEdit.getGender()) ? "selected" : "" %>>Female</option>
                                <option value="Other" <%= "Other".equals(donorToEdit.getGender()) ? "selected" : "" %>>Other</option>
                            </select>
                        </div>
                        <div class="v3-form-group">
                            <label for="dateOfBirth">Date of Birth</label>
                            <input type="date" name="dateOfBirth" id="dateOfBirth" value="<%= donorToEdit.getDateOfBirth() %>" required>
                        </div>
                    </div>
                    
                    <div class="v3-form-row">
                        <div class="v3-form-group">
                            <label for="address">Address</label>
                            <input type="text" name="address" id="address" value="<%= donorToEdit.getAddress() %>" required>
                        </div>
                        <div class="v3-form-group">
                            <label for="city">City</label>
                            <input type="text" name="city" id="city" value="<%= donorToEdit.getCity() %>" required>
                        </div>
                    </div>

                    <div class="v3-form-row" style="grid-template-columns: 1fr;">
                        <div class="v3-form-group">
                            <label for="eligibilityStatus">Eligibility Status</label>
                            <select name="eligibilityStatus" id="eligibilityStatus">
                                <option value="Eligible" <%= "Eligible".equalsIgnoreCase(donorToEdit.getEligibilityStatus()) ? "selected" : "" %>>Eligible to Donate</option>
                                <option value="Not Eligible" <%= "Not Eligible".equalsIgnoreCase(donorToEdit.getEligibilityStatus()) ? "selected" : "" %>>Not Eligible</option>
                            </select>
                        </div>
                    </div>

                    <div style="display:flex; justify-content:flex-end; gap:16px; margin-top:1rem;">
                        <a href="<%= request.getContextPath() %>/manage-donors" class="btn btn-secondary">Cancel Edit</a>
                        <button type="submit" class="btn btn-primary">Update Record</button>
                    </div>
                </form>
            </div>
        <% } %>

        <div class="v3-toolbar reveal">
            <form action="<%= request.getContextPath() %>/manage-donors" method="get" style="display:flex; gap:1rem; align-items:flex-end;">
                <div class="v3-form-group" style="margin:0;">
                    <label for="bloodGroupFilter">Blood Group</label>
                    <select name="bloodGroup" id="bloodGroupFilter" style="width:180px;">
                        <option value="">All Groups</option>
                        <% 
                           String selectedBg = request.getParameter("bloodGroup");
                           String[] searchGroups = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
                           for(String g : searchGroups) {
                        %>
                            <option value="<%= g %>" <%= g.equals(selectedBg) ? "selected" : "" %>><%= g %></option>
                        <% } %>
                    </select>
                </div>
                <div class="v3-form-group" style="margin:0; flex:1;">
                    <label for="cityFilter">City</label>
                    <input type="text" name="city" id="cityFilter" placeholder="Search by city" value="<%= request.getParameter("city") != null ? request.getParameter("city") : "" %>">
                </div>
                <button type="submit" class="btn btn-primary" style="height:48px;">Search</button>
                <a href="<%= request.getContextPath() %>/manage-donors" class="btn btn-secondary" style="height:48px;">Clear</a>
            </form>
        </div>

        <div class="v3-table-wrapper reveal" style="animation-delay: 0.1s;">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>User ID</th>
                        <th>Blood Group</th>
                        <th>City</th>
                        <th>Eligibility</th>
                        <th style="text-align:right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        if (donorList != null && !donorList.isEmpty()) {
                            for (Donor d : donorList) {
                    %>
                        <tr>
                            <td><span style="font-size:0.85rem; color:var(--text-muted);"><%= d.getDonorId() %></span></td>
                            <td><strong><%= d.getUserId() %></strong></td>
                            <td><span style="color:var(--brand-primary-dark); font-weight:800; font-size:1.1rem;"><%= d.getBloodGroup() %></span></td>
                            <td><%= d.getCity() %></td>
                            <td>
                                <% if ("Eligible".equalsIgnoreCase(d.getEligibilityStatus())) { %>
                                    <span class="badge badge-eligible">Eligible</span>
                                <% } else { %>
                                    <span class="badge badge-not-eligible"><%= d.getEligibilityStatus() %></span>
                                <% } %>
                            </td>
                            <td style="text-align:right;">
                                <a href="?editId=<%= d.getDonorId() %>" class="btn btn-secondary" style="padding: 6px 12px; font-size: 0.8rem;">Edit</a>
                                <form action="<%= request.getContextPath() %>/manage-donors" method="post" style="display:inline;" onsubmit="return confirm('Delete this donor record?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="donorId" value="<%= d.getDonorId() %>">
                                    <button type="submit" class="btn btn-danger" style="padding: 6px 12px; font-size: 0.8rem;">Delete</button>
                                </form>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="6" style="text-align:center; padding:3rem;">No donors found.</td></tr>
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