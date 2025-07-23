<%@ page session="true" %>
<%
    // Logout handler (if the user is logged out from dashboard)
    if ("logout".equals(request.getParameter("action"))) {
        session.invalidate();
        response.sendRedirect("index.jsp");
        return;
    }

    // Checking for existing session and redirecting if the user is already logged in
    String userName = (String) session.getAttribute("userName");
    if (userName != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f4;
        }
        .login-container {
            width: 300px;
            margin: 100px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
        }
        .login-container input {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .login-container button {
            width: 100%;
            padding: 10px;
            background-color: #1C6CD5;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        .login-container button:hover {
            background-color: #154db8;
        }
    </style>
</head>
<body>

<div class="login-container">
    <h2>Login</h2>
    <form action="login.jsp" method="post">
        <label>Email:</label>
        <input type="email" name="email" required>
        <label>Password:</label>
        <input type="password" name="password" required>
        <button type="submit">Login</button>
    </form>
</div>

<%
    // Handle the login authentication (basic example)
    if (request.getMethod().equals("POST")) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Replace these with actual database logic for real applications
        String validEmail = "user@example.com";
        String validPassword = "password123";

        if (email != null && password != null && email.equals(validEmail) && password.equals(validPassword)) {
            // Set session attribute after successful login
            session.setAttribute("userName", email); // Store user email in session
            response.sendRedirect("dashboard.jsp");  // Redirect to dashboard after login
        } else {
            out.println("<script>alert('Invalid email or password');</script>");
        }
    }
%>

</body>
</html>
