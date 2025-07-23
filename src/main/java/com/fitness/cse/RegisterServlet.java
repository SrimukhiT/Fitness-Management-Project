package com.fitness.cse;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    // Database credentials
    private static final String DB_URL = "jdbc:mysql://localhost:3306/fitness"; 
    private static final String DB_USERNAME = "root"; // Your DB username
    private static final String DB_PASSWORD = ""; // Your DB password

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get form data
        String name = request.getParameter("name");
        String password = request.getParameter("password");
        String gender = request.getParameter("gender");
        String age = request.getParameter("age");
        String height = request.getParameter("height");
        String weight = request.getParameter("weight");
        String address = request.getParameter("address");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String fitness_goal = request.getParameter("goal");
        String status = request.getParameter("status");
        

        Connection conn = null;
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            // Explicitly load MySQL JDBC driver
            Class.forName("com.mysql.jdbc.Driver");

            // Establish database connection
            conn = DriverManager.getConnection(DB_URL, DB_USERNAME, DB_PASSWORD);

            // Check if email already exists
            String checkEmailQuery = "SELECT Email FROM clients WHERE Email = ?";
            ps = conn.prepareStatement(checkEmailQuery);
            ps.setString(1, email);
            rs = ps.executeQuery();

            if (rs.next()) {
                // Email already exists
                response.getWriter().println("Email already exists. Please try a different one.");
            } else {
                // Insert new user into the database
                String insertQuery = "INSERT INTO clients (email, name, password, gender, age, height_cm, weight_kg, address, mobile, Fitness_Goal, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                ps = conn.prepareStatement(insertQuery);
                ps.setString(1, email);
                ps.setString(2, name);
                ps.setString(3, password);
                ps.setString(4, gender);
                ps.setString(5, age);
                ps.setString(6, height);
                ps.setString(7, weight);
                ps.setString(8, address);
                ps.setString(9, mobile);
                ps.setString(10, fitness_goal);
                ps.setInt(11, 0); // Assuming default status is 'active'

                int result = ps.executeUpdate();

                if (result > 0) {
                    //response.getWriter().println("Registration successful.");
                	response.sendRedirect("index.jsp?msg=success");
                } else {
                    //response.getWriter().println("Registration failed. Please try again.");
                	response.sendRedirect("index.jsp?msg=failed");

                }
            }
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            response.getWriter().println("JDBC Driver not found: " + e.getMessage());
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Database error: " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
