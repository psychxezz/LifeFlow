<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>About Us - LifeFlow Premium</title>
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
        <a href="<%= request.getContextPath() %>/about" class="active">About</a>
        <a href="<%= request.getContextPath() %>/contact">Contact</a>
        
        <% if (isLoggedIn) { %>
            <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout">Logout</a>
        <% } else { %>
            <a href="<%= request.getContextPath() %>/login" class="btn btn-secondary">Login</a>
            <a href="<%= request.getContextPath() %>/register" class="btn btn-primary">Register</a>
        <% } %>
    </div>
</nav>

<section class="v3-home-hero reveal" style="min-height: 60vh; background: linear-gradient(180deg, var(--surface-panel), var(--surface-base));">
    <div class="v3-hero-text" style="text-align: center; max-width: 800px; margin: 0 auto; grid-column: 1 / -1;">
        <h1 style="font-size: 3.5rem; margin-bottom: 1.5rem;">The Modern Network for <span class="v3-text-gradient">Blood Donation.</span></h1>
        <p style="font-size: 1.25rem; color: var(--text-muted); margin: 0 auto 2.5rem auto;">We bridge the gap between voluntary donors and critical patient needs through an intuitive, secure, and rapid digital platform.</p>
    </div>
</section>

<section class="v3-section" style="padding-top: 0;">
    <div style="max-width: 1200px; margin: 0 auto;">
        <!-- Alternating Section 1 -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; align-items: center; margin-bottom: 6rem;" class="reveal">
            <div>
                <h2 style="font-size: 2.5rem; margin-bottom: 1.5rem; color: var(--text-strong);">Empowering the Medical Community.</h2>
                <p style="font-size: 1.1rem; color: var(--text-muted); margin-bottom: 1.5rem;">LifeFlow was established to eliminate the inefficiencies of traditional blood banks. By creating a direct, real-time connection between hospitals and registered donors, we ensure that critical shortages are resolved in minutes, not days.</p>
                <div style="display: flex; gap: 1rem; flex-wrap: wrap;">
                    <div style="display:flex; align-items:center; gap:8px; font-weight:600;"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--brand-primary)" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg> Real-time Alerts</div>
                    <div style="display:flex; align-items:center; gap:8px; font-weight:600;"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--brand-primary)" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg> Verified Profiles</div>
                    <div style="display:flex; align-items:center; gap:8px; font-weight:600;"><svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="var(--brand-primary)" stroke-width="2"><polyline points="20 6 9 17 4 12"></polyline></svg> Secure Data</div>
                </div>
            </div>
            <div style="background: var(--surface-panel); border-radius: var(--radius-xl); padding: 4rem; box-shadow: var(--shadow-lg); text-align: center;">
                <svg width="100%" height="200" viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <circle cx="100" cy="100" r="80" fill="var(--status-info-bg)"/>
                    <path d="M100 50 L120 90 L160 100 L120 110 L100 150 L80 110 L40 100 L80 90 Z" fill="var(--status-info)"/>
                    <circle cx="100" cy="100" r="30" fill="white" style="filter: drop-shadow(0 4px 8px rgba(0,0,0,0.1));"/>
                </svg>
            </div>
        </div>

        <!-- Alternating Section 2 -->
        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 4rem; align-items: center;" class="reveal">
            <div style="background: var(--surface-panel); border-radius: var(--radius-xl); padding: 4rem; box-shadow: var(--shadow-lg); text-align: center; order: -1;">
                <svg width="100%" height="200" viewBox="0 0 200 200" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <rect x="40" y="40" width="120" height="120" rx="20" fill="var(--status-success-bg)"/>
                    <path d="M100 70 V130 M70 100 H130" stroke="var(--status-success)" stroke-width="12" stroke-linecap="round"/>
                </svg>
            </div>
            <div>
                <h2 style="font-size: 2.5rem; margin-bottom: 1.5rem; color: var(--text-strong);">Data Security First.</h2>
                <p style="font-size: 1.1rem; color: var(--text-muted);">As a healthcare platform, the integrity and confidentiality of your medical data is our highest priority. LifeFlow employs end-to-end encryption and strict role-based access control to ensure that only authorized medical personnel can view sensitive donor registries.</p>
            </div>
        </div>
    </div>
</section>

<footer style="background: var(--surface-panel); border-top: 1px solid var(--border-soft); padding: 4rem 5%; text-align: center; color: var(--text-muted);">
    <p>&copy; 2026 LifeFlow Healthcare Platform. All rights reserved.</p>
</footer>

<script>
    document.addEventListener("DOMContentLoaded", () => {
        setTimeout(() => {
            document.querySelectorAll('.reveal').forEach(el => el.classList.add('active'));
        }, 50);
    });
</script>
</body>
</html>