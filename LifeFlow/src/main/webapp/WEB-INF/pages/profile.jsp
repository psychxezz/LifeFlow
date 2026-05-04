<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lifeflow.model.User" %>
<%@ page import="com.lifeflow.model.Donor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile - LifeFlow Premium</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<%
    User loggedInUser = (User) session.getAttribute("loggedInUser");
    if (loggedInUser == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    Donor donor = (Donor) request.getAttribute("donor");
    String initial = loggedInUser.getFullName().substring(0, 1).toUpperCase();
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
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <a href="<%= request.getContextPath() %>/profile" class="active">Profile</a>
        <a href="<%= request.getContextPath() %>/appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/blood-requests">Blood Requests</a>
        <a href="<%= request.getContextPath() %>/contact">Contact</a>
        <a href="<%= request.getContextPath() %>/about">About</a>
        <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout">Logout</a>
    </div>
</nav>

<div class="v3-profile-container">
    
    <div class="v3-page-header reveal" style="padding: 0 0 3rem 0; background: none; border: none; display: flex; justify-content: space-between; align-items: flex-end;">
        <div>
            <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">My Profile</h1>
            <p style="color: var(--text-muted); font-size: 1.1rem;">Manage your identity and medical eligibility.</p>
        </div>
        <a href="<%= request.getContextPath() %>/edit-profile" class="btn btn-primary">
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="margin-right:8px;"><path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7"></path><path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z"></path></svg>
            Edit Profile
        </a>
    </div>

    <%
        String errorMessage   = (String) request.getAttribute("errorMessage");
        String successMessage = (String) request.getAttribute("successMessage");
        if (errorMessage != null) {
    %>
        <div class="v3-message error reveal"><%= errorMessage %></div>
    <% } %>
    <% if (successMessage != null) { %>
        <div class="v3-message success reveal"><%= successMessage %></div>
    <% } %>

    <div class="v3-profile-grid reveal" style="animation-delay: 0.1s;">
        
        <!-- Identity Sidebar Badge -->
        <div class="v3-profile-badge">
            <div class="v3-avatar-large"><%= initial %></div>
            <h2 style="font-size: 1.5rem; margin-bottom: 0.25rem;"><%= loggedInUser.getFullName() %></h2>
            <p style="color: var(--text-muted); margin-bottom: 1.5rem;"><%= loggedInUser.getEmail() %></p>
            
            <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                <div style="display: flex; align-items: center; justify-content: space-between; padding: 12px 16px; background: var(--surface-base); border-radius: var(--radius-md);">
                    <span style="font-weight: 600; font-size: 0.9rem;">Account Type</span>
                    <span class="badge badge-<%= loggedInUser.getRole().toLowerCase() %>"><%= loggedInUser.getRole() %></span>
                </div>
                
                <% if (donor != null) { %>
                    <div style="display: flex; align-items: center; justify-content: space-between; padding: 12px 16px; background: rgba(211,47,47,0.05); border-radius: var(--radius-md);">
                        <span style="font-weight: 600; font-size: 0.9rem; color: var(--brand-primary);">Blood Group</span>
                        <span style="font-weight: 800; font-size: 1.25rem; color: var(--brand-primary-dark);"><%= donor.getBloodGroup() %></span>
                    </div>
                    <div style="display: flex; align-items: center; justify-content: space-between; padding: 12px 16px; background: var(--surface-base); border-radius: var(--radius-md);">
                        <span style="font-weight: 600; font-size: 0.9rem;">Status</span>
                        <% if ("Eligible".equalsIgnoreCase(donor.getEligibilityStatus())) { %>
                            <span class="badge badge-eligible">Eligible</span>
                        <% } else { %>
                            <span class="badge badge-not-eligible"><%= donor.getEligibilityStatus() %></span>
                        <% } %>
                    </div>
                <% } else { %>
                    <div style="padding: 16px; background: var(--status-warning-bg); border-radius: var(--radius-md); text-align: left;">
                        <span style="font-weight: 700; color: var(--status-warning); font-size: 0.9rem; display: block; margin-bottom: 4px;">Incomplete Profile</span>
                        <p style="font-size: 0.85rem; color: var(--text-muted); margin-bottom: 12px;">You have not set up your donor records.</p>
                        <a href="<%= request.getContextPath() %>/edit-profile" class="btn btn-primary" style="padding: 6px 12px; font-size: 0.8rem;">Complete Profile</a>
                    </div>
                <% } %>
            </div>
        </div>

        <!-- Content Grid -->
        <div class="v3-profile-details">
            <h3 style="font-size: 1.25rem; margin-bottom: 2rem; display: flex; align-items: center; gap: 8px;">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"/><circle cx="12" cy="7" r="4"/></svg>
                Personal Information
            </h3>
            
            <div class="v3-form-row" style="margin-bottom: 2rem;">
                <div>
                    <div style="font-size: 0.85rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px;">Full Name</div>
                    <div style="font-size: 1.1rem; font-weight: 500; color: var(--text-strong);"><%= loggedInUser.getFullName() %></div>
                </div>
                <div>
                    <div style="font-size: 0.85rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px;">Phone Number</div>
                    <div style="font-size: 1.1rem; font-weight: 500; color: var(--text-strong);"><%= loggedInUser.getPhone() != null ? loggedInUser.getPhone() : "Not provided" %></div>
                </div>
            </div>

            <% if (donor != null) { %>
                <hr style="border: none; border-top: 1px solid var(--border-soft); margin: 3rem 0;">
                
                <h3 style="font-size: 1.25rem; margin-bottom: 2rem; display: flex; align-items: center; gap: 8px;">
                    <svg width="24" height="24" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="M16 4C16 4 8 12 8 18a8 8 0 0 0 16 0C24 12 16 4 16 4Z" fill="currentColor"/></svg>
                    Medical & Location Data
                </h3>
                
                <div class="v3-form-row" style="margin-bottom: 2rem;">
                    <div>
                        <div style="font-size: 0.85rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px;">Date of Birth</div>
                        <div style="font-size: 1.1rem; font-weight: 500; color: var(--text-strong);"><%= donor.getDateOfBirth() %></div>
                    </div>
                    <div>
                        <div style="font-size: 0.85rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px;">Gender</div>
                        <div style="font-size: 1.1rem; font-weight: 500; color: var(--text-strong);"><%= donor.getGender() %></div>
                    </div>
                </div>
                
                <div class="v3-form-row">
                    <div>
                        <div style="font-size: 0.85rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px;">City</div>
                        <div style="font-size: 1.1rem; font-weight: 500; color: var(--text-strong);"><%= donor.getCity() %></div>
                    </div>
                    <div>
                        <div style="font-size: 0.85rem; font-weight: 600; color: var(--text-muted); text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 4px;">Address</div>
                        <div style="font-size: 1.1rem; font-weight: 500; color: var(--text-strong);"><%= donor.getAddress() %></div>
                    </div>
                </div>
            <% } %>
            
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