<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="farm.Crop" %>
<%@ page import="java.util.List" %>




<html>
<head><title>Crop List</title>
 <link rel="stylesheet" href="style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
 <style>
        body {
            font-family: Arial, sans-serif; /* Set a default font for the body */
            background-color: #f9f9f9; /* Light background color */
            margin: 20px; /* Add some margin around the body */
             
           
        }
          .search-container {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .search-container input[type="text"] {
            width: 300px; /* Width of the input field */
            padding: 10px; /* Padding inside the input */
            border: 1px solid #ccc; /* Border color */
            border-radius: 4px; /* Rounded corners */
            font-size: 16px; /* Font size */
            margin-right: 10px; /* Space between input and button */
        }

        .search-container button {
            padding: 10px 15px; /* Padding inside the button */
            background-color: #007BFF; /* Button background color */
            color: white; /* Button text color */
            border: none; /* No border */
            border-radius: 4px; /* Rounded corners */
            cursor: pointer; /* Pointer cursor on hover */
            font-size: 16px; /* Font size */
        }

        .search-container button:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }

        h2 {
            color: #333; /* Darker color for the heading */
              text-align: center; 
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
            width: 100%;
            border-collapse: collapse; /* Remove space between borders */
            margin-top: 20px; /* Add space above the table */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Add a subtle shadow */
        }

        th, td {
            border: 1px solid #dddddd; /* Light gray border */
            text-align: left;
            padding: 12px; /* Increased padding for better spacing */
        }

        th {
            background-color: #4CAF50; /* Green background for header */
            color: white; /* White text color for header */
        }

        tr:nth-child(even) {
            background-color: #f2f2f2; /* Light gray background for even rows */
        }

        tr:hover {
            background-color: #e0e0e0; /* Change background on hover */
        }

        img {
            border-radius: 5px; /* Rounded corners for images */
            transition: transform 0.2s; /* Smooth transition for hover effect */
        }

        img:hover {
            transform: scale(1.1); /* Slightly enlarge image on hover */
        }

        a {
            color: #4CAF50; /* Green color for links */
            text-decoration: none; /* Remove underline from links */
        }

        a:hover {
            text-decoration: underline; /* Underline on hover */
        }

        .no-crops {
            text-align: center; /* Center the message */
            font-style: italic; /* Italicize the message */
            color: #777; /* Gray color for the message */
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
                  
					<form action="SearchServlet" method="GET">
    				<input type="text" name="query" placeholder="Search crops..." required>
    				<button type="submit">Search</button>
					</form>

                    </div>
                </div>
            </nav>
</div>
<h2>Crop List</h2>
   
<p><a href="addCrop">Add New Crop</a></p>
<table border="1">
    <tr>
        <th>Image</th>
        <th>Name</th>
        <th>Season</th>
        <th>Start</th>
        <th>End</th>
        <th>Description</th>
        <th>Actions</th>
    </tr>

<%
    // Get the crop list from request attribute
    List<Crop> cropList = (List<Crop>) request.getAttribute("cropList");
    
    // Check if cropList is not null and contains data
    if (cropList != null && !cropList.isEmpty()) {
        for (Crop crop : cropList) {
%>
    <tr>
        <td><img src="<%= crop.getImagePath() %>" width="100"/></td>
        <td><%= crop.getName() %></td>
        <td><%= crop.getSeason() %></td>
        <td><%= crop.getStartMonth() %></td>
        <td><%= crop.getEndMonth() %></td>
        <td><%= crop.getDescription() %></td>
        <td>
            <a href="editCrop?id=<%= crop.getId() %>">Edit</a> |
            <a href="deleteCrop?id=<%= crop.getId() %>" onclick="return confirm('Are you sure?')">Delete</a>
        </td>
    </tr>
<%
        }
    } else {
%>
    <tr>
        <td colspan="7">No crops available.</td>
    </tr>
<%
    }
%>
</table>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</body>
</html>
