package com.lifeflow.config;

import com.lifeflow.model.User;
import jakarta.servlet.Filter;
import jakarta.servlet.FilterChain;
import jakarta.servlet.FilterConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.ServletRequest;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebFilter(urlPatterns = {
        "/home",
        "/profile",
        "/appointments",
        "/blood-requests",
        "/contact",
        "/admin-dashboard",
        "/manage-users",
        "/manage-donors",
        "/manage-blood-requests",
        "/manage-appointments",
        "/view-messages"
})
public class AuthFilter extends HttpFilter implements Filter {
    private static final long serialVersionUID = 1L;

    @Override
    public void init(FilterConfig fConfig) throws ServletException {
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse res = (HttpServletResponse) response;
        HttpSession session = req.getSession(false);

        User loggedInUser = null;
        if (session != null) {
            loggedInUser = (User) session.getAttribute("loggedInUser");
        }

        if (loggedInUser == null) {
            res.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
    }
}