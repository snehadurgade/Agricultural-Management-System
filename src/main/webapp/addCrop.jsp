<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        adminName = "Admin"; // fallback or guest name if missing
    }
%>
<html>
<head><title>Add Crop</title>
 <link rel="stylesheet" href="style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
 <style>
        body {
            font-family: Arial, sans-serif; /* Set a default font for the body */
            
            margin: 20px; /* Add some margin around the body */
            background-color:#88f388;
        }

        h2 {
        	text-align:center;
            color: #333; /* Darker color for the heading */
        }

        form {
            background-color: #fff; /* White background for the form */
            padding: 20px; /* Add padding inside the form */
            border-radius: 5px; /* Rounded corners for the form */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            max-width: 400px; /* Set a maximum width for the form */
            margin: auto; /* Center the form */
        }

        label {
            display: block; /* Make labels block elements */
            margin-bottom: 5px; /* Space between label and input */
            font-weight: bold; /* Bold text for labels */
        }

        input[type="text"],
        input[type="file"],
        textarea {
            width: 100%; /* Full width for inputs */
            padding: 10px; /* Padding inside inputs */
            margin-bottom: 15px; /* Space between inputs */
            border: 1px solid #ccc; /* Light gray border */
            border-radius: 4px; /* Rounded corners for inputs */
            box-sizing: border-box; /* Include padding and border in width */
        }
		select{
		   width: 100%; /* Full width for inputs */
            padding: 10px; /* Padding inside inputs */
            margin-bottom: 15px; /* Space between inputs */
            border: 1px solid #ccc; /* Light gray border */
            border-radius: 4px; /* Rounded corners for inputs */
            box-sizing: border-box;
		}
        input[type="submit"] {
            background-color: #4CAF50; /* Green background for submit button */
            color: white; /* White text color for button */
            border: none; /* Remove border */
            padding: 10px 15px; /* Padding for button */
            border-radius: 4px; /* Rounded corners for button */
            cursor: pointer; /* Pointer cursor on hover */
            font-size: 16px; /* Increase font size */
        }

        input[type="submit"]:hover {
            background-color: #45a049; /* Darker green on hover */
        }

        a {
            display: inline-block; /* Make the link an inline block */
            margin-top: 10px; /* Space above the link */
            color: #4CAF50; /* Green color for links */
            text-decoration: none; /* Remove underline from links */
        }

        a:hover {
            text-decoration: underline; /* Underline on hover */
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
        </div>

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <!-- Top Navigation -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                <div class="container-fluid">
                    <button class="btn btn-primary" id="menu-toggle">
                        <i class="fas fa-bars"></i>
                        
                    </button>
                    <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            Crop
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="listCrops">View</a></li>
                            </ul>
                    
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
<h2>Add New Crop</h2>
<form action="addCrop" method="post" enctype="multipart/form-data">
    Name: <input type="text" name="name" required /><br/>
   
    Season:  <select name="type" required >

  <option value="Kharif"> Kharif</option>
  <option value="Rabi"> Rabi</option>
 
  </select>
    Start Month: <input type="text" name="startMonth" required /><br/>
    End Month: <input type="text" name="endMonth" required /><br/>
    Description: <br/>
    <textarea name="desp" rows="4" cols="50" required></textarea><br/>
    Image: <input type="file" name="image" accept="image/*" required /><br/><br/>
  	 <p><input type="submit" value="Add Crops" /></p>
</form>

 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            document.getElementById('menu-toggle').addEventListener('click', function() {
                document.getElementById('wrapper').classList.toggle('toggled');
            });
        </script>
</body>
</html>
    