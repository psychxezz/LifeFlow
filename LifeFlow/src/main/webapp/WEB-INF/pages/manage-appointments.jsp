<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.Appointment" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Appointments - LifeFlow</title>
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
    <h1 class="page-title">Manage Appointments</h1>
    <p class="page-subtitle">Review, update, and manage donor appointment records</p>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/admin-dashboard">Back to Dashboard</a>
    </div>

    <%
        String successMessage = (String) request.getAttribute("successMessage");
        List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
        Appointment editAppointment = (Appointment) request.getAttribute("editAppointment");

        if (successMessage != null) {
    %>
        <div class="message success"><%= successMessage %></div>
    <%
        }
    %>

    <div class="section">
        <h2 class="section-title">Appointment Records</h2>
        <table>
            <tr>
                <th>ID</th>
                <th>Donor ID</th>
                <th>Date</th>
                <th>Time</th>
                <th>Location</th>
                <th>Status</th>
                <th>Action</th>
            </tr>

            <%
                if (appointments != null && !appointments.isEmpty()) {
                    for (Appointment ap : appointments) {
            %>
            <tr>
                <td><%= ap.getAppointmentId() %></td>
                <td><%= ap.getDonorId() %></td>
                <td><%= ap.getAppointmentDate() %></td>
                <td><%= ap.getAppointmentTime() %></td>
                <td><%= ap.getLocation() %></td>
                <td>
                    <span class="<%= "Pending".equalsIgnoreCase(ap.getStatus()) ? "open" : ("Cancelled".equalsIgnoreCase(ap.getStatus()) ? "closed" : "") %>">
                        <%= ap.getStatus() %>
                    </span>
                </td>
                <td>
                    <a class="action-btn" href="<%= request.getContextPath() %>/manage-appointments?editId=<%= ap.getAppointmentId() %>">Edit</a>
                    <form action="<%= request.getContextPath() %>/manage-appointments" method="post" style="display:inline;">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="appointmentId" value="<%= ap.getAppointmentId() %>">
                        <button type="submit" class="delete-btn">Delete</button>
                    </form>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="7">No appointments found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <div class="form-box" style="margin-top: 28px;">
        <h2 class="section-title"><%= (editAppointment != null) ? "Edit Appointment" : "Add Appointment" %></h2>
        <p class="page-subtitle" style="text-align:left; margin-bottom:18px;">
            Create a new appointment or update an existing one for a donor.
        </p>

        <form action="<%= request.getContextPath() %>/manage-appointments" method="post">
            <%
                if (editAppointment != null) {
            %>
                <input type="hidden" name="appointmentId" value="<%= editAppointment.getAppointmentId() %>">
            <%
                }
            %>

            <label for="donorId">Donor ID</label>
            <input type="number" id="donorId" name="donorId" min="1"
                   value="<%= editAppointment != null ? editAppointment.getDonorId() : "" %>" required>

            <label for="appointmentDate">Appointment Date</label>
            <input type="date" id="appointmentDate" name="appointmentDate"
                   value="<%= editAppointment != null ? editAppointment.getAppointmentDate() : "" %>" required>

            <label for="appointmentTime">Appointment Time</label>
            <input type="time" id="appointmentTime" name="appointmentTime"
                   value="<%= editAppointment != null ? editAppointment.getAppointmentTime().toString().substring(0,5) : "" %>" required>

            <label for="location">Location</label>
            <input type="text" id="location" name="location"
                   value="<%= editAppointment != null ? editAppointment.getLocation() : "" %>"
                   placeholder="Enter donation location" required>

            <label for="status">Status</label>
            <select id="status" name="status" required>
                <option value="Pending" <%= editAppointment != null && "Pending".equals(editAppointment.getStatus()) ? "selected" : "" %>>Pending</option>
                <option value="Approved" <%= editAppointment != null && "Approved".equals(editAppointment.getStatus()) ? "selected" : "" %>>Approved</option>
                <option value="Completed" <%= editAppointment != null && "Completed".equals(editAppointment.getStatus()) ? "selected" : "" %>>Completed</option>
                <option value="Cancelled" <%= editAppointment != null && "Cancelled".equals(editAppointment.getStatus()) ? "selected" : "" %>>Cancelled</option>
            </select>

            <button type="submit"><%= (editAppointment != null) ? "Update Appointment" : "Add Appointment" %></button>
        </form>
    </div>

    <div class="footer">
        &copy; 2026 LifeFlow Admin Panel. All rights reserved.
    </div>
</div>

</body>
</html>