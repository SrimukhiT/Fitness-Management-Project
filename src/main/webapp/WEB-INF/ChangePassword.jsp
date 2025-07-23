<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Change Admin Password</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background: white;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 10px rgba(0,0,0,0.1);
            width: 350px;
        }
        h2 {
            color: #1C6CD5;
            text-align: center;
            margin-bottom: 20px;
        }
        form label {
            display: block;
            margin: 10px 0 5px;
            font-weight: bold;
        }
        form input[type="password"] {
            width: 100%;
            padding: 8px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }
        form input[type="submit"], 
        form input[type="button"] {
            margin-top: 20px;
            width: 100%;
            padding: 10px;
            border-radius: 6px;
            font-size: 16px;
            cursor: pointer;
            border: none;
            color: white;
            background: linear-gradient(to right, #1C6CD5, #1E88E5);
            transition: background 0.3s ease;
            display: block;
        }
        form input[type="submit"]:hover, 
        form input[type="button"]:hover {
            background: #1558b0;
        }
        .message {
            text-align: center;
            margin-top: 15px;
            color: red;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Change Password</h2>
        <%
            String errorMsg = request.getParameter("error");
            String successMsg = request.getParameter("success");
            if (errorMsg != null) {
        %>
            <div class="message" style="color: red;"><%= errorMsg %></div>
        <% } else if (successMsg != null) { %>
            <div class="message" style="color: green;"><%= successMsg %></div>
        <% } %>

        <form action="ChangePasswordServlet" method="post">
            <label>Old Password:</label>
            <input type="password" name="oldPassword" required>
            
            <label>New Password:</label>
            <input type="password" name="newPassword" required>
            
            <label>Confirm New Password:</label>
            <input type="password" name="confirmPassword" required>
            
            <input type="submit" value="Change Password">
            <input type="button" value="Back to Home" onclick="window.location.href='index.jsp';">
        </form>
    </div>
</body>
</html>
