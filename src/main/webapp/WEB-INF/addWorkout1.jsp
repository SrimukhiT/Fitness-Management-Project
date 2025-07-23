<%@ page import="java.sql.*, java.text.SimpleDateFormat, java.util.*, java.text.DecimalFormat" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Fitness Management</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        /* Global styles */
        body {
            font-family: 'Arial', sans-serif;
            background-color: #f4f7fc;
            color: #333;
            margin: 0;
            padding: 0;
        }

        /* Header Styles */
        header {
            background-color: #1C6CD5;
            color: white;
            padding: 20px 0;
            text-align: center;
            font-size: 2em;
            animation: fadeInDown 1s ease-out;
               box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }

        /* Menu Styles */
        .menu {
            background-color: #333;
            padding: 15px 0;
            text-align: center;
            animation: fadeInUp 1s ease-out;
        }

        .menu a {
            color: white;
            margin: 0 20px;
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s;
        }

        /* Home button white color */
        .menu a.home {
            color: white !important;
        }

        .menu a:hover {
            color: #ff9800;
        }

        /* Table Styles */
        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
        }

        table th, table td {
            padding: 12px;
            text-align: center;
            border: 1px solid #ddd;
        }

        table th {
            background-color: #2196F3;
            color: white;
        }

        /* Notification Styles */
        .notification {
            padding: 15px;
            margin: 20px;
            border-radius: 5px;
            text-align: center;
        }

        .success {
            background-color: #4caf50;
            color: white;
        }

        .error {
            background-color: #f44336;
            color: white;
        }

        .info {
            background-color: #2196F3;
            color: white;
        }

        /* Charts Layout */
        .charts {
            display: flex;
            justify-content: space-evenly;
            flex-wrap: wrap;
            gap: 30px;
            padding: 30px 0;
        }

        /* Animation */
        @keyframes fadeInDown {
            from { opacity: 0; transform: translateY(-20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        @keyframes fadeInUp {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>

<header>
    <h1>Fitness Management</h1>
</header>

<div class="menu">
    <!-- Modified links with appropriate hrefs -->
    <a href="index.jsp" class="home">Home</a>
    <a href="profile.jsp">My Profile</a>
    <a href="index.jsp">Logout</a>
</div>

<%
    String message = "";
    String email = request.getParameter("userEmail");
    String weight = request.getParameter("weight");
    String bmi = request.getParameter("bmi");

    java.util.Date today = new java.util.Date();
    String todayDate = new SimpleDateFormat("yyyy-MM-dd").format(today);
    boolean success = false;
    DecimalFormat df = new DecimalFormat("#.##");

    List<Map<String, String>> records = new ArrayList<>();
    Set<String> allWorkoutDates = new HashSet<>();
    Set<String> doneDates = new HashSet<>();

    int doneDays = 0;
    int skippedDays = 0;
    double startWeight = -1;
    double endWeight = -1;
    java.sql.Date firstDate = null, lastDate = null;

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitness", "root", "");

        // Check if workout for today already exists
        String checkSql = "SELECT COUNT(*) FROM workout WHERE email=? AND date=?";
        PreparedStatement checkPs = conn.prepareStatement(checkSql);
        checkPs.setString(1, email);
        checkPs.setString(2, todayDate);
        ResultSet checkRs = checkPs.executeQuery();
        checkRs.next();
        int countToday = checkRs.getInt(1);

        if (countToday == 0) {
            String sql = "INSERT INTO workout (date, weight, bmi, status, email) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, todayDate);
            ps.setString(2, weight);
            ps.setDouble(3, Double.parseDouble(bmi));
            ps.setInt(4, 1); // done
            ps.setString(5, email);

            int result = ps.executeUpdate();
            if (result > 0) {
                message = "Workout added successfully!";
                success = true;
            } else {
                message = "Failed to add workout.";
            }
            ps.close();
        } else {
            message = "Workout for today already exists!";
            success = true;
        }

        checkPs.close();
        conn.close();
    } catch (Exception e) {
        message = "Error: " + e.getMessage();
    }
%>

<div class="notification <%= success ? "success" : "error" %>">
    <strong><%= message %></strong>
</div>

<%
    if (success) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitness", "root", "");

            String fetchSql = "SELECT date, weight, bmi, status FROM workout WHERE email=? ORDER BY date";
            PreparedStatement fetchPs = conn.prepareStatement(fetchSql);
            fetchPs.setString(1, email);
            ResultSet rs = fetchPs.executeQuery();

            while (rs.next()) {
                String date = rs.getString("date");
                java.sql.Date sqlDate = rs.getDate("date");
                int status = rs.getInt("status");

                if (firstDate == null || sqlDate.before(firstDate)) {
                    firstDate = sqlDate;
                }
                if (lastDate == null || sqlDate.after(lastDate)) {
                    lastDate = sqlDate;
                }

                allWorkoutDates.add(date);
                if (status == 1) doneDates.add(date); // ✅ unique done days only

                String weightVal = rs.getString("weight");
                double bmiVal = rs.getDouble("bmi");

                if (startWeight == -1) {
                    startWeight = Double.parseDouble(weightVal);
                }
                endWeight = Double.parseDouble(weightVal);

                Map<String, String> record = new HashMap<>();
                record.put("date", date);
                record.put("weight", weightVal);
                record.put("bmi", df.format(bmiVal));
                record.put("status", status == 1 ? "Done" : "Pending");
                records.add(record);
            }

            doneDays = doneDates.size(); // ✅ only unique done days

            if (firstDate != null && lastDate != null) {
                Calendar cal = Calendar.getInstance();
                cal.setTime(firstDate);
                while (!cal.getTime().after(lastDate)) {
                    String checkDate = new SimpleDateFormat("yyyy-MM-dd").format(cal.getTime());
                    if (!allWorkoutDates.contains(checkDate)) {
                        skippedDays++;
                    }
                    cal.add(Calendar.DATE, 1);
                }
            }
%>

<h3>All Workout Entries:</h3>
<table>
    <tr>
        <th>Date</th>
        <th>Weight (kg)</th>
        <th>BMI</th>
        <th>Status</th>
    </tr>
    <% for (Map<String, String> row : records) { %>
        <tr>
            <td><%= row.get("date") %></td>
            <td><%= row.get("weight") %></td>
            <td><%= row.get("bmi") %></td>
            <td><%= row.get("status") %></td>
        </tr>
    <% } %>
</table>

<h3>Workout Summary:</h3>
<p>Days Active: <strong><%= doneDays %> / 30</strong></p>
<% if (doneDays > 0) { %>
    <p style="color:green;">💪 Great job staying consistent! Keep pushing forward!</p>
<% } %>

<p>Days Skipped: <strong><%= skippedDays %> / 30</strong></p>
<% if (skippedDays > 0) { %>
    <p style="color: orange;">🔁 Missed a few days? No worries! Start again and stay strong!</p>
<% } %>

<% if ((doneDays + skippedDays) >= 30) { %>
    <p style="color: green;"><strong>🎉 Workout plan successfully completed. Congratulations!</strong></p>
    <p>Start Weight: <%= df.format(startWeight) %> kg</p>
    <p>End Weight: <%= df.format(endWeight) %> kg</p>
<% } %>

<%
            rs.close();
            fetchPs.close();
            conn.close();
        } catch (Exception e) {
            out.println("<p>Error displaying workout: " + e.getMessage() + "</p>");
        }
    }
%>
<h3>Workout Visualization:</h3>

<!-- Flex container for cards -->
<div style="display: flex; justify-content: center; gap: 20px; flex-wrap: nowrap;">

  <!-- Card 1: Workout Status -->
  <div style="background: #fff; border: 1px solid #ddd; border-radius: 8px; padding: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); max-width: 300px;">
    <h4 style="text-align: center;">Workout Status</h4>
    <canvas id="workoutStatusChart" style="width: 100%; height: 200px;"></canvas>
  </div>

  <!-- Card 2: Weight Progress -->
  <div style="background: #fff; border: 1px solid #ddd; border-radius: 8px; padding: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); max-width: 300px;">
    <h4 style="text-align: center;">Weight Progress</h4>
    <canvas id="weightProgressChart" style="width: 100%; height: 200px;"></canvas>
  </div>

  <!-- Card 3: BMI Progress -->
  <div style="background: #fff; border: 1px solid #ddd; border-radius: 8px; padding: 15px; box-shadow: 0 2px 5px rgba(0,0,0,0.1); max-width: 300px;">
    <h4 style="text-align: center;">BMI Progress</h4>
    <canvas id="bmiProgressChart" style="width: 100%; height: 200px;"></canvas>
  </div>

</div>

<!-- Chart.js script -->
<script>
  const workoutStatusCtx = document.getElementById('workoutStatusChart').getContext('2d');
  const weightProgressCtx = document.getElementById('weightProgressChart').getContext('2d');
  const bmiProgressCtx = document.getElementById('bmiProgressChart').getContext('2d');

  const workoutStatusData = {
    labels: ['Completed', 'Skipped'],
    datasets: [{
      label: 'Workout Status',
      data: [<%= doneDays %>, <%= skippedDays %>],
      backgroundColor: ['#4caf50', '#f44336'],
      borderColor: ['#4caf50', '#f44336'],
      borderWidth: 1
    }]
  };

  const weightProgressData = {
    labels: ['Start Weight', 'End Weight'],
    datasets: [{
      label: 'Weight Progress (kg)',
      data: [<%= startWeight %>, <%= endWeight %>],
      backgroundColor: ['#2196F3', '#ff9800'],
      borderColor: ['#2196F3', '#ff9800'],
      borderWidth: 1
    }]
  };

  const bmiProgressData = {
    labels: ['Start BMI', 'End BMI'],
    datasets: [{
      label: 'BMI',
      data: [<%= startWeight %>, <%= endWeight %>],
      backgroundColor: ['#9c27b0', '#00bcd4'],
      borderColor: ['#9c27b0', '#00bcd4'],
      borderWidth: 1
    }]
  };

  new Chart(workoutStatusCtx, {
    type: 'pie',
    data: workoutStatusData
  });

  new Chart(weightProgressCtx, {
    type: 'bar',
    data: weightProgressData
  });

  new Chart(bmiProgressCtx, {
    type: 'bar',
    data: bmiProgressData
  });
</script>


</body>
</html>
