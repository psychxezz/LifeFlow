<%@ page contentType="text/html;charset=UTF-8" language="java" isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body style="background: var(--surface-base); display:flex; align-items:center; justify-content:center; min-height:100vh;">

<%
    com.lifeflow.model.User loggedInUser = (com.lifeflow.model.User) session.getAttribute("loggedInUser");
    boolean isAdmin = loggedInUser != null && "admin".equalsIgnoreCase(loggedInUser.getRole());
    String homeLink = request.getContextPath() + (isAdmin ? "/admin-dashboard" : "/home");
%>

<div class="v3-auth-card reveal" style="text-align:center; padding: 4rem; max-width: 600px;">
    <div style="margin-bottom: 2rem; color: var(--text-muted); opacity: 0.5;">
        <svg width="120" height="120" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.5"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="12"></line><line x1="12" y1="16" x2="12.01" y2="16"></line></svg>
    </div>
    
    <h1 style="font-size: 5rem; line-height: 1; color: var(--text-strong); margin-bottom: 1rem;">404</h1>
    <h2 style="font-size: 1.5rem; margin-bottom: 1rem;">Page Not Found</h2>
    <p style="color: var(--text-muted); font-size: 1.1rem; margin-bottom: 2.5rem;">The medical record, page, or resource you are looking for has been moved or does not exist.</p>
    
    <a href="<%= homeLink %>" class="btn btn-primary" style="padding: 14px 32px;">Return to Dashboard</a>
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