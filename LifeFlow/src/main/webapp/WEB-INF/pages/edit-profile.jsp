<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lifeflow.model.User" %>
<%@ page import="com.lifeflow.model.Donor" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Profile - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<%
    User user = (User) request.getAttribute("user");
    Donor donor = (Donor) request.getAttribute("donor");
%>

<div class="navbar">
    <div class="brand"><strong>LifeFlow</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <a href="<%= request.getContextPath() %>/profile">Profile</a>
        <a href="<%= request.getContextPath() %>/appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/blood-requests">Blood Requests</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container" style="max-width: 760px;">
    <h1 class="page-title">Edit Profile</h1>
    <p class="page-subtitle">Update your personal and donor details</p>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/profile">Back to Profile</a>
    </div>

    <div class="form-box">
        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="message error"><%= errorMessage %></div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/edit-profile" method="post">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName"
                   value="<%= user != null ? user.getFullName() : "" %>" required>

            <label for="phone">Phone</label>
            <input type="text" id="phone" name="phone"
                   value="<%= user != null ? user.getPhone() : "" %>" required>

            <label for="bloodGroup">Blood Group</label>
            <select id="bloodGroup" name="bloodGroup" required>
                <option value="A+" <%= donor != null && "A+".equals(donor.getBloodGroup()) ? "selected" : "" %>>A+</option>
                <option value="A-" <%= donor != null && "A-".equals(donor.getBloodGroup()) ? "selected" : "" %>>A-</option>
                <option value="B+" <%= donor != null && "B+".equals(donor.getBloodGroup()) ? "selected" : "" %>>B+</option>
                <option value="B-" <%= donor != null && "B-".equals(donor.getBloodGroup()) ? "selected" : "" %>>B-</option>
                <option value="AB+" <%= donor != null && "AB+".equals(donor.getBloodGroup()) ? "selected" : "" %>>AB+</option>
                <option value="AB-" <%= donor != null && "AB-".equals(donor.getBloodGroup()) ? "selected" : "" %>>AB-</option>
                <option value="O+" <%= donor != null && "O+".equals(donor.getBloodGroup()) ? "selected" : "" %>>O+</option>
                <option value="O-" <%= donor != null && "O-".equals(donor.getBloodGroup()) ? "selected" : "" %>>O-</option>
            </select>

            <label for="gender">Gender</label>
            <select id="gender" name="gender" required>
                <option value="Male" <%= donor != null && "Male".equals(donor.getGender()) ? "selected" : "" %>>Male</option>
                <option value="Female" <%= donor != null && "Female".equals(donor.getGender()) ? "selected" : "" %>>Female</option>
                <option value="Other" <%= donor != null && "Other".equals(donor.getGender()) ? "selected" : "" %>>Other</option>
            </select>

            <label for="dateOfBirth">Date of Birth</label>
            <input type="date" id="dateOfBirth" name="dateOfBirth"
                   value="<%= donor != null ? donor.getDateOfBirth() : "" %>" required>

            <label for="address">Address</label>
            <textarea id="address" name="address" rows="3" required><%= donor != null ? donor.getAddress() : "" %></textarea>

            <label for="city">City</label>
            <input type="text" id="city" name="city"
                   value="<%= donor != null ? donor.getCity() : "" %>" required>

            <button type="submit">Update Profile</button>
        </form>
    </div>

    <div class="footer">
        &copy; 2026 LifeFlow. All rights reserved.
    </div>
</div>

</body>
</html>