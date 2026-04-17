<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<%
    User adminUser = (User) session.getAttribute("loggedInUser");
    String adminName = adminUser != null ? adminUser.getFullName() : "Admin";
%>

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
    <div class="hero">
        <h1>Welcome, <%= adminName %></h1>
        <p>
            Monitor the platform, review system activity, and manage donors, appointments,
            blood requests, and contact messages from one central dashboard.
        </p>
    </div>

    <div class="card-grid">
        <div class="card">
            <h2>Total Users</h2>
            <div class="count"><%= request.getAttribute("totalUsers") %></div>
            <p>Registered accounts in the LifeFlow system.</p>
        </div>

        <div class="card">
            <h2>Total Donors</h2>
            <div class="count"><%= request.getAttribute("totalDonors") %></div>
            <p>Donor profiles currently stored in the database.</p>
        </div>

        <div class="card">
            <h2>Appointments</h2>
            <div class="count"><%= request.getAttribute("totalAppointments") %></div>
            <p>Donation appointments tracked by the system.</p>
        </div>

        <div class="card">
            <h2>Blood Requests</h2>
            <div class="count"><%= request.getAttribute("totalBloodRequests") %></div>
            <p>Open, active, and closed blood requests.</p>
        </div>

        <div class="card">
            <h2>Contact Messages</h2>
            <div class="count"><%= request.getAttribute("totalContactMessages") %></div>
            <p>Messages received from users and visitors.</p>
        </div>
    </div>

    <div class="section" style="margin-top: 28px;">
        <h2 class="section-title">Quick Management Links</h2>
        <p class="subtitle" style="text-align:left; margin-bottom:18px;">
            Jump directly into the main admin tools.
        </p>

        <div class="quick-links">
            <a href="<%= request.getContextPath() %>/manage-users">Manage Users</a>
            <a href="<%= request.getContextPath() %>/manage-donors">Manage Donors</a>
            <a href="<%= request.getContextPath() %>/manage-blood-requests">Manage Blood Requests</a>
            <a href="<%= request.getContextPath() %>/manage-appointments">Manage Appointments</a>
            <a href="<%= request.getContextPath() %>/view-messages">View Messages</a>
        </div>
    </div>

    <div class="footer">
        &copy; 2026 LifeFlow Admin Panel. All rights reserved.
    </div>
</div>

</body>
</html>