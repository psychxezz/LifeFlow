<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.BloodRequest" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Blood Requests - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand"><strong>LifeFlow</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <a href="<%= request.getContextPath() %>/profile">Profile</a>
        <a href="<%= request.getContextPath() %>/appointments">Appointments</a>
        <a href="<%= request.getContextPath() %>/contact">Contact</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1 class="page-title">Blood Requests</h1>
    <p class="page-subtitle">Search and explore current blood needs across hospitals and cities</p>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/home">Back to Home</a>
    </div>

    <%
        String keyword = (String) request.getAttribute("keyword");
        String bloodGroup = (String) request.getAttribute("bloodGroup");
        String city = (String) request.getAttribute("city");
        List<BloodRequest> bloodRequests = (List<BloodRequest>) request.getAttribute("bloodRequests");
    %>

    <div class="search-box">
        <h2 class="section-title">Search Blood Requests</h2>
        <form action="<%= request.getContextPath() %>/blood-requests" method="get">
            <div class="search-grid">
                <div>
                    <label for="keyword">Keyword</label>
                    <input type="text" id="keyword" name="keyword"
                           value="<%= keyword != null ? keyword : "" %>"
                           placeholder="Patient or hospital name">
                </div>

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
                    <button type="submit" class="search-btn">Search</button>
                </div>
            </div>
        </form>
    </div>

    <div class="section" style="margin-top: 28px;">
        <h2 class="section-title">Available Requests</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Patient Name</th>
                <th>Blood Group</th>
                <th>Hospital</th>
                <th>City</th>
                <th>Urgency</th>
                <th>Units Required</th>
                <th>Status</th>
                <th>Created At</th>
            </tr>

            <%
                if (bloodRequests != null && !bloodRequests.isEmpty()) {
                    for (BloodRequest br : bloodRequests) {
                        String urgencyClass = "";
                        if ("Urgent".equalsIgnoreCase(br.getUrgencyLevel())) {
                            urgencyClass = "urgent";
                        } else if ("Critical".equalsIgnoreCase(br.getUrgencyLevel())) {
                            urgencyClass = "critical";
                        }

                        String statusClass = "";
                        if ("Open".equalsIgnoreCase(br.getRequestStatus()) || "In Progress".equalsIgnoreCase(br.getRequestStatus())) {
                            statusClass = "open";
                        } else if ("Closed".equalsIgnoreCase(br.getRequestStatus())) {
                            statusClass = "closed";
                        }
            %>
            <tr>
                <td><%= br.getRequestId() %></td>
                <td><%= br.getPatientName() %></td>
                <td><%= br.getBloodGroup() %></td>
                <td><%= br.getHospitalName() %></td>
                <td><%= br.getCity() %></td>
                <td class="<%= urgencyClass %>"><%= br.getUrgencyLevel() %></td>
                <td><%= br.getUnitsRequired() %></td>
                <td class="<%= statusClass %>"><%= br.getRequestStatus() %></td>
                <td><%= br.getCreatedAt() %></td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="9">No blood requests found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <div class="footer">
        &copy; 2026 LifeFlow. All rights reserved.
    </div>
</div>

</body>
</html>