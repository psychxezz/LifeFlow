<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.BloodRequest" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Blood Requests - LifeFlow</title>
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
    <h1 class="page-title">Manage Blood Requests</h1>
    <p class="page-subtitle">Create, review, update, and remove blood request records</p>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/admin-dashboard">Back to Dashboard</a>
    </div>

    <%
        String successMessage = (String) request.getAttribute("successMessage");
        String keyword = (String) request.getAttribute("keyword");
        String bloodGroup = (String) request.getAttribute("bloodGroup");
        String city = (String) request.getAttribute("city");
        String urgencyLevel = (String) request.getAttribute("urgencyLevel");
        String requestStatus = (String) request.getAttribute("requestStatus");
        List<BloodRequest> bloodRequests = (List<BloodRequest>) request.getAttribute("bloodRequests");
        BloodRequest editRequest = (BloodRequest) request.getAttribute("editRequest");

        if (successMessage != null) {
    %>
        <div class="message success"><%= successMessage %></div>
    <%
        }
    %>

    <div class="search-box">
        <h2 class="section-title">Search Blood Requests</h2>
        <form action="<%= request.getContextPath() %>/manage-blood-requests" method="get">
            <div class="search-grid">
                <div>
                    <label for="keyword">Keyword</label>
                    <input type="text" id="keyword" name="keyword"
                           value="<%= keyword != null ? keyword : "" %>"
                           placeholder="Patient or hospital">
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
                    <label for="urgencyLevel">Urgency</label>
                    <select id="urgencyLevel" name="urgencyLevel">
                        <option value="">All</option>
                        <option value="Normal" <%= "Normal".equals(urgencyLevel) ? "selected" : "" %>>Normal</option>
                        <option value="Urgent" <%= "Urgent".equals(urgencyLevel) ? "selected" : "" %>>Urgent</option>
                        <option value="Critical" <%= "Critical".equals(urgencyLevel) ? "selected" : "" %>>Critical</option>
                    </select>
                </div>

                <div>
                    <label for="requestStatus">Status</label>
                    <select id="requestStatus" name="requestStatus">
                        <option value="">All</option>
                        <option value="Open" <%= "Open".equals(requestStatus) ? "selected" : "" %>>Open</option>
                        <option value="In Progress" <%= "In Progress".equals(requestStatus) ? "selected" : "" %>>In Progress</option>
                        <option value="Closed" <%= "Closed".equals(requestStatus) ? "selected" : "" %>>Closed</option>
                    </select>
                </div>

                <div>
                    <button type="submit" class="search-btn">Search</button>
                </div>
            </div>
        </form>
    </div>

    <div class="section" style="margin-top: 28px;">
        <h2 class="section-title">Blood Request Records</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Patient Name</th>
                <th>Blood Group</th>
                <th>Hospital</th>
                <th>City</th>
                <th>Urgency</th>
                <th>Units</th>
                <th>Status</th>
                <th>Created At</th>
                <th>Action</th>
            </tr>

            <%
                if (bloodRequests != null && !bloodRequests.isEmpty()) {
                    for (BloodRequest br : bloodRequests) {
            %>
            <tr>
                <td><%= br.getRequestId() %></td>
                <td><%= br.getPatientName() %></td>
                <td><%= br.getBloodGroup() %></td>
                <td><%= br.getHospitalName() %></td>
                <td><%= br.getCity() %></td>
                <td>
                    <span class="<%= "Critical".equalsIgnoreCase(br.getUrgencyLevel()) ? "critical" : ("Urgent".equalsIgnoreCase(br.getUrgencyLevel()) ? "urgent" : "") %>">
                        <%= br.getUrgencyLevel() %>
                    </span>
                </td>
                <td><%= br.getUnitsRequired() %></td>
                <td>
                    <span class="<%= ("Open".equalsIgnoreCase(br.getRequestStatus()) || "In Progress".equalsIgnoreCase(br.getRequestStatus())) ? "open" : "closed" %>">
                        <%= br.getRequestStatus() %>
                    </span>
                </td>
                <td><%= br.getCreatedAt() %></td>
                <td>
                    <a class="action-btn" href="<%= request.getContextPath() %>/manage-blood-requests?editId=<%= br.getRequestId() %>">Edit</a>
                    <form action="<%= request.getContextPath() %>/manage-blood-requests" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="requestId" value="<%= br.getRequestId() %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="10">No blood requests found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <div class="form-box" style="margin-top: 28px;">
        <h2 class="section-title"><%= (editRequest != null) ? "Edit Blood Request" : "Add Blood Request" %></h2>
        <p class="page-subtitle" style="text-align:left; margin-bottom:18px;">
            Fill in request details and keep hospital demand records updated.
        </p>

        <form action="<%= request.getContextPath() %>/manage-blood-requests" method="post">
            <%
                if (editRequest != null) {
            %>
                <input type="hidden" name="requestId" value="<%= editRequest.getRequestId() %>">
            <%
                }
            %>

            <label for="patientName">Patient Name</label>
            <input type="text" id="patientName" name="patientName" value="<%= editRequest != null ? editRequest.getPatientName() : "" %>" required>

            <label for="formBloodGroup">Blood Group</label>
            <select id="formBloodGroup" name="bloodGroup" required>
                <option value="A+" <%= editRequest != null && "A+".equals(editRequest.getBloodGroup()) ? "selected" : "" %>>A+</option>
                <option value="A-" <%= editRequest != null && "A-".equals(editRequest.getBloodGroup()) ? "selected" : "" %>>A-</option>
                <option value="B+" <%= editRequest != null && "B+".equals(editRequest.getBloodGroup()) ? "selected" : "" %>>B+</option>
                <option value="B-" <%= editRequest != null && "B-".equals(editRequest.getBloodGroup()) ? "selected" : "" %>>B-</option>
                <option value="AB+" <%= editRequest != null && "AB+".equals(editRequest.getBloodGroup()) ? "selected" : "" %>>AB+</option>
                <option value="AB-" <%= editRequest != null && "AB-".equals(editRequest.getBloodGroup()) ? "selected" : "" %>>AB-</option>
                <option value="O+" <%= editRequest != null && "O+".equals(editRequest.getBloodGroup()) ? "selected" : "" %>>O+</option>
                <option value="O-" <%= editRequest != null && "O-".equals(editRequest.getBloodGroup()) ? "selected" : "" %>>O-</option>
            </select>

            <label for="hospitalName">Hospital Name</label>
            <input type="text" id="hospitalName" name="hospitalName" value="<%= editRequest != null ? editRequest.getHospitalName() : "" %>" required>

            <label for="formCity">City</label>
            <input type="text" id="formCity" name="city" value="<%= editRequest != null ? editRequest.getCity() : "" %>" required>

            <label for="formUrgencyLevel">Urgency Level</label>
            <select id="formUrgencyLevel" name="urgencyLevel" required>
                <option value="Normal" <%= editRequest != null && "Normal".equals(editRequest.getUrgencyLevel()) ? "selected" : "" %>>Normal</option>
                <option value="Urgent" <%= editRequest != null && "Urgent".equals(editRequest.getUrgencyLevel()) ? "selected" : "" %>>Urgent</option>
                <option value="Critical" <%= editRequest != null && "Critical".equals(editRequest.getUrgencyLevel()) ? "selected" : "" %>>Critical</option>
            </select>

            <label for="unitsRequired">Units Required</label>
            <input type="number" id="unitsRequired" name="unitsRequired" min="1" value="<%= editRequest != null ? editRequest.getUnitsRequired() : "" %>" required>

            <label for="formRequestStatus">Request Status</label>
            <select id="formRequestStatus" name="requestStatus" required>
                <option value="Open" <%= editRequest != null && "Open".equals(editRequest.getRequestStatus()) ? "selected" : "" %>>Open</option>
                <option value="In Progress" <%= editRequest != null && "In Progress".equals(editRequest.getRequestStatus()) ? "selected" : "" %>>In Progress</option>
                <option value="Closed" <%= editRequest != null && "Closed".equals(editRequest.getRequestStatus()) ? "selected" : "" %>>Closed</option>
            </select>

            <button type="submit"><%= (editRequest != null) ? "Update Blood Request" : "Add Blood Request" %></button>
        </form>
    </div>

    <div class="footer">
        &copy; 2026 LifeFlow Admin Panel. All rights reserved.
    </div>
</div>

</body>
</html>