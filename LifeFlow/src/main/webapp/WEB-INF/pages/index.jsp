<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>LifeFlow Premium</title>
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
        <a href="<%= request.getContextPath() %>/home" class="active">Home</a>
        <% if (isLoggedIn) { %>
            <a href="<%= request.getContextPath() %>/profile">Profile</a>
            <a href="<%= request.getContextPath() %>/appointments">Appointments</a>
            <a href="<%= request.getContextPath() %>/blood-requests">Blood Requests</a>
        <% } %>
        <a href="<%= request.getContextPath() %>/about">About</a>
        <a href="<%= request.getContextPath() %>/contact">Contact</a>
        
        <% if (isLoggedIn) { %>
            <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout">Logout</a>
        <% } else { %>
            <a href="<%= request.getContextPath() %>/login" class="btn btn-secondary">Login</a>
            <a href="<%= request.getContextPath() %>/register" class="btn btn-primary">Register</a>
        <% } %>
    </div>
</nav>

<!-- CINEMATIC HERO -->
<section class="v3-home-hero reveal">
    <div class="v3-hero-text">
        <div style="display:inline-flex; align-items:center; gap:8px; padding: 6px 12px; background: rgba(211,47,47,0.1); color: var(--brand-primary); border-radius: 20px; font-weight:700; font-size:0.85rem; margin-bottom: 1.5rem;">
            <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
            System Active
        </div>
        <% if (isLoggedIn) { %>
            <h1>Welcome back,<br><%= loggedInUser.getFullName() %>.</h1>
            <p>Access your dashboard to schedule appointments, track your donations, and respond to critical blood requests.</p>
        <% } else { %>
            <h1>Every drop is<br>a <span class="v3-text-gradient">second chance.</span></h1>
            <p>Join the premier digital healthcare network connecting heroes with patients who urgently need them.</p>
            <div style="display:flex; gap:16px;">
                <a href="<%= request.getContextPath() %>/register" class="btn btn-primary">Become a Donor</a>
                <a href="<%= request.getContextPath() %>/about" class="btn btn-secondary">Learn More</a>
            </div>
        <% } %>
    </div>
    
    <div class="v3-hero-visual">
        <svg class="v3-hero-illustration" viewBox="0 0 500 500" fill="none" xmlns="http://www.w3.org/2000/svg">
            <circle cx="250" cy="250" r="200" fill="white" style="filter: drop-shadow(0 20px 40px rgba(0,0,0,0.05));"/>
            <path d="M250 80C250 80 120 200 120 300C120 371.797 178.203 430 250 430C321.797 430 380 371.797 380 300C380 200 250 80 250 80Z" fill="url(#hero-grad)"/>
            <path d="M250 180C250 180 180 250 180 310C180 348.66 211.34 380 250 380C288.66 380 320 348.66 320 310C320 250 250 180 250 180Z" fill="white" opacity="0.4"/>
            <path d="M150 250H200L220 180L270 320L300 250H350" stroke="white" stroke-width="8" stroke-linecap="round" stroke-linejoin="round"/>
            <defs>
                <linearGradient id="hero-grad" x1="250" y1="80" x2="250" y2="430" gradientUnits="userSpaceOnUse">
                    <stop stop-color="var(--brand-primary-light)"/>
                    <stop offset="1" stop-color="var(--brand-primary-dark)"/>
                </linearGradient>
            </defs>
        </svg>
    </div>
</section>

<% if (isLoggedIn) { %>
    <!-- DASHBOARD MODULES -->
    <section class="v3-section">
        <div style="max-width: 1400px; margin: 0 auto;">
            <h2 style="font-size: 2rem; margin-bottom: 2rem;">Quick Actions</h2>
            <div class="v3-dashboard-grid reveal">
                
                <a href="<%= request.getContextPath() %>/profile" class="v3-dash-card" style="color: inherit;">
                    <div class="v3-dash-icon">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                    </div>
                    <h3 style="margin-bottom: 0.5rem;">My Profile</h3>
                    <p style="color: var(--text-muted); font-size: 0.95rem;">Manage your identity, blood group, and medical eligibility.</p>
                </a>

                <a href="<%= request.getContextPath() %>/appointments" class="v3-dash-card" style="color: inherit;">
                    <div class="v3-dash-icon" style="background: var(--status-info-bg); color: var(--status-info);">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
                    </div>
                    <h3 style="margin-bottom: 0.5rem;">Appointments</h3>
                    <p style="color: var(--text-muted); font-size: 0.95rem;">Schedule and track your upcoming blood donation sessions.</p>
                </a>

                <a href="<%= request.getContextPath() %>/blood-requests" class="v3-dash-card" style="color: inherit;">
                    <div class="v3-dash-icon" style="background: var(--status-warning-bg); color: var(--status-warning);">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 12h-4l-3 9L9 3l-3 9H2"></path></svg>
                    </div>
                    <h3 style="margin-bottom: 0.5rem;">Urgent Requests</h3>
                    <p style="color: var(--text-muted); font-size: 0.95rem;">View active blood requests from local hospitals and patients.</p>
                </a>

            </div>
        </div>
    </section>
<% } else { %>
    <!-- PLATFORM HIGHLIGHTS -->
    <section class="v3-section" style="background: white;">
        <div style="max-width: 1400px; margin: 0 auto;">
            <div style="text-align: center; margin-bottom: 4rem;">
                <h2 style="font-size: 2.5rem; margin-bottom: 1rem;">Why LifeFlow?</h2>
                <p style="font-size: 1.1rem; color: var(--text-muted); max-width: 600px; margin: 0 auto;">A fully integrated medical suite designed to ensure absolute safety, speed, and reliability in the donation process.</p>
            </div>
            
            <div class="v3-dashboard-grid reveal">
                <div class="v3-dash-card">
                    <div class="v3-dash-icon" style="background: var(--status-success-bg); color: var(--status-success);">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path></svg>
                    </div>
                    <h3 style="margin-bottom: 0.5rem;">Secure & Private</h3>
                    <p style="color: var(--text-muted); font-size: 0.95rem;">End-to-end encryption ensures your medical data and donor history remain completely confidential.</p>
                </div>
                <div class="v3-dash-card">
                    <div class="v3-dash-icon" style="background: var(--status-info-bg); color: var(--status-info);">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><circle cx="12" cy="12" r="10"></circle><polyline points="12 6 12 12 16 14"></polyline></svg>
                    </div>
                    <h3 style="margin-bottom: 0.5rem;">Real-Time Tracking</h3>
                    <p style="color: var(--text-muted); font-size: 0.95rem;">Instantly view local hospital requests and critical shortages the second they happen.</p>
                </div>
                <div class="v3-dash-card">
                    <div class="v3-dash-icon" style="background: var(--status-warning-bg); color: var(--status-warning);">
                        <svg width="28" height="28" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z"></path><polyline points="14 2 14 8 20 8"></polyline><line x1="16" y1="13" x2="8" y2="13"></line><line x1="16" y1="17" x2="8" y2="17"></line><polyline points="10 9 9 9 8 9"></polyline></svg>
                    </div>
                    <h3 style="margin-bottom: 0.5rem;">Medical Profiles</h3>
                    <p style="color: var(--text-muted); font-size: 0.95rem;">Manage eligibility parameters, appointment history, and comprehensive health profiles.</p>
                </div>
            </div>
        </div>
    </section>
<% } %>

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