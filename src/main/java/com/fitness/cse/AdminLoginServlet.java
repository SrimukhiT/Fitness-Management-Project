package com.fitness.cse;

import java.io.IOException;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.WebServlet;
import java.sql.*;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("adminId");
        String password = request.getParameter("adminPass");

        boolean isValid = false;

        try {
            // Load MySQL Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Connect to database
            Connection conn = DriverManager.getConnection(
                "jdbc:mysql://localhost:3306/fitness", "root", "");

            // Prepare SQL
            String sql = "SELECT * FROM admin WHERE username=? AND password=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                isValid = true;// credentials matched
            }

            // Close resources
            rs.close();
            ps.close();
            conn.close();

        } catch (Exception e) {
            e.printStackTrace();
        }

        if (isValid) {
            // ✅ Valid login: redirect to dashboard
            response.sendRedirect("AdminLogin.jsp");
        } else {
            // ❌ Invalid login: show message
            response.setContentType("text/html");
            response.getWriter().println("<html><body style='text-align:center;'>");
            response.getWriter().println("<h3 style='color:red;'>Invalid username or password!</h3>");
            response.getWriter().println("<a href='index.jsp'>Try Again</a>");
            response.getWriter().println("</body></html>");
        }
    }
}
