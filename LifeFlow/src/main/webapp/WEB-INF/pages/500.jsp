<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Server Error - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body style="background: var(--surface-base); display:flex; align-items:center; justify-content:center; min-height:100vh;">

<%
    com.lifeflow.model.User loggedInUser = (com.lifeflow.model.User) session.getAttribute("loggedInUser");
    boolean isAdmin = loggedInUser != null && "admin".equalsIgnoreCase(loggedInUser.getRole());
    String homeLink = request.getContextPath() + (isAdmin ? "/admin-dashboard" : "/home");
%>

<div class="v3-auth-card reveal" style="text-align:center; padding: 4rem; max-width: 600px; border-top: 4px solid var(--status-critical);">
    <div style="margin-bottom: 2rem; color: var(--status-critical); opacity: 0.8;">
        <svg width="120" height="120" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path><line x1="12" y1="9" x2="12" y2="13"></line><line x1="12" y1="17" x2="12.01" y2="17"></line></svg>
    </div>
    
    <h1 style="font-size: 5rem; line-height: 1; color: var(--text-strong); margin-bottom: 1rem;">500</h1>
    <h2 style="font-size: 1.5rem; margin-bottom: 1rem;">Internal System Error</h2>
    <p style="color: var(--text-muted); font-size: 1.1rem; margin-bottom: 2.5rem;">Our servers encountered an unexpected issue while processing your request. Please try again in a few minutes.</p>
    
    <a href="<%= homeLink %>" class="btn btn-primary" style="padding: 14px 32px;">Return to Safety</a>
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