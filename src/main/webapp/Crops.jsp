<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Crops Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f9f9f9;
        }
        h2 {
            text-align: center;
            margin-bottom: 30px;
            background-color:#88f388;
        }
        .search-bar {
            text-align: center;
            margin-bottom: 30px;
        }
        .search-bar input[type="text"] {
            padding: 10px;
            width: 300px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .search-bar input[type="submit"] {
            padding: 10px 20px;
            border: none;
            background-color: #4CAF50;
            color: white;
            border-radius: 5px;
            cursor: pointer;
        }
        .card-deck {
            background-color:#88f388;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
        }
        .card {
            background: #fff;
            width: 300px;
            border: 1px solid #ddd;
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 4px 8px rgba(0,0,0,0.1);
            transition: box-shadow 0.3s ease;
        }
        .card:hover {
            box-shadow: 0 8px 16px rgba(0,0,0,0.2);
        }
        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .card-body {
            padding: 15px;
        }
        .card-title {
            font-size: 1.25rem;
            margin: 0 0 10px;
        }
        .card-text {
            font-size: 0.9rem;
            color: #555;
        }
        .list-group {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        .list-group-item {
            padding: 10px 15px;
            border-top: 1px solid #ddd;
            font-size: 0.85rem;
            color: #777;
        }
    </style>
</head>
<body>
<div>
    <jsp:include page="header1.jsp" />
</div>

<h2>Crops Information</h2>

<!-- Search Form -->
<div class="search-bar">
    <form method="get" action="">
        <input type="text" name="search" placeholder="Search crop by name..." value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
        <input type="submit" value="Search">
    </form>
</div>

<div class="card-deck">
    <%
        String DB_URL = "jdbc:mysql://localhost:3306/farmer";
        String USER = "root";
        String PASSWORD = "sneha@0119";
        String searchTerm = request.getParameter("search");
        String query;

        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            query = "SELECT id, name, season, start_month, end_month, desp FROM crops WHERE name LIKE ?";
        } else {
            query = "SELECT id, name, season, start_month, end_month, desp FROM crops";
        }

        try (Connection connection = DriverManager.getConnection(DB_URL, USER, PASSWORD);
             PreparedStatement stmt = connection.prepareStatement(query)) {

            if (searchTerm != null && !searchTerm.trim().isEmpty()) {
                stmt.setString(1, "%" + searchTerm + "%");
            }

            try (ResultSet rs = stmt.executeQuery()) {
                boolean found = false;
                while (rs.next()) {
                    found = true;
                    int id = rs.getInt("id");
                    String name = rs.getString("name");
                    String season = rs.getString("season");
                    String smonth = rs.getString("start_month");
                    String emonth = rs.getString("end_month");
                    String desp = rs.getString("desp");
    %>
                    <div class="card">
                        <img class="card-img-top" src="CropRetriveServlet?id=<%= id %>" alt="Crop image">
                        <div class="card-body">
                            <h5 class="card-title"><%= name %></h5>
                            <p class="card-text"><%= desp %></p>
                        </div>
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item"><strong>Season:</strong> <%= season %></li>
                            <li class="list-group-item"><strong>Start Month:</strong> <%= smonth %></li>
                            <li class="list-group-item"><strong>End Month:</strong> <%= emonth %></li>
                        </ul>
                    </div>
    <%
                }
                if (!found) {
    %>
                    <div style="text-align: center; color: #888;">No crops found matching "<%= searchTerm %>".</div>
    <%
                }
            }
        } catch (SQLException e) {
    %>
            <div style="color: red; text-align: center;">
                Error fetching crops: <%= e.getMessage() %>
            </div>
    <%
        }
    %>
</div>

<div>
    <jsp:include page="footer.jsp" />
</div>
</body>
</html>