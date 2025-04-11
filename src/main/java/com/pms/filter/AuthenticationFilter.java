package com.pms.filter;

import com.pms.model.User;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

/**
 * Filter to protect resources based on user roles
 */
@WebFilter(urlPatterns = {"/admin/*", "/doctor/*", "/nurse/*", "/patient/*"})
public class AuthenticationFilter implements Filter {
    
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // Initialization code if needed
    }
    
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        
        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;
        HttpSession session = httpRequest.getSession(false);
        
        String requestURI = httpRequest.getRequestURI();
        String contextPath = httpRequest.getContextPath();
        
        // Check if the user is logged in
        boolean isLoggedIn = (session != null && session.getAttribute("user") != null);
        boolean isLoginRequest = requestURI.equals(contextPath + "/login");
        boolean isRegisterRequest = requestURI.equals(contextPath + "/register");
        boolean isStaticResource = requestURI.contains("/css/") || 
                                  requestURI.contains("/js/") || 
                                  requestURI.contains("/images/");
        
        if (isLoggedIn || isLoginRequest || isRegisterRequest || isStaticResource) {
            // Check if the logged-in user is accessing authorized resources
            if (isLoggedIn && !isStaticResource) {
                User user = (User) session.getAttribute("user");
                String userRole = user.getUserType();
                
                if (requestURI.contains("/admin/") && !"Admin".equals(userRole)) {
                    httpResponse.sendRedirect(contextPath + "/login");
                    return;
                }
                
                if (requestURI.contains("/doctor/") && !"Doctor".equals(userRole)) {
                    httpResponse.sendRedirect(contextPath + "/login");
                    return;
                }
                
                if (requestURI.contains("/nurse/") && !"Nurse".equals(userRole)) {
                    httpResponse.sendRedirect(contextPath + "/login");
                    return;
                }
                
                if (requestURI.contains("/patient/") && !"Patient".equals(userRole)) {
                    httpResponse.sendRedirect(contextPath + "/login");
                    return;
                }
            }
            
            // User is authenticated or accessing public resource, proceed
            chain.doFilter(request, response);
        } else {
            // Unauthenticated user, redirect to login page
            httpResponse.sendRedirect(contextPath + "/login");
        }
    }
    
    @Override
    public void destroy() {
        // Clean-up code if needed
    }
} 