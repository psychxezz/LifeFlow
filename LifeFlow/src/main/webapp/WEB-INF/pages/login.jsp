<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Login - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="container" style="max-width: 520px; margin-top: 80px;">
    <div class="form-box">
        <h1 class="page-title">LifeFlow Login</h1>
        <p class="page-subtitle">Sign in to access your donor or admin dashboard</p>

        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            String successMessage = (String) request.getAttribute("successMessage");

            if (errorMessage != null) {
        %>
            <div class="message error"><%= errorMessage %></div>
        <%
            }

            if (successMessage != null) {
        %>
            <div class="message success"><%= successMessage %></div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/login" method="post">
            <label for="email">Email</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>

            <label for="password">Password</label>
            <input type="password" id="password" name="password" placeholder="Enter your password" required>

            <button type="submit">Login</button>
        </form>

        <div class="links">
            <a href="<%= request.getContextPath() %>/register">Register</a>
            <a href="<%= request.getContextPath() %>/forgot-password">Forgot Password</a>
        </div>
    </div>
</div>

</body>
</html>