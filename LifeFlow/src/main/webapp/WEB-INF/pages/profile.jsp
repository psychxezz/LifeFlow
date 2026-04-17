<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lifeflow.model.User" %>
<%@ page import="com.lifeflow.model.Donor" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Profile - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<%
    User user = (User) request.getAttribute("user");
    Donor donor = (Donor) request.getAttribute("donor");
    String successMessage = request.getParameter("message");
%>

<div class="navbar">
    <div class="brand"><strong>LifeFlow</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <a href="<%= request.getContextPath() %>/appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/blood-requests">Blood Requests</a>
        <a href="<%= request.getContextPath() %>/contact">Contact</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1 class="page-title">My Profile</h1>
    <p class="page-subtitle">View your personal and donor details in one place</p>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/home">Back to Home</a>
    </div>

    <%
        if (successMessage != null) {
    %>
        <div class="success-message"><%= successMessage %></div>
    <%
        }
    %>

    <div class="profile-box">
        <h2 class="section-title">User Information</h2>

        <div class="row">
            <div class="label">User ID</div>
            <div class="value"><%= user != null ? user.getUserId() : "" %></div>
        </div>

        <div class="row">
            <div class="label">Full Name</div>
            <div class="value"><%= user != null ? user.getFullName() : "" %></div>
        </div>

        <div class="row">
            <div class="label">Email</div>
            <div class="value"><%= user != null ? user.getEmail() : "" %></div>
        </div>

        <div class="row">
            <div class="label">Phone</div>
            <div class="value"><%= user != null ? user.getPhone() : "" %></div>
        </div>

        <div class="row">
            <div class="label">Role</div>
            <div class="value"><%= user != null ? user.getRole() : "" %></div>
        </div>

        <hr>

        <h2 class="section-title">Donor Information</h2>

        <div class="row">
            <div class="label">Donor ID</div>
            <div class="value"><%= donor != null ? donor.getDonorId() : "" %></div>
        </div>

        <div class="row">
            <div class="label">Blood Group</div>
            <div class="value"><%= donor != null ? donor.getBloodGroup() : "" %></div>
        </div>

        <div class="row">
            <div class="label">Gender</div>
            <div class="value"><%= donor != null ? donor.getGender() : "" %></div>
        </div>

        <div class="row">
            <div class="label">Date of Birth</div>
            <div class="value"><%= donor != null ? donor.getDateOfBirth() : "" %></div>
        </div>

        <div class="row">
            <div class="label">Address</div>
            <div class="value"><%= donor != null ? donor.getAddress() : "" %></div>
        </div>

        <div class="row">
            <div class="label">City</div>
            <div class="value"><%= donor != null ? donor.getCity() : "" %></div>
        </div>

        <div class="row">
            <div class="label">Eligibility Status</div>
            <div class="value"><%= donor != null ? donor.getEligibilityStatus() : "" %></div>
        </div>

        <div class="edit-btn-box">
            <a href="<%= request.getContextPath() %>/edit-profile">Edit Profile</a>
        </div>
    </div>

    <div class="footer">
        &copy; 2026 LifeFlow. All rights reserved.
    </div>
</div>

</body>
</html>