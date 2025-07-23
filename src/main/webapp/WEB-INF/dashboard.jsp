  <%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@page import="com.fitness.cse.BMI"%>
<%@ page session="true" %>
<%
    if ("logout".equals(request.getParameter("action"))) {
        session.invalidate();
        response.sendRedirect("index.jsp");
        return;
    }

    String userName = (String) session.getAttribute("userName");
    if (userName == null) {
        response.sendRedirect("index.jsp#login");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>User Dashboard</title>
    <style>
    /* Page entrance animation */
body {
    animation: fadeIn 0.7s ease-in;
}

@keyframes fadeIn {
    from { opacity: 0; transform: translateY(10px); }
    to { opacity: 1; transform: translateY(0); }
}

/* Smooth card float-in effect for .tips box */
.tips {
    animation: slideIn 1s ease-in-out;
}

@keyframes slideIn {
    from { opacity: 0; transform: translateX(-50px); }
    to { opacity: 1; transform: translateX(0); }
}

/* Button click ripple effect */
button {
    position: relative;
    overflow: hidden;
}

button::after {
    content: "";
    position: absolute;
    background: rgba(255, 255, 255, 0.6);
    border-radius: 100%;
    transform: scale(0);
    animation: ripple 0.6s linear;
    pointer-events: none;
}

button:active::after {
    width: 120px;
    height: 120px;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%) scale(1);
}

@keyframes ripple {
    to {
        transform: translate(-50%, -50%) scale(2);
        opacity: 0;
    }
}

/* Glowing nav hover effect */
nav a:hover {
    background-color: #575757;
    border-radius: 5px;
    box-shadow: 0 0 8px #fff;
}

/* Heading animation */
h2 {
    animation: floatText 1s ease-in-out;
}

@keyframes floatText {
    from { transform: translateY(-20px); opacity: 0; }
    to { transform: translateY(0); opacity: 1; }
}
    .health-box {
    background-color: #ffffff;
    border: 2px solid #1C6CD5;
    border-radius: 12px;
    padding: 30px;
    margin: 40px auto;
    width: 80%;
    box-shadow: 0 5px 15px rgba(0,0,0,0.1);
}
    
        body {
            font-family: 'Segoe UI', sans-serif;
            background: linear-gradient(to right, #e0f7fa, #fce4ec);
            margin: 0;
            padding: 0;
        }

        header {
            background-color: #1C6CD5;
            padding: 25px;
            color: white;
            text-align: center;
            font-size: 26px;
            letter-spacing: 1px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        nav {
            background-color: #333;
            display: flex;
            justify-content: center;
            gap: 40px;
            padding: 12px 0;
        }

        nav a {
            color: white;
            font-size: 16px;
            text-decoration: none;
            padding: 10px 20px;
            transition: background 0.3s;
        }

        nav a:hover {
            background-color: #575757;
            border-radius: 5px;
        }

        section {
            padding: 40px 20px;
            text-align: center;
            animation: fadeSlide 0.6s ease;
        }

        h2 {
            color: #333;
            font-size: 28px;
        }

        p {
            font-size: 18px;
            margin: 10px 0;
        }

        .tips {
            margin-top: 30px;
            width: 80%;
            margin-left: auto;
            margin-right: auto;
            background: #ffffff;
            border-radius: 10px;
            padding: 20px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }

        .tips h3 {
            color: #1C6CD5;
            margin-bottom: 10px;
        }

        .tips pre {
            background-color: #f7f7f7;
            padding: 15px;
            border-left: 4px solid #1C6CD5;
            line-height: 1.6;
            white-space: pre-wrap;
            border-radius: 5px;
        }

        button {
            padding: 12px 25px;
            background-color: #1C6CD5;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        button:hover {
            background-color: #154db8;
        }

        @keyframes fadeSlide {
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
</head>
<body>

<header>
    <h1>Fitness Management</h1>
</header>

<nav>
    <a href="index.jsp">Home</a>
    <a href="profile.jsp">My Profile</a>
    <a href="dashboard.jsp?action=logout">Logout</a>
</nav>

<section>
    <h2>My Health Space</h2>
    <p>You have successfully logged in to your health space.</p>

    <%
        if (session != null) {
            int age = Integer.parseInt(session.getAttribute("age").toString());
            int heightCm = Integer.parseInt(session.getAttribute("h").toString());
            int weightKg = Integer.parseInt(session.getAttribute("w").toString());

            String result = BMI.calculateBMI(age, heightCm, weightKg);
            double bmi = Double.parseDouble(result.split("\n")[0].split(":")[1].trim());
            String category = result.split("\n")[1].split(":")[1].trim();
    %>
      
    <p><strong>Age:</strong> <%= age %> years</p>
        <p><strong>Height:</strong> <%= heightCm %> cm</p>
        <p><strong>Weight:</strong> <%= weightKg %> kg</p>

        <p><strong>BMI:</strong> <%= bmi %></p>
        <p><strong>Category:</strong> <%= category %></p>
    
      
        <%
            String dietTips = "";
            String workoutTips = "";

            if (result.contains("Underweight")) {
                dietTips = "Follow a calorie-deficit plan with lots of fiber (veggies, legumes).\n" +
                           "Avoid sugary, fatty, and salty foods. Go for home-cooked meals.\n" +
                           "Track meals to build awareness and control portions.";
                workoutTips = "Start with light exercises like walking or stretching.\n" +
                              "Gradually add strength training exercises.\n" +
                              "Consult a doctor or trainer for guidance.";
            } else if (result.contains("Normal weight")) {
                dietTips = "Maintain a balanced diet with healthy fats, proteins, and carbs.\n" +
                           "Drink plenty of water, avoid overeating, and maintain a consistent routine.\n" +
                           "Include fruits and vegetables in every meal.";
                workoutTips = "Continue regular exercise like cardio and strength training.\n" +
                              "Add variety to workouts for full-body fitness.\n" +
                              "Consider increasing intensity for progress.";
            } else if (result.contains("Overweight")) {
                dietTips = "Follow a calorie-deficit plan with plenty of fiber (vegetables, legumes).\n" +
                           "Reduce consumption of sugary, processed, and fatty foods.\n" +
                           "Track your meals to stay accountable.";
                workoutTips = "Start with moderate-intensity exercises like walking or cycling.\n" +
                              "Gradually add strength training exercises.\n" +
                              "Consult a trainer for a customized workout plan.";
            } else if (result.contains("Obese")) {
                dietTips = "Follow a calorie-deficit plan with lots of fiber (veggies, legumes).\n" +
                           "Avoid sugary, fatty, and salty foods. Focus on whole foods.\n" +
                           "Track your meals to build awareness and control portions.";
                workoutTips = "Start slow: daily walks for 20-30 minutes.\n" +
                              "Gradually add low-impact exercises like cycling or aqua aerobics.\n" +
                              "Work with a trainer to avoid injury and stay motivated.";
            }
        %>

        <div class="tips">
            <h2>Diet Tips:</h2>
            <p><%= dietTips %></p>

            <h2>Workout Tips:</h2>
            <p><%= workoutTips %></p>
        </div>

    <%
        }
    %>

    <div style="margin-top: 30px;">
        <button onclick="window.location.href='addWorkout.jsp'">Add Workout</button>
    </div>
</section>

</body>
</html> 
