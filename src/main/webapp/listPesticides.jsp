<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="farm.Pesticide" %>

<html>
<head>
    <link rel="stylesheet" href="style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
    
    <title>Pesticides List</title>
    <style>
        body {
            font-family: Arial, sans-serif; /* Set a default font for the body */
            background-color: #f9f9f9; /* Light background color */
            margin: 20px; /* Add some margin around the body */
        }

        h2 {
            color: #333; /* Darker color for the heading */
            text-align: center; /* Center the heading */
        }

        p {
            text-align: center; /* Center the paragraph */
            margin-bottom: 20px; /* Space below the paragraph */
        }

        a {
            color: #4CAF50; /* Green color for links */
            text-decoration: none; /* Remove underline from links */
            font-weight: bold; /* Bold text for links */
        }

        a:hover {
            text-decoration: underline; /* Underline on hover */
        }

        table {
            width: 100%; /* Full width for the table */
            border-collapse: collapse; /* Collapse borders */
            margin-top: 20px; /* Space above the table */
        }

        th, td {
            border: 1px solid #ccc; /* Light gray border for table cells */
            padding: 10px; /* Padding inside table cells */
            text-align: left; /* Left align text in cells */
        }

        th {
            background-color: #4CAF50; /* Green background for header */
            color: white; /* White text color for header */
        }

        tr:nth-child(even) {
            background-color: #f2f2f2; /* Light gray background for even rows */
        }

        tr:hover {
            background-color: #e0e0e0; /* Darker gray on row hover */
        }

        img {
            border-radius: 4px; /* Rounded corners for images */
        }

        .action-links {
            display: flex; /* Use flexbox for action links */
            justify-content: space-between; /* Space between links */
        }
    </style>
</head>
<body>
<div id="page-content-wrapper">
            <!-- Top Navigation -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                <div class="container-fluid">
                    <button class="btn btn-primary" id="menu-toggle">
                    <i class="fas fa-bars"></i>
                        
                    </button>
                    <a class="nav-link dropdown-toggle" href="dashboard.jsp" role="button" data-bs-toggle="dropdown">
                            Dashboard
                        </a>
                         <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="dashboard.jsp">Dashboard</a></li>
                            </ul>
                    
                    <div class="dropdown ms-auto">
                  
					<form action="SearchPesticidesServlet" method="GET">
    				<input type="text" name="query" placeholder="Search crops..." required>
    				<button type="submit">Search</button>
					</form>

                    </div>
                </div>
            </nav>
           </div> 
    <h2>Pesticides List</h2>
    <p><a href="addPesticide">Add New Pesticides</a></p>
    <table border="1" cellpadding="10">
        <tr>
            <th>ID</th>
            <th>Image</th>
            <th>Name</th>
            <th>Type</th>
            <th>Expiry Date</th>
            <th>Price</th>
            <th>Description</th>
            <th>Actions</th>
        </tr>
        <%
            List<Pesticide> pesticides = (List<Pesticide>) request.getAttribute("pesticideList");
            if (pesticides != null) {
                for (Pesticide p : pesticides) {
        %>
        <tr>
            <td><%= p.getId() %></td>
            <td><img src="<%= request.getContextPath() + "/" + p.getImagePath() %>" width="100" height="100"/></td>
            <td><%= p.getName() %></td>
            <td><%= p.getType() %></td>
            <td><%= p.getExpDate() %></td>
            <td><%= p.getPrice() %></td>
            <td><%= p.getDescription() %></td>
            <td>
                <a href="editPesticide?id=<%= p.getId() %>">Edit</a> |
                <a href="deletePesticide?id=<%= p.getId() %>" onclick="return confirm('Are you sure?')">Delete</a>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr><td colspan="8">No pesticides found.</td></tr>
        <% } %>
    </table>
     <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>
    