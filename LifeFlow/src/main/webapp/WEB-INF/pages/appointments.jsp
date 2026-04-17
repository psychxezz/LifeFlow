<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.lifeflow.model.Appointment" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>My Appointments - LifeFlow</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
<div class="navbar">
    <div class="brand"><strong>LifeFlow</strong></div>
    <div>
        <a href="<%= request.getContextPath() %>/home">Home</a>
        <a href="<%= request.getContextPath() %>/profile">Profile</a>
        <a href="<%= request.getContextPath() %>/blood-requests">Blood Requests</a>
        <a href="<%= request.getContextPath() %>/contact">Contact</a>
        <a href="<%= request.getContextPath() %>/logout">Logout</a>
    </div>
</div>

<div class="container">
    <h1 class="page-title">My Appointments</h1>
    <p class="page-subtitle">Book, review, and manage your donation appointments</p>

    <div class="top-links">
        <a href="<%= request.getContextPath() %>/home">Back to Home</a>
    </div>

    <%
        String successMessage = (String) request.getAttribute("successMessage");
        if (successMessage != null) {
    %>
        <div class="message success"><%= successMessage %></div>
    <%
        }

        List<Appointment> appointments = (List<Appointment>) request.getAttribute("appointments");
    %>

    <div class="section">
        <h2 class="section-title">Appointment History</h2>
        <table>
            <tr>
                <th>Appointment ID</th>
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
                <td><%= ap.getAppointmentDate() %></td>
                <td><%= ap.getAppointmentTime() %></td>
                <td><%= ap.getLocation() %></td>
                <td>
                    <span class="<%= "Pending".equalsIgnoreCase(ap.getStatus()) ? "open" : ("Cancelled".equalsIgnoreCase(ap.getStatus()) ? "closed" : "") %>">
                        <%= ap.getStatus() %>
                    </span>
                </td>
                <td>
                    <%
                        if ("Pending".equalsIgnoreCase(ap.getStatus())) {
                    %>
                    <form action="<%= request.getContextPath() %>/appointments" method="post" style="margin:0;">
                        <input type="hidden" name="action" value="cancel">
                        <input type="hidden" name="appointmentId" value="<%= ap.getAppointmentId() %>">
                        <button type="submit" class="cancel-btn">Cancel</button>
                    </form>
                    <%
                        } else {
                    %>
                        -
                    <%
                        }
                    %>
                </td>
            </tr>
            <%
                    }
                } else {
            %>
            <tr>
                <td colspan="6">No appointments found.</td>
            </tr>
            <%
                }
            %>
        </table>
    </div>

    <div class="form-box" style="margin-top: 28px;">
        <h2 class="section-title">Book New Appointment</h2>
        <p class="page-subtitle" style="text-align:left; margin-bottom:18px;">
            Submit a new donation booking request. Your appointment will be created with pending status.
        </p>

        <form action="<%= request.getContextPath() %>/appointments" method="post">
            <label for="appointmentDate">Appointment Date</label>
            <input type="date" id="appointmentDate" name="appointmentDate" required>

            <label for="appointmentTime">Appointment Time</label>
            <input type="time" id="appointmentTime" name="appointmentTime" required>

            <label for="location">Location</label>
            <input type="text" id="location" name="location" placeholder="Enter donation location" required>

            <button type="submit">Book Appointment</button>
        </form>
    </div>

    <div class="footer">
        &copy; 2026 LifeFlow. All rights reserved.
    </div>
</div>

</body>
</html>