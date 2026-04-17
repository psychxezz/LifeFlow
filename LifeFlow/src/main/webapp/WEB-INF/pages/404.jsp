<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>404 - Page Not Found</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <h1>404</h1>
    <p>The page you are looking for was not found.</p>
    <a href="<%= request.getContextPath() %>/login">Go to Login</a>
</body>
</html>