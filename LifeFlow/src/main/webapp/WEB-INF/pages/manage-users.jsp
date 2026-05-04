<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manage Users - Admin Console</title>
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
        <a href="<%= request.getContextPath() %>/manage-users" class="active">Users</a>
        <a href="<%= request.getContextPath() %>/manage-donors">Donors</a>
        <a href="<%= request.getContextPath() %>/manage-blood-requests">Requests</a>
        <a href="<%= request.getContextPath() %>/manage-appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/view-messages">Messages</a>
        <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout" style="background: rgba(255,255,255,0.1); color: white;">Logout</a>
    </div>
</nav>

<div class="v3-admin-header reveal" style="padding: 3rem 5%; padding-bottom: 5rem;">
    <h1 class="v3-admin-title">User Management</h1>
    <p class="v3-admin-subtitle">Oversight of all registered accounts, roles, and access states.</p>
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
                        <th>ID</th>
                        <th>Full Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Role</th>
                        <th>Status</th>
                        <th style="text-align:right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<User> userList = (List<User>) request.getAttribute("users");
                        if (userList != null && !userList.isEmpty()) {
                            for (User u : userList) {
                    %>
                        <tr>
                            <td><span style="font-size:0.85rem; color:var(--text-muted);"><%= u.getUserId() %></span></td>
                            <td><strong><%= u.getFullName() %></strong></td>
                            <td><%= u.getEmail() %></td>
                            <td><%= u.getPhone() != null ? u.getPhone() : "-" %></td>
                            <td>
                                <% if ("ADMIN".equalsIgnoreCase(u.getRole())) { %>
                                    <span class="badge badge-admin">Admin</span>
                                <% } else { %>
                                    <span class="badge badge-donor">Donor</span>
                                <% } %>
                            </td>
                            <td>
                                <% if (u.isAccountLocked()) { %>
                                    <span class="badge badge-critical">Locked</span>
                                <% } else { %>
                                    <span class="badge badge-open">Active</span>
                                <% } %>
                            </td>
                            <td style="text-align:right;">
                                <% if (adminUser.getUserId() != u.getUserId()) { %>
                                    <form action="<%= request.getContextPath() %>/manage-users" method="post" style="display:inline;" onsubmit="return confirm('Delete this user? This action cannot be undone.');">
                                        <input type="hidden" name="action" value="delete">
                                        <input type="hidden" name="userId" value="<%= u.getUserId() %>">
                                        <button type="submit" class="btn btn-danger" style="padding: 6px 12px; font-size: 0.8rem;">Delete</button>
                                    </form>
                                <% } else { %>
                                    <span style="color:var(--text-muted); font-size:0.85rem; font-weight:600;">Current User</span>
                                <% } %>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="7" style="text-align:center; padding:3rem;">No users found.</td></tr>
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