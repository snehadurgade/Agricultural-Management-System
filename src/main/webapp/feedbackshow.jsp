<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
        <%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        adminName = "Admin"; // fallback or guest name if missing
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <link rel="stylesheet" href="style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    <style>
  body {
    font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
     background-color:#88f388;
    margin: 40px;
    color: #333;
  }
  table {
    border-collapse: separate;
    border-spacing: 0;
    width: 100%;
    max-width: 900px;
    margin: 0 auto;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    border-radius: 10px;
    overflow: hidden;
  }
  thead th {
    background-color: #4f46e5; /* Indigo */
    color: white;
    font-weight: 600;
    padding: 14px 20px;
    text-align: left;
    letter-spacing: 0.05em;
  }
  tbody tr:nth-child(even) {
    background-color: #f3f4f6; /* Light gray */
  }
  tbody tr:hover {
    background-color: #c7d2fe; /* Light Indigo */
    transition: background-color 0.3s ease;
    cursor: pointer;
  }
  tbody td {
    padding: 14px 20px;
    border-bottom: 1px solid #e5e7eb;
  }
</style>
</head>
<body>
<div class="d-flex" id="wrapper">
        <!-- Sidebar -->
        <div class="bg-dark border-right" id="sidebar-wrapper">
            <div class="sidebar-heading text-white p-3">Dashboard</div>
            <div class="list-group list-group-flush">
            <a href="Home.html" class="list-group-item list-group-item-action bg-dark text-white">
                    <i class="fas fa-users me-2"></i>Home
                </a>
                <a href="listCrops"
                 class="list-group-item list-group-item-action bg-dark text-white active">
                    <i class="fas fa-tachometer-alt me-2"></i>Crop Page
                </a>
                <a href="listPesticides" class="list-group-item list-group-item-action bg-dark text-white">
                    <i class="fas fa-users me-2"></i>Pesticide Page
                </a>
                <a href="#" class="list-group-item list-group-item-action bg-dark text-white">
                    <i class="fas fa-project-diagram me-2"></i>About us
                </a>
                  <a href="feedbackshow.jsp" class="list-group-item list-group-item-action bg-dark text-white">
                    <i class="fas fa-project-diagram me-2"></i>Feedback
                </a>
            </div>
        </div> <div id="page-content-wrapper">
            <!-- Top Navigation -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                <div class="container-fluid">
                    <button class="btn btn-primary" id="menu-toggle">
                        <i class="fas fa-bars"></i>
                        
                    </button>
                    <a class="nav-link " href="#" role="button" >
                            Feedback
                        </a>
                       
                    
                      <div class="dropdown ms-auto">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i><%= adminName %>
                        </a>
                        <ul class="dropdown-menu">
                           
                            
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="Home.html">Logout</a></li>
                        </ul>
                    </div>
                </div>
            </nav>
		 <%
      
        String jdbcURL = "jdbc:mysql://localhost:3306/farmer";
        String dbUser = "root";
        String dbPassword = "sneha@0119";

        try (Connection connection = DriverManager.getConnection(jdbcURL, dbUser, dbPassword)) {
            String sql = "SELECT fid, name, email,feedback FROM feedback";
            PreparedStatement statement = connection.prepareStatement(sql);
           // statement.setString(1, userId);
            ResultSet resultSet = statement.executeQuery();

            if (!resultSet.next()) {
        %>
                     <p>Your cart is empty.</p>
    <%
            } else {
    %> 
    	 	<table border="1">
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Feedback</th>
                      
                        
                    </tr>
    <%
                do {
    %>
    		 <tr>
                        <td><%= resultSet.getString("fid") %></td>
                        <td><%= resultSet.getString("name") %></td>
                        <td><%= resultSet.getString("email") %></td>
                         <td><%= resultSet.getString("feedback") %></td>
                        
                       
                    </tr>
               <%
                } while (resultSet.next());
    %>
                </table>
    <%
            }
        } catch (SQLException e) {
            out.print("Database error: " + e.getMessage());
        }
    %>	
           
           
  
</body>
</html>