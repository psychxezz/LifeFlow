<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lifeflow.model.User" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Command Center - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
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
        <a href="<%= request.getContextPath() %>/admin-dashboard" class="active">Dashboard</a>
        <a href="<%= request.getContextPath() %>/manage-users">Users</a>
        <a href="<%= request.getContextPath() %>/manage-donors">Donors</a>
        <a href="<%= request.getContextPath() %>/manage-blood-requests">Requests</a>
        <a href="<%= request.getContextPath() %>/manage-appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/view-messages">Messages</a>
        <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout" style="background: rgba(255,255,255,0.1); color: white;">Logout</a>
    </div>
</nav>

<header class="v3-admin-header reveal">
    <div style="display:flex; justify-content:space-between; align-items:flex-end;">
        <div>
            <div style="display:inline-flex; align-items:center; gap:8px; padding: 6px 12px; background: rgba(16, 185, 129, 0.2); color: #10B981; border-radius: 20px; font-weight:700; font-size:0.85rem; margin-bottom: 1rem; border: 1px solid rgba(16,185,129,0.3);">
                <div style="width:8px; height:8px; border-radius:50%; background:#10B981; box-shadow: 0 0 8px #10B981;"></div>
                System Operational
            </div>
            <h1 class="v3-admin-title">Admin Dashboard</h1>
            <p class="v3-admin-subtitle">Real-time platform oversight and medical management controls.</p>
        </div>
        <svg width="200" height="100" viewBox="0 0 200 100" fill="none" style="opacity: 0.1;">
            <path d="M0 50 L50 50 L75 20 L100 80 L125 50 L200 50" stroke="white" stroke-width="4" stroke-linejoin="round"/>
        </svg>
    </div>
</header>

<main style="padding-bottom: 5rem;">
    <!-- Overlapping Stats -->
    <div class="v3-admin-stats-grid reveal" style="animation-delay: 0.1s;">
        <div class="v3-stat-card">
            <div class="v3-stat-icon">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path><circle cx="9" cy="7" r="4"></circle><path d="M23 21v-2a4 4 0 0 0-3-3.87"></path><path d="M16 3.13a4 4 0 0 1 0 7.75"></path></svg>
            </div>
            <div>
                <div class="v3-stat-value"><%= request.getAttribute("totalUsers") != null ? request.getAttribute("totalUsers") : "124" %></div>
                <div class="v3-stat-label">Total Users</div>
            </div>
        </div>
        <div class="v3-stat-card">
            <div class="v3-stat-icon" style="color: var(--brand-primary); background: var(--status-critical-bg);">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path></svg>
            </div>
            <div>
                <div class="v3-stat-value"><%= request.getAttribute("totalDonors") != null ? request.getAttribute("totalDonors") : "86" %></div>
                <div class="v3-stat-label">Active Donors</div>
            </div>
        </div>
        <div class="v3-stat-card">
            <div class="v3-stat-icon" style="color: var(--status-warning); background: var(--status-warning-bg);">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><rect x="3" y="4" width="18" height="18" rx="2" ry="2"></rect><line x1="16" y1="2" x2="16" y2="6"></line><line x1="8" y1="2" x2="8" y2="6"></line><line x1="3" y1="10" x2="21" y2="10"></line></svg>
            </div>
            <div>
                <div class="v3-stat-value"><%= request.getAttribute("totalAppointments") != null ? request.getAttribute("totalAppointments") : "42" %></div>
                <div class="v3-stat-label">Appointments</div>
            </div>
        </div>
        <div class="v3-stat-card">
            <div class="v3-stat-icon" style="color: var(--status-info); background: var(--status-info-bg);">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M22 12h-4l-3 9L9 3l-3 9H2"></path></svg>
            </div>
            <div>
                <div class="v3-stat-value"><%= request.getAttribute("totalRequests") != null ? request.getAttribute("totalRequests") : "18" %></div>
                <div class="v3-stat-label">Urgent Requests</div>
            </div>
        </div>
    </div>

    <!-- Management Modules -->
    <div style="max-width: 1400px; margin: 4rem auto 0 auto; padding: 0 5%;">
        <h2 style="font-size: 1.5rem; margin-bottom: 2rem;">System Modules</h2>
        <div class="v3-dashboard-grid reveal" style="animation-delay: 0.2s;">
            <a href="<%= request.getContextPath() %>/manage-users" class="v3-dash-card" style="color: inherit;">
                <h3 style="margin-bottom: 0.5rem; font-size: 1.25rem;">User Management</h3>
                <p style="color: var(--text-muted); font-size: 0.95rem;">Review accounts, manage roles, and handle locked profiles.</p>
                <div style="margin-top:1.5rem; color:var(--brand-primary); font-weight:700; font-size:0.9rem; display:flex; align-items:center; gap:4px;">
                    Access Module <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                </div>
            </a>
            <a href="<%= request.getContextPath() %>/manage-donors" class="v3-dash-card" style="color: inherit;">
                <h3 style="margin-bottom: 0.5rem; font-size: 1.25rem;">Donor Registry</h3>
                <p style="color: var(--text-muted); font-size: 0.95rem;">Update blood groups, edit eligibility statuses, and maintain health records.</p>
                <div style="margin-top:1.5rem; color:var(--brand-primary); font-weight:700; font-size:0.9rem; display:flex; align-items:center; gap:4px;">
                    Access Module <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                </div>
            </a>
            <a href="<%= request.getContextPath() %>/manage-blood-requests" class="v3-dash-card" style="color: inherit;">
                <h3 style="margin-bottom: 0.5rem; font-size: 1.25rem;">Request Dispatch</h3>
                <p style="color: var(--text-muted); font-size: 0.95rem;">Publish critical hospital needs and close fulfilled requests.</p>
                <div style="margin-top:1.5rem; color:var(--brand-primary); font-weight:700; font-size:0.9rem; display:flex; align-items:center; gap:4px;">
                    Access Module <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                </div>
            </a>
            <a href="<%= request.getContextPath() %>/manage-appointments" class="v3-dash-card" style="color: inherit;">
                <h3 style="margin-bottom: 0.5rem; font-size: 1.25rem;">Appointment Schedule</h3>
                <p style="color: var(--text-muted); font-size: 0.95rem;">Approve, reschedule, or cancel incoming donation appointments.</p>
                <div style="margin-top:1.5rem; color:var(--brand-primary); font-weight:700; font-size:0.9rem; display:flex; align-items:center; gap:4px;">
                    Access Module <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                </div>
            </a>
            <a href="<%= request.getContextPath() %>/view-messages" class="v3-dash-card" style="color: inherit;">
                <h3 style="margin-bottom: 0.5rem; font-size: 1.25rem;">Support Inbox</h3>
                <p style="color: var(--text-muted); font-size: 0.95rem;">Review and resolve contact forms submitted by users and hospitals.</p>
                <div style="margin-top:1.5rem; color:var(--brand-primary); font-weight:700; font-size:0.9rem; display:flex; align-items:center; gap:4px;">
                    Access Module <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><line x1="5" y1="12" x2="19" y2="12"></line><polyline points="12 5 19 12 12 19"></polyline></svg>
                </div>
            </a>
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