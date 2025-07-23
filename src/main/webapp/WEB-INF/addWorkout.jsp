<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.fitness.cse.BMI" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fitness Management</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #f0f4ff, #e3f2fd);
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #1C6CD5;
            padding: 25px;
            color: white;
            text-align: center;
            font-size: 26px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        nav {
            background-color: #333;
            display: flex;
            justify-content: center;
            padding: 12px 0;
            gap: 40px;
        }

        nav a {
            color: white;
            font-size: 16px;
            text-decoration: none;
            padding: 10px 20px;
            transition: background-color 0.3s ease;
        }

        nav a:hover {
            background-color: #575757;
            border-radius: 5px;
        }

        section {
            padding: 40px 20px;
            text-align: center;
            animation: fadeIn 0.5s ease-in-out;
        }

        h2, h3 {
            color: #1C6CD5;
        }

        label {
            font-size: 18px;
            font-weight: bold;
        }

        input[type="number"] {
            padding: 10px;
            margin-top: 10px;
            width: 200px;
            font-size: 16px;
            border-radius: 6px;
            border: 1px solid #ccc;
        }

        input[type="submit"] {
            padding: 12px 25px;
            background-color: #1C6CD5;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            margin-top: 20px;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #154db8;
        }

        p {
            font-size: 18px;
            color: #333;
        }

        @keyframes fadeIn {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
    </style>

    <script>
        function autoSubmit() {
            document.getElementById("weightForm").submit();
        }
    </script>
</head>
<body>

<header>
    <h1>Fitness Management</h1>
</header>

<nav>
    <a href="index.jsp">Home</a>
    <a href="profile.jsp">My Profile</a>
    <a href="dashboard.jsp">Dashboard</a>
    <!-- Added Logout Button -->
    <a href="index.jsp">Logout</a>
</nav>

<section>
    <h2>Enter Your Workout Details</h2>

    <%
        String heightStr = (String) session.getAttribute("h");
        Integer height = (heightStr != null) ? Integer.parseInt(heightStr) : 0;

        String userEmail = (String) session.getAttribute("userEmail");
        int age = (Integer.parseInt(session.getAttribute("age").toString()));
        String bmiResult = "";
        String bmiCategory = "";
        double weight = 0.0;
        String weightInput = request.getParameter("weight");
        if (weightInput != null && !weightInput.isEmpty()) {
            weight= Double.parseDouble(weightInput);
            bmiResult = BMI.calculateBMI(age, height, weight);
            String[] bmiDetails = bmiResult.split("\n");
            bmiCategory = bmiDetails.length > 1 ? bmiDetails[1].replace("Category: ", "") : "";
        }
    %>

    <form method="post" id="weightForm" action="">
        <label>Enter Today’s Weight (kg):</label><br>
        <input type="number" name="weight" value="<%= (weightInput != null) ? weightInput : "" %>" required step="0.1"><br><br>
<input type="submit" value="Enter">

    </form>

    <%
        if (!bmiResult.isEmpty()) {
    %>
       <h3>Your BMI:</h3>
          <p><%= bmiResult.split("\n")[0].replace("BMI: ", "") %></p>
       
        <h3>Category:</h3>
        <p><%= bmiCategory %></p>

        <form action="addWorkout1.jsp" method="post">
            <input type="hidden" name="weight" value="<%= weight %>">
            <input type="hidden" name="bmi" value="<%= BMI.onlyBMI(age, height, weight) %>">
            <input type="hidden" name="userEmail" value="<%= userEmail %>">
            <input type="submit" value="Add Today">
        </form>
    <%
        }
    %>
</section>

</body>
</html>
