<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.sql.*" %>
<html>
<head>
    <link rel="stylesheet" href="styles.css">
    <title>Shopping Cart</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
</head>
<body>

<nav class="navbar navbar-expand-lg bg-body-tertiary">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">Farm</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link active" href="Home.html">Home</a></li>
        <li class="nav-item"><a class="nav-link" href="Crops.jsp">Crops</a></li>
        <li class="nav-item"><a class="nav-link" href="feedback.jsp">Feedback</a></li>
        <li class="nav-item"><a class="nav-link" href="aboutus.jsp">About us</a></li>
      
      </ul>
      <form class="d-flex" role="search">
        <input class="form-control me-2" type="search" placeholder="Search">
        <button class="btn btn-outline-success" type="submit">Search</button>
      </form>
    </div>
  </div>
</nav>

<%
    String jdbcURL = "jdbc:mysql://localhost:3306/farmer";
    String dbUser = "root";
    String dbPassword = "sneha@0119";
    
    String action = request.getParameter("action");
    String itemId = request.getParameter("id");

    try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
        if ("remove".equals(action) && itemId != null) {
            String deleteSQL = "DELETE FROM cart WHERE id = ?";
            try (PreparedStatement deleteStmt = connection.prepareStatement(deleteSQL)) {
                deleteStmt.setString(1, itemId);
                deleteStmt.executeUpdate();
            }
        }

        String sql = "SELECT id, name, price FROM cart";
        PreparedStatement statement = connection.prepareStatement(sql);
        ResultSet resultSet = statement.executeQuery();

        if (!resultSet.isBeforeFirst()) {
%>
            <p class="m-4">Your cart is empty.</p>
<%
        } else {
%>
        <div class="container mt-5">
            <h1>Your Shopping Cart</h1>
            <table class="table table-bordered table-striped">
                <thead class="table-dark">
                    <tr>
                        <th>Product ID</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
<%
            while (resultSet.next()) {
%>
                    <tr>
                        <td><%= resultSet.getString("id") %></td>
                        <td><%= resultSet.getString("name") %></td>
                        <td><%= resultSet.getString("price") %></td>
                       <td>
    <div class="d-flex gap-2">
        <form method="post">
            <input type="hidden" name="id" value="<%= resultSet.getString("id") %>">
            <button type="submit" name="action" value="remove" class="btn btn-danger btn-sm">Remove</button>
        </form>
        <form action="address.jsp" method="get">
            <input type="hidden" name="id" value="<%= resultSet.getString("id") %>">
            <button type="submit" class="btn btn-success btn-sm">Buy Now</button>
        </form>
    </div>
</td>
                       
                    </tr>
<%
            }
%>
                </tbody>
            </table>
        </div>
<%
        }
    } catch (SQLException e) {
        out.print("Database error: " + e.getMessage());
    }
%>