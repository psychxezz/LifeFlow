<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Home - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<%
    User user = (User) session.getAttribute("loggedInUser");
    String userName = user != null ? user.getFullName() : "Guest";
%>

<div class="navbar">
    <div class="brand"><strong>LifeFlow</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <a href="<%= request.getContextPath() %>/profile">Profile</a>
        <a href="<%= request.getContextPath() %>/appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/blood-requests">Blood Requests</a>
        <a href="<%= request.getContextPath() %>/contact">Contact</a>
        <a href="<%= request.getContextPath() %>/about">About</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">
    <div class="hero">
        <h1>Welcome, <%= userName %></h1>
        <p>
            LifeFlow helps donors manage appointments, view urgent blood requests,
            maintain donor information, and stay connected with the blood donation system
            through a clean and secure platform.
        </p>
    </div>

    <div class="cards">
        <div class="card">
            <h3>My Profile</h3>
            <p>View and manage your donor information, personal details, and eligibility status.</p>
            <p>
                <a class="btn-primary" href="<%= request.getContextPath() %>/profile">Open Profile</a>
            </p>
        </div>

        <div class="card">
            <h3>Appointments</h3>
            <p>Book donation appointments, review your upcoming schedule, and track status updates.</p>
            <p>
                <a class="btn-primary" href="<%= request.getContextPath() %>/appointments">Open Appointments</a>
            </p>
        </div>

        <div class="card">
            <h3>Blood Requests</h3>
            <p>Browse current blood requests and search by blood group, hospital, or city.</p>
            <p>
                <a class="btn-primary" href="<%= request.getContextPath() %>/blood-requests">Open Blood Requests</a>
            </p>
        </div>

        <div class="card">
            <h3>Contact Support</h3>
            <p>Send questions, issues, or support requests directly to the system administrators.</p>
            <p>
                <a class="btn-primary" href="<%= request.getContextPath() %>/contact">Open Contact</a>
            </p>
        </div>

        <div class="card">
            <h3>About LifeFlow</h3>
            <p>Learn more about the purpose, features, and users of the LifeFlow platform.</p>
            <p>
                <a class="btn-primary" href="<%= request.getContextPath() %>/about">Open About</a>
            </p>
        </div>

        <div class="card">
            <h3>Quick Access</h3>
            <p>Use the navigation bar above to move quickly between donor tools and account actions.</p>
            <p>
                <a class="btn-secondary" href="<%= request.getContextPath() %>/logout">Secure Logout</a>
            </p>
        </div>
    </div>

    <div class="footer">
        &copy; 2026 LifeFlow. All rights reserved.
    </div>
</div>

</body>
</html>