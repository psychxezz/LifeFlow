<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Contact Support - LifeFlow Premium</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    boolean isLoggedIn = (loggedInUser != null);
    boolean isAdmin = isLoggedIn && "admin".equalsIgnoreCase(loggedInUser.getRole());
%>

<nav class="v3-navbar">
    <a class="v3-nav-brand" href="<%= request.getContextPath() %>/home">
        <svg width="28" height="28" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M16 3C16 3 6 12.5 6 19a10 10 0 0 0 20 0C26 12.5 16 3 16 3Z" fill="var(--brand-primary)"/>
            <path d="M16 10C16 10 10 16.5 10 20a6 6 0 0 0 12 0C22 16.5 16 10 16 10Z" fill="var(--brand-primary-light)"/>
        </svg>
        LifeFlow
    </a>
    <div class="v3-nav-links" id="navbarLinks">
        <% if (isAdmin) { %>
            <a href="<%= request.getContextPath() %>/admin-dashboard">Admin Dashboard</a>
        <% } %>
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <% if (isLoggedIn) { %>
            <a href="<%= request.getContextPath() %>/profile">Profile</a>
            <a href="<%= request.getContextPath() %>/appointments">Appointments</a>
            <a href="<%= request.getContextPath() %>/blood-requests">Blood Requests</a>
        <% } %>
        <a href="<%= request.getContextPath() %>/about">About</a>
        <a href="<%= request.getContextPath() %>/contact" class="active">Contact</a>
        
        <% if (isLoggedIn) { %>
            <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout">Logout</a>
        <% } else { %>
            <a href="<%= request.getContextPath() %>/login" class="btn btn-secondary">Login</a>
            <a href="<%= request.getContextPath() %>/register" class="btn btn-primary">Register</a>
        <% } %>
    </div>
</nav>

<div class="v3-auth-layout">
    <!-- Contact Info Visual -->
    <div class="v3-auth-visual reveal" style="background: var(--surface-panel); color: var(--text-strong); padding: 4rem 5%; justify-content: center; border-right: 1px solid var(--border-soft);">
        <div style="max-width: 500px;">
            <div style="display:inline-flex; align-items:center; justify-content:center; width: 64px; height: 64px; background: var(--status-info-bg); color: var(--status-info); border-radius: 16px; margin-bottom: 2rem;">
                <svg width="32" height="32" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z"></path></svg>
            </div>
            <h1 style="font-size: 3rem; margin-bottom: 1.5rem;">Get in touch.</h1>
            <p style="font-size: 1.25rem; color: var(--text-muted); margin-bottom: 3rem;">Whether you are a hospital needing urgent supplies or a donor with a question, our support team is available 24/7.</p>
            
            <div style="display: flex; flex-direction: column; gap: 1.5rem;">
                <div style="display: flex; gap: 1rem; align-items: center;">
                    <div style="width: 48px; height: 48px; border-radius: 50%; background: var(--surface-base); display: flex; align-items: center; justify-content: center;">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--brand-primary)" stroke-width="2"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                    </div>
                    <div>
                        <div style="font-weight: 700;">Emergency Line</div>
                        <div style="color: var(--text-muted);">1-800-LIFE-FLOW</div>
                    </div>
                </div>
                <div style="display: flex; gap: 1rem; align-items: center;">
                    <div style="width: 48px; height: 48px; border-radius: 50%; background: var(--surface-base); display: flex; align-items: center; justify-content: center;">
                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--brand-primary)" stroke-width="2"><path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"></path><polyline points="22,6 12,13 2,6"></polyline></svg>
                    </div>
                    <div>
                        <div style="font-weight: 700;">Email Support</div>
                        <div style="color: var(--text-muted);">support@lifeflow.com</div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Contact Form -->
    <div class="v3-auth-form-container">
        <div class="v3-auth-card reveal" style="animation-delay: 0.1s; max-width: 600px; box-shadow: none; border: 1px solid var(--border-soft);">
            <h2 style="font-size: 2rem; margin-bottom: 2rem;">Send a Message</h2>
            
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                String successMessage = (String) request.getAttribute("successMessage");
                if (errorMessage != null) {
            %>
                <div class="v3-message error"><%= errorMessage %></div>
            <% } %>
            <% if (successMessage != null) { %>
                <div class="v3-message success"><%= successMessage %></div>
            <% } %>

            <form action="<%= request.getContextPath() %>/contact" method="post">
                <div class="v3-form-row">
                    <div class="v3-form-group">
                        <label for="name">Full Name</label>
                        <input type="text" id="name" name="name" required>
                    </div>
                    <div class="v3-form-group">
                        <label for="email">Email Address</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                </div>
                <div class="v3-form-group">
                    <label for="subject">Subject</label>
                    <input type="text" id="subject" name="subject" required>
                </div>
                <div class="v3-form-group">
                    <label for="message">Message</label>
                    <textarea id="message" name="message" rows="6" required style="resize: vertical;"></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: auto; padding: 14px 32px;">Submit Message</button>
            </form>
        </div>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        setTimeout(() => {
            document.querySelectorAll('.reveal').forEach(el => el.classList.add('active'));
        }, 50);
    });
</script>
</body>
</html>