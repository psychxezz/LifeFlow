<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.lifeflow.model.User" %>
<%@ page import="com.lifeflow.model.Donor" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Profile - LifeFlow Premium</title>
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
        <a href="<%= request.getContextPath() %>/logout" class="v3-nav-logout">Logout</a>
    </div>
</nav>

<div class="v3-profile-container" style="max-width: 800px;">
    
    <div class="v3-page-header reveal" style="padding: 0 0 3rem 0; background: none; border: none;">
        <h1 style="font-size: 2.5rem; margin-bottom: 0.5rem;">Edit Profile</h1>
        <p style="color: var(--text-muted); font-size: 1.1rem;">Update your personal and medical information.</p>
    </div>

    <%
        String errorMessage = (String) request.getAttribute("errorMessage");
        if (errorMessage != null) {
    %>
        <div class="v3-message error reveal"><%= errorMessage %></div>
    <% } %>

    <div class="v3-profile-details reveal" style="animation-delay: 0.1s;">
        <form action="<%= request.getContextPath() %>/edit-profile" method="post">
            
            <h3 style="font-size: 1.25rem; margin-bottom: 2rem; border-bottom: 1px solid var(--border-soft); padding-bottom: 1rem;">
                Account Details
            </h3>
            
            <div class="v3-form-row">
                <div class="v3-form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" value="<%= loggedInUser.getFullName() %>" required>
                </div>
                <div class="v3-form-group">
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" name="phone" value="<%= loggedInUser.getPhone() != null ? loggedInUser.getPhone() : "" %>" required>
                </div>
            </div>
            
            <div class="v3-form-group">
                <label for="email">Email Address</label>
                <input type="email" id="email" value="<%= loggedInUser.getEmail() %>" readonly style="background: var(--surface-base); opacity: 0.7; cursor: not-allowed;">
                <small style="color:var(--text-muted); display:block; margin-top:6px;">Email address is permanently linked to your account identity.</small>
            </div>

            <h3 style="font-size: 1.25rem; margin-top: 3rem; margin-bottom: 2rem; border-bottom: 1px solid var(--border-soft); padding-bottom: 1rem;">
                Medical & Donor Information
            </h3>
            
            <div class="v3-form-row">
                <div class="v3-form-group">
                    <label for="bloodGroup">Blood Group</label>
                    <select id="bloodGroup" name="bloodGroup" required>
                        <option value="">Select blood group</option>
                        <% 
                           String bg = donor != null ? donor.getBloodGroup() : "";
                           String[] groups = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
                           for (String g : groups) {
                        %>
                            <option value="<%= g %>" <%= g.equals(bg) ? "selected" : "" %>><%= g %></option>
                        <% } %>
                    </select>
                </div>
                <div class="v3-form-group">
                    <label for="gender">Gender</label>
                    <select id="gender" name="gender" required>
                        <% String gen = donor != null ? donor.getGender() : ""; %>
                        <option value="">Select gender</option>
                        <option value="Male" <%= "Male".equals(gen) ? "selected" : "" %>>Male</option>
                        <option value="Female" <%= "Female".equals(gen) ? "selected" : "" %>>Female</option>
                        <option value="Other" <%= "Other".equals(gen) ? "selected" : "" %>>Other</option>
                    </select>
                </div>
            </div>

            <div class="v3-form-row" style="grid-template-columns: 1fr;">
                <div class="v3-form-group">
                    <label for="dateOfBirth">Date of Birth</label>
                    <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= donor != null && donor.getDateOfBirth() != null ? donor.getDateOfBirth().toString() : "" %>" required>
                </div>
            </div>

            <div class="v3-form-row">
                <div class="v3-form-group">
                    <label for="city">City</label>
                    <input type="text" id="city" name="city" value="<%= donor != null ? donor.getCity() : "" %>" required>
                </div>
                <div class="v3-form-group">
                    <label for="address">Full Address</label>
                    <input type="text" id="address" name="address" value="<%= donor != null ? donor.getAddress() : "" %>" required>
                </div>
            </div>

            <div style="display:flex; justify-content:flex-end; gap:16px; margin-top: 2rem; padding-top: 2rem; border-top: 1px solid var(--border-soft);">
                <a href="<%= request.getContextPath() %>/profile" class="btn btn-secondary">Cancel</a>
                <button type="submit" class="btn btn-primary" style="padding: 14px 32px;">Save Profile Updates</button>
            </div>
        </form>
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