<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register - LifeFlow Premium</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="v3-auth-layout">
    <!-- Visual Left Panel -->
    <div class="v3-auth-visual reveal">
        <svg class="v3-auth-svg-bg" viewBox="0 0 800 800" xmlns="http://www.w3.org/2000/svg">
            <path d="M0 400C0 179.086 179.086 0 400 0C620.914 0 800 179.086 800 400C800 620.914 620.914 800 400 800C179.086 800 0 620.914 0 400Z" fill="currentColor" opacity="0.1"/>
            <path d="M150 400c0-138 112-250 250-250s250 112 250 250-112 250-250 250S150 538 150 400z" stroke="currentColor" stroke-width="4" fill="none" opacity="0.2"/>
            <path d="M100 400L250 400L300 300L400 600L450 350L500 400L700 400" stroke="currentColor" stroke-width="8" stroke-linecap="round" stroke-linejoin="round" fill="none" opacity="0.3"/>
        </svg>
        
        <div class="v3-auth-content" style="margin-bottom: auto;">
            <a href="<%= request.getContextPath() %>/home" style="display:inline-flex; align-items:center; gap:12px; color:white; font-weight:800; font-size:1.5rem; margin-bottom:4rem;">
                <svg width="32" height="32" viewBox="0 0 32 32" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M16 3C16 3 6 12.5 6 19a10 10 0 0 0 20 0C26 12.5 16 3 16 3Z" fill="white"/>
                    <path d="M16 10C16 10 10 16.5 10 20a6 6 0 0 0 12 0C22 16.5 16 10 16 10Z" fill="rgba(255,255,255,0.3)"/>
                </svg>
                LifeFlow
            </a>
            <h1 style="font-size: 3.5rem; line-height: 1.1; margin-bottom: 1.5rem; color: white;">Become a<br><span style="color: rgba(255,255,255,0.6);">Life Saver.</span></h1>
            <p style="font-size: 1.25rem; opacity: 0.9; max-width: 400px; line-height: 1.6;">Register to track your donations, schedule appointments, and respond to urgent blood requests in your city.</p>
        </div>

        <div class="v3-auth-content" style="display:flex; gap: 1rem;">
            <div style="background: rgba(255,255,255,0.1); padding: 1.5rem; border-radius: var(--radius-lg); backdrop-filter: blur(8px); border: 1px solid rgba(255,255,255,0.2);">
                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" style="margin-bottom:8px;"><path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z"></path></svg>
                <div style="font-weight: 700; font-size: 1.1rem;">Impact Community</div>
                <div style="font-size: 0.85rem; opacity: 0.8;">One donation can save up to 3 lives.</div>
            </div>
        </div>
    </div>

    <!-- Form Right Panel -->
    <div class="v3-auth-form-container" style="padding: 4rem 2rem;">
        <div class="v3-auth-card reveal" style="animation-delay: 0.1s; max-width: 500px;">
            <div style="text-align: center; margin-bottom: 2.5rem;">
                <h2 style="font-size: 2rem; margin-bottom: 0.5rem;">Create Account</h2>
                <p style="color: var(--text-muted);">Please fill out the form below to register.</p>
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

            <form action="<%= request.getContextPath() %>/register" method="post">
                <div class="v3-form-group">
                    <label for="fullName">Full Name</label>
                    <input type="text" id="fullName" name="fullName" required>
                </div>
                
                <div class="v3-form-row">
                    <div class="v3-form-group">
                        <label for="email">Email</label>
                        <input type="email" id="email" name="email" required>
                    </div>
                    <div class="v3-form-group">
                        <label for="phone">Phone</label>
                        <input type="tel" id="phone" name="phone" required>
                    </div>
                </div>

                <div class="v3-form-row">
                    <div class="v3-form-group">
                        <label for="password">Password</label>
                        <input type="password" id="password" name="password" required>
                    </div>
                    <div class="v3-form-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" required>
                    </div>
                </div>

                <div class="v3-form-row">
                    <div class="v3-form-group">
                        <label for="bloodGroup">Blood Group</label>
                        <select id="bloodGroup" name="bloodGroup" required>
                            <option value="">Select</option>
                            <% String[] groups = {"A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"};
                               for (String g : groups) { %>
                                <option value="<%= g %>"><%= g %></option>
                            <% } %>
                        </select>
                    </div>
                    <div class="v3-form-group">
                        <label for="gender">Gender</label>
                        <select id="gender" name="gender" required>
                            <option value="">Select</option>
                            <option value="Male">Male</option>
                            <option value="Female">Female</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                </div>

                <div class="v3-form-row">
                    <div class="v3-form-group">
                        <label for="dateOfBirth">Date of Birth</label>
                        <input type="date" id="dateOfBirth" name="dateOfBirth" required>
                    </div>
                    <div class="v3-form-group">
                        <label for="city">City</label>
                        <input type="text" id="city" name="city" required>
                    </div>
                </div>
                
                <div class="v3-form-group">
                    <label for="address">Full Address</label>
                    <input type="text" id="address" name="address" required>
                </div>
                
                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 1rem; padding: 14px;">Complete Registration</button>
            </form>

            <div style="margin-top: 2rem; text-align: center; font-size: 0.95rem; color: var(--text-muted);">
                Already have an account? <a href="<%= request.getContextPath() %>/login" style="font-weight: 700;">Sign In</a>
            </div>
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