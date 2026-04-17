<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.ContactMessage" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>View Messages - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand"><strong>LifeFlow Admin</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/manage-users">Users</a>
        <a href="<%= request.getContextPath() %>/manage-donors">Donors</a>
        <a href="<%= request.getContextPath() %>/manage-blood-requests">Blood Requests</a>
        <a href="<%= request.getContextPath() %>/manage-appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/view-messages">Messages</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1 class="page-title">Contact Messages</h1>
    <p class="page-subtitle">Review and manage messages submitted by users and visitors</p>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/admin-dashboard">Back to Dashboard</a>
    </div>

    <%
        String successMessage = (String) request.getAttribute("successMessage");
        List<ContactMessage> messages = (List<ContactMessage>) request.getAttribute("messages");

        if (successMessage != null) {
    %>
        <div class="message success"><%= successMessage %></div>
    <%
        }
    %>

    <div class="section">
        <h2 class="section-title">Submitted Messages</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Name</th>
                <th>Email</th>
                <th>Subject</th>
                <th>Message</th>
                <th>Submitted At</th>
                <th>Action</th>
            </tr>

            <%
                if (messages != null && !messages.isEmpty()) {
                    for (ContactMessage msg : messages) {
            %>
            <tr>
                <td><%= msg.getMessageId() %></td>
                <td><%= msg.getName() %></td>
                <td><%= msg.getEmail() %></td>
                <td><%= msg.getSubject() %></td>
                <td class="msg-cell"><%= msg.getMessage() %></td>
                <td><%= msg.getSubmittedAt() %></td>
                <td>
                    <form action="<%= request.getContextPath() %>/view-messages" method="post" style="margin:0;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="messageId" value="<%= msg.getMessageId() %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7">No contact messages found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <div class="footer">
        &copy; 2026 LifeFlow Admin Panel. All rights reserved.
    </div>
</div>

</body>
</html>