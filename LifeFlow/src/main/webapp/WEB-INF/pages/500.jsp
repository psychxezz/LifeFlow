<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>500 - Server Error</title>
   <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <h1>500</h1>
    <p>Something went wrong on the server.</p>
    <a href="<%= request.getContextPath() %>/login">Go to Login</a>
</body>
</html>