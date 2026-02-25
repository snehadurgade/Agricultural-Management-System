<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Pesticides Information</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 20px;
            background-color: #f9f9f9;
        }
        h2 {
            background-color: #88f388;
            text-align: center;
            margin-bottom: 30px;
            padding: 10px;
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
            background-color: #88f388;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 20px;
            padding: 20px;
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
            height: 220px;
            object-fit: cover;
        }
        .card-body {
            padding: 15px;
        }
        .card-title {
            font-size: 1.25rem;
            margin: 0 0 10px;
        }
        .card-price {
            font-size: 1.1rem;
            color: #333;
            margin: 5px 0;
        }
        .card-type {
            font-size: 0.9rem;
            color: #777;
            margin: 5px 0;
        }
        .btn {
            display: inline-block;
            margin-top: 10px;
            padding: 10px 15px;
            border: none;
            border-radius: 5px;
            background-color: #007bff;
            color: white;
            cursor: pointer;
            text-align: center;
            text-decoration: none;
        }
        .btn:hover {
            background-color: #0056b3;
        }
        .search-form {
            text-align: center;
            margin-bottom: 20px;
        }
        .search-form input[type="text"] {
            padding: 10px;
            width: 300px;
            border-radius: 5px;
            border: 1px solid #ccc;
        }
    </style>
</head>
<body>

<div>
    <jsp:include page="header1.jsp" />
</div>

<h2>Pesticides Information</h2>

<!-- Search Form -->
<div class="search-bar">
<form method="get" action="Pesticides.jsp" class="search-form">
    <input type="text" name="search" placeholder="Search by name or type" 
           value="<%= request.getParameter("search") != null ? request.getParameter("search") : "" %>">
           <input type="submit" value="Search" >
   </form>
</div>
<!-- Pesticides Listing -->
<div class="card-deck">
    <%
        String DB_URL = "jdbc:mysql://localhost:3306/farmer";
        String USER = "root"; // change if needed
        String PASSWORD = "sneha@0119";

        String search = request.getParameter("search");
        String sql;

        if (search != null && !search.trim().isEmpty()) {
            sql = "SELECT id, name, type, price FROM pesticides WHERE name LIKE ? OR type LIKE ?";
        } else {
            sql = "SELECT id, name, type, price FROM pesticides";
        }

        try (Connection connection = DriverManager.getConnection(DB_URL, USER, PASSWORD);
             PreparedStatement ps = connection.prepareStatement(sql)) {

            if (search != null && !search.trim().isEmpty()) {
                ps.setString(1, "%" + search + "%");
                ps.setString(2, "%" + search + "%");
            }

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int id = rs.getInt("id");
                String name = rs.getString("name");
                String type = rs.getString("type");
                int price = rs.getInt("price");
    %>
                <div class="card">
                    <img class="card-img-top" src="PestRetriveServlet?id=<%= id %>" alt="<%= name %>">
                    <div class="card-body">
                        <h5 class="card-title"><%= name %></h5>
                        <h5 class="card-price">₹<%= price %></h5>
                        <h4 class="card-type"><%= type %></h4>
                        <form action="AddToCartServlet" method="post">
                            <input type="hidden" name="id" value="<%= id %>">
                            <input type="hidden" name="name" value="<%= name %>">
                            <input type="hidden" name="price" value="<%= price %>">
                            <input type="submit" class="btn btn-primary" value="Add to Cart">
                        </form>
                        <form action="address.jsp" method="get">
                            <input type="hidden" name="id" value="<%= id %>">
                            <input type="submit" class="btn btn-success" value="Buy Now">
                        </form>
                    </div>
                </div>
    <%
            }
        } catch (SQLException e) {
    %>
        <div style="color: red ; text-align: center;">
            Error fetching pesticides: <%= e.getMessage() %>
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