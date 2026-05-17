package com.lifeflow.controllers;

import com.lifeflow.model.Donor;
import com.lifeflow.model.User;
import com.lifeflow.service.UserService;
import com.lifeflow.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String bloodGroup = request.getParameter("bloodGroup");
        String gender = request.getParameter("gender");
        String dateOfBirthValue = request.getParameter("dateOfBirth");
        String address = request.getParameter("address");
        String city = request.getParameter("city");

        if (isEmpty(fullName) || isEmpty(email) || isEmpty(phone) || isEmpty(password)
                || isEmpty(confirmPassword) || isEmpty(bloodGroup) || isEmpty(gender)
                || isEmpty(dateOfBirthValue) || isEmpty(address) || isEmpty(city)) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Password and confirm password do not match.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (userService.isEmailExists(email)) {
            request.setAttribute("errorMessage", "Email already exists.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        if (userService.isPhoneExists(phone)) {
            request.setAttribute("errorMessage", "Phone number already exists.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        Date dateOfBirth;
        try {
            dateOfBirth = Date.valueOf(dateOfBirthValue);
        } catch (IllegalArgumentException e) {
            request.setAttribute("errorMessage", "Invalid date of birth.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
            return;
        }

        // Hash the password before persisting
        String hashedPassword = PasswordUtil.hashPassword(password);
        User user = new User(fullName, email, phone, hashedPassword, "donor");

        Donor donor = new Donor();
        donor.setBloodGroup(bloodGroup);
        donor.setGender(gender);
        donor.setDateOfBirth(dateOfBirth);
        donor.setAddress(address);
        donor.setCity(city);
        donor.setEligibilityStatus("Eligible");

        boolean registrationSuccess = userService.registerUserWithDonor(user, donor);

        if (registrationSuccess) {
            response.sendRedirect(request.getContextPath() + "/login?success=registered");
        } else {
            request.setAttribute("errorMessage", "Registration failed. Please try again.");
            request.getRequestDispatcher("/WEB-INF/pages/register.jsp").forward(request, response);
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}