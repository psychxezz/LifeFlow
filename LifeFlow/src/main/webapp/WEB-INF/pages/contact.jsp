<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Contact - LifeFlow</title>
   <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="navbar">
    <div><strong>LifeFlow</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1>Contact Us</h1>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/home">Back to Home</a>
    </div>

    <div class="form-box">
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

        <form action="<%= request.getContextPath() %>/contact" method="post">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" required>

            <label for="subject">Subject</label>
            <input type="text" id="subject" name="subject" required>

            <label for="message">Message</label>
            <textarea id="message" name="message" rows="5" required></textarea>

            <button type="submit">Send Message</button>
        </form>
    </div>
</div>
</body>
</html>