package com.fitness.cse;
import java.io.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;


@WebServlet("/ChangePasswordServlet")
public class ChangePasswordServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String confirmPassword = request.getParameter("confirmPassword");
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");

        Connection conn = null;
        PreparedStatement psSelect = null;
        PreparedStatement psUpdate = null;
        ResultSet rs = null;
        
        try {
            // Load the MySQL driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitness", "root", "");

            if(newPassword.equalsIgnoreCase(confirmPassword)) {
            // Step 1: Check if username and oldPassword match
            String selectQuery = "SELECT * FROM admin WHERE password=?";
            psSelect = conn.prepareStatement(selectQuery);
           
            psSelect.setString(1, oldPassword);
            rs = psSelect.executeQuery();

            if (rs.next()) {
            	String username=rs.getString(2);
                // Step 2: If match found, update the password
                String updateQuery = "UPDATE admin SET password=? WHERE username=?";
                psUpdate = conn.prepareStatement(updateQuery);
                psUpdate.setString(1, newPassword);
                psUpdate.setString(2, username);
                int rowsUpdated = psUpdate.executeUpdate();

                if (rowsUpdated > 0) {
                    response.getWriter().println("Password changed successfully.");
                } else {
                    response.getWriter().println("Error: Password change failed.");
                }}else {
                	response.getWriter().println("Passwords does't match new and confirm.");
                }
            } else {
                // Step 3: If no match found
                response.getWriter().println("Incorrect old password or username.");
                  
                 {
                	
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        } finally {
            try { if (rs != null) rs.close(); } catch (Exception e) {}
            try { if (psSelect != null) psSelect.close(); } catch (Exception e) {}
            try { if (psUpdate != null) psUpdate.close(); } catch (Exception e) {}
            try { if (conn != null) conn.close(); } catch (Exception e) {}
        }
    }
}
