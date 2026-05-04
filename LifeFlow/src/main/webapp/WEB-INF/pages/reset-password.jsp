<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Reset Password - LifeFlow Premium</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="v3-auth-layout">
    <!-- Visual Left Panel -->
    <div class="v3-auth-visual reveal">
        <svg class="v3-auth-svg-bg" viewBox="0 0 800 800" xmlns="http://www.w3.org/2000/svg">
            <path d="M0 400C0 179.086 179.086 0 400 0C620.914 0 800 179.086 800 400C800 620.914 620.914 800 400 800C179.086 800 0 620.914 0 400Z" fill="currentColor" opacity="0.1"/>
            <path d="M150 400c0-138 112-250 250-250s250 112 250 250-112 250-250 250S150 538 150 400z" stroke="currentColor" stroke-width="4" fill="none" opacity="0.2"/>
        </svg>
        
        <div class="v3-auth-content" style="margin-bottom: auto;">
            <a href="<%= request.getContextPath() %>/home" style="display:inline-flex; align-items:center; gap:12px; color:white; font-weight:800; font-size:1.5rem; margin-bottom:4rem;">
                <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M16 3C16 3 6 12.5 6 19a10 10 0 0 0 20 0C26 12.5 16 3 16 3Z" fill="white"/>
                    <path d="M16 10C16 10 10 16.5 10 20a6 6 0 0 0 12 0C22 16.5 16 10 16 10Z" fill="rgba(255,255,255,0.3)"/>
                </svg>
                LifeFlow
            </a>
            <h1 style="font-size: 3.5rem; line-height: 1.1; margin-bottom: 1.5rem; color: white;">Account<br><span style="color: rgba(255,255,255,0.6);">Recovery.</span></h1>
            <p style="font-size: 1.25rem; opacity: 0.9; max-width: 400px; line-height: 1.6;">Don't worry, we'll help you get back into your LifeFlow account.</p>
        </div>
    </div>

    <!-- Form Right Panel -->
    <div class="v3-auth-form-container">
        <div class="v3-auth-card reveal" style="animation-delay: 0.1s;">
            <div style="text-align: center; margin-bottom: 2.5rem;">
                <h2 style="font-size: 2rem; margin-bottom: 0.5rem;">Reset Password</h2>
                <p style="color: var(--text-muted);">Create a new password for <%= request.getAttribute("email") %></p>
            </div>

            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %>
                <div class="v3-message error">
                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
                    <%= errorMessage %>
                </div>
            <% } %>

            <form action="<%= request.getContextPath() %>/forgot-password" method="post">
                <input type="hidden" name="action" value="reset">
                <input type="hidden" name="email" value="<%= request.getAttribute("email") %>">
                
                <div class="v3-form-group">
                    <label for="newPassword">New Password</label>
                    <input type="password" id="newPassword" name="newPassword" required>
                </div>
                
                <div class="v3-form-group">
                    <label for="confirmPassword">Confirm Password</label>
                    <input type="password" id="confirmPassword" name="confirmPassword" required>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem; padding: 14px;">Update Password</button>
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