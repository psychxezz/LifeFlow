<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.Donor" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Donors - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand"><strong>LifeFlow Admin</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/admin-dashboard">Dashboard</a>
        <a href="<%= request.getContextPath() %>/manage-users">Users</a>
        <a href="<%= request.getContextPath() %>/manage-donors">Donors</a>
        <a href="<%= request.getContextPath() %>/manage-blood-requests">Blood Requests</a>
        <a href="<%= request.getContextPath() %>/manage-appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/view-messages">Messages</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1 class="page-title">Manage Donors</h1>
    <p class="page-subtitle">Search, review, and update donor information</p>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/admin-dashboard">Back to Dashboard</a>
    </div>

    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String bloodGroup = (String) request.getAttribute("bloodGroup");
        String city = (String) request.getAttribute("city");
        String eligibilityStatus = (String) request.getAttribute("eligibilityStatus");
        List<Donor> donors = (List<Donor>) request.getAttribute("donors");
        Donor editDonor = (Donor) request.getAttribute("editDonor");

        if (successMessage != null) {
    %>
        <div class="message success"><%= successMessage %></div>
    <%
        }
    %>

    <div class="search-box">
        <h2 class="section-title">Search Donors</h2>
        <form action="<%= request.getContextPath() %>/manage-donors" method="get">
            <div class="search-grid">
                <div>
                    <label for="bloodGroup">Blood Group</label>
                    <select id="bloodGroup" name="bloodGroup">
                        <option value="">All</option>
                        <option value="A+" <%= "A+".equals(bloodGroup) ? "selected" : "" %>>A+</option>
                        <option value="A-" <%= "A-".equals(bloodGroup) ? "selected" : "" %>>A-</option>
                        <option value="B+" <%= "B+".equals(bloodGroup) ? "selected" : "" %>>B+</option>
                        <option value="B-" <%= "B-".equals(bloodGroup) ? "selected" : "" %>>B-</option>
                        <option value="AB+" <%= "AB+".equals(bloodGroup) ? "selected" : "" %>>AB+</option>
                        <option value="AB-" <%= "AB-".equals(bloodGroup) ? "selected" : "" %>>AB-</option>
                        <option value="O+" <%= "O+".equals(bloodGroup) ? "selected" : "" %>>O+</option>
                        <option value="O-" <%= "O-".equals(bloodGroup) ? "selected" : "" %>>O-</option>
                    </select>
                </div>

                <div>
                    <label for="city">City</label>
                    <input type="text" id="city" name="city"
                           value="<%= city != null ? city : "" %>"
                           placeholder="Enter city">
                </div>

                <div>
                    <label for="eligibilityStatus">Eligibility</label>
                    <select id="eligibilityStatus" name="eligibilityStatus">
                        <option value="">All</option>
                        <option value="Eligible" <%= "Eligible".equals(eligibilityStatus) ? "selected" : "" %>>Eligible</option>
                        <option value="Not Eligible" <%= "Not Eligible".equals(eligibilityStatus) ? "selected" : "" %>>Not Eligible</option>
                        <option value="Pending" <%= "Pending".equals(eligibilityStatus) ? "selected" : "" %>>Pending</option>
                    </select>
                </div>

                <div>
                    <button type="submit" class="search-btn">Search</button>
                </div>
            </div>
        </form>
    </div>

    <div class="section" style="margin-top: 28px;">
        <h2 class="section-title">Donor Records</h2>
        <table>
            <tr>
                <th>Donor ID</th>
                <th>User ID</th>
                <th>Blood Group</th>
                <th>Gender</th>
                <th>Date of Birth</th>
                <th>Address</th>
                <th>City</th>
                <th>Eligibility</th>
                <th>Action</th>
            </tr>

            <%
                if (donors != null && !donors.isEmpty()) {
                    for (Donor donor : donors) {
            %>
            <tr>
                <td><%= donor.getDonorId() %></td>
                <td><%= donor.getUserId() %></td>
                <td><%= donor.getBloodGroup() %></td>
                <td><%= donor.getGender() %></td>
                <td><%= donor.getDateOfBirth() %></td>
                <td><%= donor.getAddress() %></td>
                <td><%= donor.getCity() %></td>
                <td><%= donor.getEligibilityStatus() %></td>
                <td>
                    <a class="action-btn" href="<%= request.getContextPath() %>/manage-donors?editId=<%= donor.getDonorId() %>">Edit</a>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="9">No donors found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <%
        if (editDonor != null) {
    %>
    <div class="form-box" style="margin-top: 28px;">
        <h2 class="section-title">Edit Donor</h2>
        <p class="page-subtitle" style="text-align:left; margin-bottom:18px;">
            Update donor details and eligibility information.
        </p>

        <form action="<%= request.getContextPath() %>/manage-donors" method="post">
            <input type="hidden" name="donorId" value="<%= editDonor.getDonorId() %>">

            <label for="editBloodGroup">Blood Group</label>
            <select id="editBloodGroup" name="bloodGroup">
                <option value="A+" <%= "A+".equals(editDonor.getBloodGroup()) ? "selected" : "" %>>A+</option>
                <option value="A-" <%= "A-".equals(editDonor.getBloodGroup()) ? "selected" : "" %>>A-</option>
                <option value="B+" <%= "B+".equals(editDonor.getBloodGroup()) ? "selected" : "" %>>B+</option>
                <option value="B-" <%= "B-".equals(editDonor.getBloodGroup()) ? "selected" : "" %>>B-</option>
                <option value="AB+" <%= "AB+".equals(editDonor.getBloodGroup()) ? "selected" : "" %>>AB+</option>
                <option value="AB-" <%= "AB-".equals(editDonor.getBloodGroup()) ? "selected" : "" %>>AB-</option>
                <option value="O+" <%= "O+".equals(editDonor.getBloodGroup()) ? "selected" : "" %>>O+</option>
                <option value="O-" <%= "O-".equals(editDonor.getBloodGroup()) ? "selected" : "" %>>O-</option>
            </select>

            <label for="gender">Gender</label>
            <select id="gender" name="gender">
                <option value="Male" <%= "Male".equals(editDonor.getGender()) ? "selected" : "" %>>Male</option>
                <option value="Female" <%= "Female".equals(editDonor.getGender()) ? "selected" : "" %>>Female</option>
                <option value="Other" <%= "Other".equals(editDonor.getGender()) ? "selected" : "" %>>Other</option>
            </select>

            <label for="dateOfBirth">Date of Birth</label>
            <input type="date" id="dateOfBirth" name="dateOfBirth" value="<%= editDonor.getDateOfBirth() %>">

            <label for="address">Address</label>
            <textarea id="address" name="address" rows="3"><%= editDonor.getAddress() %></textarea>

            <label for="editCity">City</label>
            <input type="text" id="editCity" name="city" value="<%= editDonor.getCity() %>">

            <label for="editEligibilityStatus">Eligibility Status</label>
            <select id="editEligibilityStatus" name="eligibilityStatus">
                <option value="Eligible" <%= "Eligible".equals(editDonor.getEligibilityStatus()) ? "selected" : "" %>>Eligible</option>
                <option value="Not Eligible" <%= "Not Eligible".equals(editDonor.getEligibilityStatus()) ? "selected" : "" %>>Not Eligible</option>
                <option value="Pending" <%= "Pending".equals(editDonor.getEligibilityStatus()) ? "selected" : "" %>>Pending</option>
            </select>

            <button type="submit">Update Donor</button>
        </form>
    </div>
    <%
        }
    %>

    <div class="footer">
        &copy; 2026 LifeFlow Admin Panel. All rights reserved.
    </div>
</div>

</body>
</html>