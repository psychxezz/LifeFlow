<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.ContactMessage" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>View Messages - Admin Console</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body style="background: var(--surface-base);">
<%
    User adminUser = (User) session.getAttribute("loggedInUser");
    if (adminUser == null || !"ADMIN".equalsIgnoreCase(adminUser.getRole())) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
%>

<nav class="v3-navbar admin-mode">
    <a class="v3-nav-brand" href="<%= request.getContextPath() %>/admin-dashboard">
        <svg width="28" height="28" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M16 3C16 3 6 12.5 6 19a10 10 0 0 0 20 0C26 12.5 16 3 16 3Z" fill="white"/>
            <path d="M16 10C16 10 10 16.5 10 20a6 6 0 0 0 12 0C22 16.5 16 10 16 10Z" fill="rgba(255,255,255,0.3)"/>
        </svg>
        Command Center
    </a>
    <div class="v3-nav-links" id="navbarLinks">
        <a href="<%= request.getContextPath() %>/home">Platform Home</a>
        <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/manage-users">Users</a>
        <a href="<%= request.getContextPath() %>/manage-donors">Donors</a>
        <a href="<%= request.getContextPath() %>/manage-blood-requests">Requests</a>
        <a href="<%= request.getContextPath() %>/manage-appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/view-messages" class="active">Messages</a>
        <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout" style="background: rgba(255,255,255,0.1); color: white;">Logout</a>
    </div>
</nav>

<div class="v3-admin-header reveal" style="padding: 3rem 5%; padding-bottom: 5rem;">
    <h1 class="v3-admin-title">Support Inbox</h1>
    <p class="v3-admin-subtitle">Review contact submissions from users, donors, and hospitals.</p>
</div>

<main class="v3-data-suite" style="margin-top: -4rem;">
    <div style="max-width: 1400px; margin: 0 auto; position: relative; z-index: 10;">
        
        <%
            String errorMessage   = (String) request.getAttribute("errorMessage");
            String successMessage = (String) request.getAttribute("successMessage");
            if (errorMessage != null) {
        %>
            <div class="v3-message error"><%= errorMessage %></div>
        <% } %>
        <% if (successMessage != null) { %>
            <div class="v3-message success"><%= successMessage %></div>
        <% } %>

        <div class="v3-table-wrapper reveal">
            <table>
                <thead>
                    <tr>
                        <th>Msg ID</th>
                        <th>Sender Info</th>
                        <th>Subject</th>
                        <th style="width: 40%;">Message Content</th>
                        <th style="text-align:right;">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <%
                        List<ContactMessage> msgList = (List<ContactMessage>) request.getAttribute("messages");
                        if (msgList != null && !msgList.isEmpty()) {
                            for (ContactMessage msg : msgList) {
                    %>
                        <tr>
                            <td style="vertical-align:top;"><span style="font-size:0.85rem; color:var(--text-muted);"><%= msg.getMessageId() %></span></td>
                            <td style="vertical-align:top;">
                                <strong><%= msg.getName() %></strong><br>
                                <span style="font-size:0.85rem; color:var(--text-muted);"><%= msg.getEmail() %></span>
                            </td>
                            <td style="vertical-align:top;"><strong><%= msg.getSubject() %></strong></td>
                            <td style="vertical-align:top;">
                                <div style="background: var(--surface-base); padding: 1rem; border-radius: var(--radius-sm); font-size: 0.95rem; color: var(--text-base); white-space: pre-wrap;"><%= msg.getMessage() %></div>
                            </td>
                            <td style="vertical-align:top; text-align:right;">
                                <form action="<%= request.getContextPath() %>/view-messages" method="post" style="display:inline;" onsubmit="return confirm('Dismiss this message?');">
                                    <input type="hidden" name="action" value="delete">
                                    <input type="hidden" name="messageId" value="<%= msg.getMessageId() %>">
                                    <button type="submit" class="btn btn-secondary" style="padding: 6px 12px; font-size: 0.8rem;">Dismiss</button>
                                </form>
                            </td>
                        </tr>
                    <%
                            }
                        } else {
                    %>
                        <tr><td colspan="5" style="text-align:center; padding:4rem 2rem;">
                            <div style="margin-bottom:1rem; opacity:0.5; color:var(--status-success);">
                                <svg width="48" height="48" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
                            </div>
                            <div style="color:var(--text-muted); font-weight:600;">Inbox Zero</div>
                            <div style="color:var(--text-muted); font-size:0.9rem;">There are no new support messages.</div>
                        </td></tr>
                    <% } %>
                </tbody>
            </table>
        </div>

    </div>
</main>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        setTimeout(() => {
            document.querySelectorAll('.reveal').forEach(el => el.classList.add('active'));
        }, 50);
    });
</script>
</body>
</html>