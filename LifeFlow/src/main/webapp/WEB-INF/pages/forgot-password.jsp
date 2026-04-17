<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>

<div class="container" style="max-width: 520px; margin-top: 80px;">
    <div class="form-box">
        <h1 class="page-title">Forgot Password</h1>
        <p class="page-subtitle">Enter your registered email to continue resetting your password</p>

        <%
            String errorMessage = (String) request.getAttribute("errorMessage");
            if (errorMessage != null) {
        %>
            <div class="message error"><%= errorMessage %></div>
        <%
            }
        %>

        <form action="<%= request.getContextPath() %>/forgot-password" method="post">
            <input type="hidden" name="step" value="verifyEmail">

            <label for="email">Email Address</label>
            <input type="email" id="email" name="email" placeholder="Enter your email" required>

            <button type="submit">Continue</button>
        </form>

        <div class="links">
            <a href="<%= request.getContextPath() %>/login">Back to Login</a>
        </div>
    </div>
</div>

</body>
</html>