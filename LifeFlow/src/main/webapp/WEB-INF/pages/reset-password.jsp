<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Reset Password - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="container" style="max-width: 520px; margin-top: 80px;">
    <div class="form-box">
        <h1 class="page-title">Reset Password</h1>
        <p class="page-subtitle">Create a new password for your account</p>

        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            String email = (String) request.getAttribute("email");

            if (errorMessage != null) {
        %>
            <div class="message error"><%= errorMessage %></div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/forgot-password" method="post">
            <input type="hidden" name="step" value="resetPassword">
            <input type="hidden" name="email" value="<%= email != null ? email : "" %>">

            <label>Email</label>
            <input type="text" value="<%= email != null ? email : "" %>" readonly>

            <label for="newPassword">New Password</label>
            <input type="password" id="newPassword" name="newPassword" placeholder="Enter new password" required>

            <label for="confirmPassword">Confirm Password</label>
            <input type="password" id="confirmPassword" name="confirmPassword" placeholder="Confirm new password" required>

            <button type="submit">Reset Password</button>
        </form>

        <div class="links">
            <a href="<%= request.getContextPath() %>/login">Back to Login</a>
        </div>
    </div>
</div>

</body>
</html>