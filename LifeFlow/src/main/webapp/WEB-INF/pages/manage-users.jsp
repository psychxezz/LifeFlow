<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand"><strong>LifeFlow Admin</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/manage-users">Users</a>
        <a href="<%= request.getContextPath() %>/manage-donors">Donors</a>
        <a href="<%= request.getContextPath() %>/manage-blood-requests">Blood Requests</a>
        <a href="<%= request.getContextPath() %>/manage-appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/view-messages">Messages</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1 class="page-title">Manage Users</h1>
    <p class="page-subtitle">Search, review, and manage registered user accounts</p>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/admin-dashboard">Back to Dashboard</a>
    </div>

    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String keyword = (String) request.getAttribute("keyword");
        String role = (String) request.getAttribute("role");
        List<User> users = (List<User>) request.getAttribute("users");

        if (successMessage != null) {
    %>
        <div class="message success"><%= successMessage %></div>
    <%
        }
    %>

    <div class="search-box">
        <h2 class="section-title">Search Users</h2>
        <form action="<%= request.getContextPath() %>/manage-users" method="get">
            <div class="search-grid">
                <div>
                    <label for="keyword">Keyword</label>
                    <input type="text" id="keyword" name="keyword"
                           value="<%= keyword != null ? keyword : "" %>"
                           placeholder="Name, email, or phone">
                </div>

                <div>
                    <label for="role">Role</label>
                    <select id="role" name="role">
                        <option value="">All</option>
                        <option value="admin" <%= "admin".equals(role) ? "selected" : "" %>>Admin</option>
                        <option value="donor" <%= "donor".equals(role) ? "selected" : "" %>>Donor</option>
                    </select>
                </div>

                <div>
                    <button type="submit" class="search-btn">Search</button>
                </div>
            </div>
        </form>
    </div>

    <div class="section" style="margin-top: 28px;">
        <h2 class="section-title">User Records</h2>
        <table>
            <tr>
                <th>User ID</th>
                <th>Full Name</th>
                <th>Email</th>
                <th>Phone</th>
                <th>Role</th>
                <th>Failed Attempts</th>
                <th>Locked</th>
                <th>Created At</th>
                <th>Action</th>
            </tr>

            <%
                if (users != null && !users.isEmpty()) {
                    for (User user : users) {
            %>
            <tr>
                <td><%= user.getUserId() %></td>
                <td><%= user.getFullName() %></td>
                <td><%= user.getEmail() %></td>
                <td><%= user.getPhone() %></td>
                <td class="<%= "admin".equalsIgnoreCase(user.getRole()) ? "role-admin" : "role-donor" %>">
                    <%= user.getRole() %>
                </td>
                <td><%= user.getFailedAttempts() %></td>
                <td><%= user.isAccountLocked() ? "Yes" : "No" %></td>
                <td><%= user.getCreatedAt() %></td>
                <td>
                    <form action="<%= request.getContextPath() %>/manage-users" method="post" style="margin:0;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="userId" value="<%= user.getUserId() %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="9">No users found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <div class="footer">
        &copy; 2026 LifeFlow Admin Panel. All rights reserved.
    </div>
</div>

</body>
</html>