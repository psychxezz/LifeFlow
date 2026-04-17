package com.lifeflow.controllers;

import com.lifeflow.model.Donor;
import com.lifeflow.model.User;
import com.lifeflow.service.UserService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Date;

@WebServlet("/edit-profile")
public class EditProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");
        Donor donor = userService.getDonorByUserId(loggedInUser.getUserId());

        request.setAttribute("user", loggedInUser);
        request.setAttribute("donor", donor);

        request.getRequestDispatcher("/WEB-INF/pages/edit-profile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("loggedInUser") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        User loggedInUser = (User) session.getAttribute("loggedInUser");

        String fullName = request.getParameter("fullName");
        String phone = request.getParameter("phone");
        String bloodGroup = request.getParameter("bloodGroup");
        String gender = request.getParameter("gender");
        String dateOfBirthValue = request.getParameter("dateOfBirth");
        String address = request.getParameter("address");
        String city = request.getParameter("city");

        if (isEmpty(fullName) || isEmpty(phone) || isEmpty(bloodGroup) || isEmpty(gender)
                || isEmpty(dateOfBirthValue) || isEmpty(address) || isEmpty(city)) {
            request.setAttribute("errorMessage", "All fields are required.");
            request.setAttribute("user", loggedInUser);
            request.setAttribute("donor", userService.getDonorByUserId(loggedInUser.getUserId()));
            request.getRequestDispatcher("/WEB-INF/pages/edit-profile.jsp").forward(request, response);
            return;
        }

        User updatedUser = new User();
        updatedUser.setUserId(loggedInUser.getUserId());
        updatedUser.setFullName(fullName);
        updatedUser.setPhone(phone);

        Donor updatedDonor = new Donor();
        updatedDonor.setUserId(loggedInUser.getUserId());
        updatedDonor.setBloodGroup(bloodGroup);
        updatedDonor.setGender(gender);
        updatedDonor.setDateOfBirth(Date.valueOf(dateOfBirthValue));
        updatedDonor.setAddress(address);
        updatedDonor.setCity(city);

        boolean userUpdated = userService.updateUserProfile(updatedUser);
        boolean donorUpdated = userService.updateDonorProfile(updatedDonor);

        if (userUpdated && donorUpdated) {
            loggedInUser.setFullName(fullName);
            loggedInUser.setPhone(phone);
            session.setAttribute("loggedInUser", loggedInUser);
            session.setAttribute("userName", fullName);

            response.sendRedirect(request.getContextPath() + "/profile?message=Profile updated successfully.");
        } else {
            request.setAttribute("errorMessage", "Failed to update profile.");
            request.setAttribute("user", loggedInUser);
            request.setAttribute("donor", userService.getDonorByUserId(loggedInUser.getUserId()));
            request.getRequestDispatcher("/WEB-INF/pages/edit-profile.jsp").forward(request, response);
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.trim().isEmpty();
    }
}