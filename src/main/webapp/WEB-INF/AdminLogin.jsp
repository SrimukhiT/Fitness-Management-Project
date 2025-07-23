<%@ page import="java.sql.*" %>
<%@ page import="javax.servlet.*" %>
<%@ page import="javax.servlet.http.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>

<html>
<head>

    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial;
            background: #f4f4f4;
        }
        table {
            width: 90%;
            margin: 30px auto;
            border-collapse: collapse;
            background: white;
            box-shadow: 0 0 10px #ccc;
        }
        th, td {
            border: 1px solid #ccc;
            padding: 12px;
            text-align: center;
        }
        th {
            background-color: #1C6CD5;
            color: white;
        }
        .waiting {
            background-color: orange;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
        }
        .accepted {
            color: green;
            font-weight: bold;
        }
        .deleteBtn {
            background-color: red;
            color: white;
            border: none;
            padding: 6px 12px;
            cursor: pointer;
        }
        .backBtn {
            display: block;
            width: fit-content;
            margin: 30px auto;
            padding: 10px 20px;
            background-color: #1C6CD5;
            color: white;
            text-decoration: none;
            border-radius: 6px;
            font-size: 16px;
        }
        .backBtn:hover {
            background-color: #154db8;
        }
    </style>
</head>
<body>

<%
    Connection con = null;
    try {
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fitness", "root", "");

        // Handle delete action
        String deleteEmail = request.getParameter("deleteEmail");
        if (deleteEmail != null) {
            PreparedStatement del = con.prepareStatement("DELETE FROM clients WHERE email = ?");
            del.setString(1, deleteEmail);
            del.executeUpdate();
        }

        // Handle status update
        String updateEmail = request.getParameter("updateEmail");
        if (updateEmail != null) {
            PreparedStatement pst = con.prepareStatement("UPDATE clients SET status = 1 WHERE email = ?");
            pst.setString(1, updateEmail);
            pst.executeUpdate();
        }

        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM clients");
%>

<h2 style="text-align:center;">Admin Dashboard - Client Details</h2>
<table>
    <tr>
        <th>Name</th>
        <th>Gender</th>
        <th>Address</th>
        <th>Email</th>
        <th>Mobile</th>
        <th>Status</th>
        <th>Delete</th>
    </tr>
<%
        while (rs.next()) {
            String name = rs.getString("name");
            String gender = rs.getString("gender");
            String address = rs.getString("address");
            String email = rs.getString("email");
            String mobile = rs.getString("mobile");
            int status = rs.getInt("status");
%>
    <tr>
        <td><%= name %></td>
        <td><%= gender %></td>
        <td><%= address %></td>
        <td><%= email %></td>
        <td><%= mobile %></td>
        <td>
            <% if (status == 0) { %>
                <form method="post" action="AdminLogin.jsp" style="margin:0;">
                    <input type="hidden" name="updateEmail" value="<%= email %>" />
                    <button type="submit" class="waiting">Waiting</button>
                </form>
            <% } else { %>
                <span class="accepted">Accepted</span>
            <% } %>
        </td>
        <td>
            <form method="post" action="AdminLogin.jsp" style="margin:0;">
                <input type="hidden" name="deleteEmail" value="<%= email %>" />
                <button type="submit" class="deleteBtn">Delete</button>
            </form>
        </td>
    </tr>
<%
        }
    } catch (Exception e) {
        out.println("<p>Error: " + e.getMessage() + "</p>");
    } finally {
        if (con != null) try { con.close(); } catch (Exception e) {}
    }
%>
</table>

<a href="index.jsp" class="backBtn">Back to Home</a>

</body>
</html>
