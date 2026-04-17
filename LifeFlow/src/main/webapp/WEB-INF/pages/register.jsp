<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Register - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="container" style="max-width: 760px; margin-top: 60px;">
    <div class="form-box">
        <h1 class="page-title">Create Donor Account</h1>
        <p class="page-subtitle">Register to join the LifeFlow Blood Donation Management System</p>

        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="message error"><%= errorMessage %></div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/register" method="post">
            <label for="fullName">Full Name</label>
            <input type="text" id="fullName" name="fullName" placeholder="Enter your full name" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email address" required>

            <label for="phone">Phone</label>
            <input type="text" id="phone" name="phone" placeholder="Enter your phone number" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Create a password" required>

            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Re-enter your password" required>

            <label for="bloodGroup">Blood Group</label>
            <select id="bloodGroup" name="bloodGroup" required>
                <option value="">Select blood group</option>
                <option value="A+">A+</option>
                <option value="A-">A-</option>
                <option value="B+">B+</option>
                <option value="B-">B-</option>
                <option value="AB+">AB+</option>
                <option value="AB-">AB-</option>
                <option value="O+">O+</option>
                <option value="O-">O-</option>
            </select>

            <label for="gender">Gender</label>
            <select id="gender" name="gender" required>
                <option value="">Select gender</option>
                <option value="Male">Male</option>
                <option value="Female">Female</option>
                <option value="Other">Other</option>
            </select>

            <label for="dateOfBirth">Date of Birth</label>
            <input type="date" id="dateOfBirth" name="dateOfBirth" required>

            <label for="address">Address</label>
            <textarea id="address" name="address" rows="3" placeholder="Enter your address" required></textarea>

            <label for="city">City</label>
            <input type="text" id="city" name="city" placeholder="Enter your city" required>

            <button type="submit">Register</button>
        </form>

        <div class="links">
            <a href="<%= request.getContextPath() %>/login">Already have an account? Login</a>
        </div>
    </div>
</div>

</body>
</html>