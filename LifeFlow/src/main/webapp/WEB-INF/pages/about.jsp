<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>About - LifeFlow</title>
   <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="navbar">
    <div><strong>LifeFlow</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <a href="<%= request.getContextPath() %>/contact">Contact</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">
    <div class="box">
        <h1>About LifeFlow</h1>
        <p>
            LifeFlow is a Blood Donation Management System designed to improve the management
            of donor information, blood requests, appointments, and communication between
            donors and administrators.
        </p>

        <h2>Purpose</h2>
        <p>
            The purpose of this system is to provide a secure and user-friendly platform
            for managing blood donation activities in a more organized and efficient way.
        </p>

        <h2>Key Features</h2>
        <p>
            The system supports donor registration, login, profile viewing, appointment booking,
            blood request viewing, contact message submission, and admin-side management of
            users, donors, appointments, blood requests, and messages.
        </p>

        <h2>Target Users</h2>
        <p>
            LifeFlow is intended for blood donors and system administrators who need a centralised
            web-based platform for managing donation-related activities.
        </p>
    </div>
</div>
</body>
</html>