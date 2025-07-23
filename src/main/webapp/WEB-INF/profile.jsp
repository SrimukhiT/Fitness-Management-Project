<%@ page session="true" %>
<%@ page import="java.sql.*" %>
<%
    String email = (String) session.getAttribute("userEmail");
    if (email == null) {
        response.sendRedirect("index.jsp#login");
        return;
    }

    String dbURL = "jdbc:mysql://localhost:3306/fitness";
    String dbUsername = "root";
    String dbPassword = "";

    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection conn = DriverManager.getConnection(dbURL, dbUsername, dbPassword);
    String sql = "SELECT * FROM clients WHERE email = ?";
    PreparedStatement ps = conn.prepareStatement(sql);
    ps.setString(1, email);
    ResultSet rs = ps.executeQuery();

    if (rs.next()) {
        String name = rs.getString("name");
        String gender = rs.getString("gender");
        int age = rs.getInt("age");
        int height = rs.getInt("height_cm");
        int weight = rs.getInt("weight_kg");
        String address = rs.getString("address");
        String mobile = rs.getString("mobile");
        String fitnessGoal = rs.getString("fitness_goal");

        String editMode = request.getParameter("edit");

        if (editMode != null && editMode.equals("true")) {
%>
<!-- Edit Form -->
<div class="container">
    <h1>Edit Profile</h1>
    <form action="profile.jsp" method="POST">
        <label>Name:</label>
        <input type="text" name="name" value="<%= name %>">

        <label>Gender:</label>
        <input type="text" name="gender" value="<%= gender %>">

        <label>Age:</label>
        <input type="number" name="age" value="<%= age %>">

        <label>Height (cm):</label>
        <input type="number" name="height" value="<%= height %>">

        <label>Weight (kg):</label>
        <input type="number" name="weight" value="<%= weight %>">

        <label>Address:</label>
        <input type="text" name="address" value="<%= address %>">

        <label>Mobile:</label>
        <input type="text" name="mobile" value="<%= mobile %>">

        <label>Fitness Goal:</label>
        <input type="text" name="fitnessGoal" value="<%= fitnessGoal %>">

        <button type="submit" name="updateProfile">Update Profile</button>
    </form>
    <div class="center">
        <a href="profile.jsp" class="link-button secondary">Cancel</a>
    </div>
</div>
<%
        } else {
%>
<!-- Display Profile -->
<div class="container">
    <h1>My Profile</h1>
    <table class="profile-table">
        <tr><td>Name</td><td><%= name %></td></tr>
        <tr><td>Email</td><td><%= rs.getString("email") %></td></tr>
        <tr><td>Gender</td><td><%= gender %></td></tr>
        <tr><td>Age</td><td><%= age %></td></tr>
        <tr><td>Height</td><td><%= height %> cm</td></tr>
        <tr><td>Weight</td><td><%= weight %> kg</td></tr>
        <tr><td>Address</td><td><%= address %></td></tr>
        <tr><td>Mobile</td><td><%= mobile %></td></tr>
        <tr><td>Goal</td><td><%= fitnessGoal %></td></tr>
    </table>
    <div class="center">
        <a href="profile.jsp?edit=true" class="link-button">Edit Profile</a>
    </div>
</div>
<%
        }

        if (request.getParameter("updateProfile") != null) {
            String updatedName = request.getParameter("name");
            String updatedGender = request.getParameter("gender");
            int updatedAge = Integer.parseInt(request.getParameter("age"));
            int updatedHeight = Integer.parseInt(request.getParameter("height"));
            int updatedWeight = Integer.parseInt(request.getParameter("weight"));
            String updatedAddress = request.getParameter("address");
            String updatedMobile = request.getParameter("mobile");
            String updatedFitnessGoal = request.getParameter("fitnessGoal");

            String updateSql = "UPDATE clients SET name = ?, gender = ?, age = ?, height_cm = ?, weight_kg = ?, address = ?, mobile = ?, fitness_goal = ? WHERE email = ?";
            PreparedStatement updatePs = conn.prepareStatement(updateSql);
            updatePs.setString(1, updatedName);
            updatePs.setString(2, updatedGender);
            updatePs.setInt(3, updatedAge);
            updatePs.setInt(4, updatedHeight);
            updatePs.setInt(5, updatedWeight);
            updatePs.setString(6, updatedAddress);
            updatePs.setString(7, updatedMobile);
            updatePs.setString(8, updatedFitnessGoal);
            updatePs.setString(9, email);
            updatePs.executeUpdate();

            response.sendRedirect("profile.jsp");
        }
    } else {
        out.println("Profile not found.");
    }

    rs.close();
    ps.close();
    conn.close();
%>

<!-- Back Button -->
<div class="center">
    <a href="dashboard.jsp" class="link-button">Back to Dashboard</a>
</div>

<!-- Styling -->
<style>
    body {
        margin: 0;
        font-family: 'Segoe UI', sans-serif;
        background: #eef2f3;
        color: #333;
        animation: fadeIn 0.6s ease-in;
    }

    .container {
        background: #fff;
        margin: 40px auto;
        padding: 30px;
        width: 70%;
        max-width: 700px;
        border-radius: 12px;
        box-shadow: 0 4px 20px rgba(0,0,0,0.1);
        animation: slideUp 0.8s ease;
    }

    h1 {
        text-align: center;
        color: #2e86de;
        margin-bottom: 25px;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-bottom: 20px;
    }

    table td {
        padding: 12px 10px;
        border-bottom: 1px solid #ddd;
    }

    table td:first-child {
        font-weight: 500;
        color: #2c3e50;
        width: 30%;
        background-color: #f7f7f7;
    }

    label {
        font-weight: 500;
        display: block;
        margin-top: 12px;
    }

    input[type="text"],
    input[type="number"] {
        width: 100%;
        padding: 10px;
        margin-top: 6px;
        border: 1px solid #ccc;
        border-radius: 6px;
        box-sizing: border-box;
        transition: 0.3s;
    }

    input[type="text"]:focus,
    input[type="number"]:focus {
        border-color: #2e86de;
        outline: none;
    }

    button[type="submit"] {
        margin-top: 20px;
        background: #2e86de;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 6px;
        cursor: pointer;
        font-size: 16px;
        transition: background 0.3s ease;
    }

    button[type="submit"]:hover {
        background: #1b4f72;
    }

    .link-button {
        display: inline-block;
        background: #2e86de;
        color: white;
        padding: 10px 18px;
        border-radius: 6px;
        text-decoration: none;
        transition: 0.3s;
        margin: 10px auto;
    }

    .link-button:hover {
        background: #1b4f72;
    }

    .link-button.secondary {
        background: #aaa;
    }

    .link-button.secondary:hover {
        background: #888;
    }

    .center {
        text-align: center;
        margin-top: 20px;
    }

    @keyframes fadeIn {
        from { opacity: 0; }
        to { opacity: 1; }
    }

    @keyframes slideUp {
        from {
            opacity: 0;
            transform: translateY(30px);
        }
        to {
            opacity: 1;
            transform: translateY(0);
        }
    }
</style>

</body>
</html>
