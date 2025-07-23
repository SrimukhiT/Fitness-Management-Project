package com.fitness.cse;

import java.io.*;
import javax.servlet.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.sql.*;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String dbURL = "jdbc:mysql://localhost:3306/fitness";
        String dbUsername = "root";
        String dbPassword = ""; // Update if needed

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Establish a connection to the database
            Connection conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);

            String sql = "SELECT * FROM clients WHERE email = ? AND password = ? AND status = 1";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                // If login is successful, create a session and set the username attribute
                HttpSession session = request.getSession();
                session.setAttribute("userName", rs.getString("name")); 
                session.setAttribute("userEmail", rs.getString("email"));
                session.setAttribute("age",rs.getString(4));
                session.setAttribute("h",rs.getString(5));
                session.setAttribute("w", rs.getString(6));
                // Store userName in session

                // Redirect to the login success page
                response.sendRedirect("dashboard.jsp");
            } else {
                // If credentials are incorrect, show an error message
            	response.sendRedirect("index.jsp?msgs=invalid");

            }

            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
            out.println("Database error: " + e.getMessage());
        }
    }
}
