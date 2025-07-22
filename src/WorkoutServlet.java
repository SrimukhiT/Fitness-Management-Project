package com.fitness.cse;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;
import java.text.SimpleDateFormat;
import java.util.Date;

@WebServlet("/WorkoutServlet")
public class WorkoutServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve user session data
        String email = (String) request.getSession().getAttribute("name");  // Case-sensitive!

        // Validate session
        if (email == null || email.isEmpty()) {
            response.sendRedirect("login.jsp"); // Redirect if session is missing
            return;
        }

        // Get form inputs
        double weight = Double.parseDouble(request.getParameter("weight"));
        int height = Integer.parseInt(request.getParameter("height"));
        String bmiCategory = request.getParameter("bmi");

        // Get current date
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String currentDateStr = sdf.format(new Date());  // Get current date as String (format: yyyy-MM-dd)

        Connection connection = null;
        PreparedStatement preparedStatement = null;

        try {
            String url = "jdbc:mysql://localhost:3306/fitness";
            String user = "root";
            String password = "";  // Replace with your actual password

            connection = DriverManager.getConnection(url, user, password);

            String query = "INSERT INTO workout (email, date, weight, height, bmi_category, status) VALUES (?, ?, ?, ?, ?, ?)";
            preparedStatement = connection.prepareStatement(query);

            preparedStatement.setString(1, email);
            preparedStatement.setString(2, currentDateStr);  // Use the current date
            preparedStatement.setDouble(3, weight);
            preparedStatement.setInt(4, height);
            preparedStatement.setString(5, bmiCategory);
            preparedStatement.setInt(6, 1); // status = 1

            int result = preparedStatement.executeUpdate();

            if (result > 0) {
                response.sendRedirect("dashboard.jsp");
            } else {
                response.sendRedirect("addWorkout.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
        } finally {
            try {
                if (preparedStatement != null) preparedStatement.close();
                if (connection != null) connection.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
