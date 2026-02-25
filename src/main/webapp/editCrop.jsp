<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="farm.Crop" %>

<html>
<head>
    <title>Edit Crop</title>
    
     <style>
        body {
            font-family: Arial, sans-serif; /* Set a default font for the body */
            background-color: #f9f9f9; /* Light background color */
            margin: 20px; /* Add some margin around the body */
        }

        h2 {
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

        img {
            border: 1px solid #ccc; /* Light gray border around the image */
            border-radius: 4px; /* Rounded corners for the image */
            margin-bottom: 15px; /* Space below the image */
        }
    </style>
</head>
<body>

<%
    Crop crop = (Crop) request.getAttribute("crop");
    if (crop == null) {
%>
    <p style="color:red;">Error: Crop data not available.</p>
    <a href="listCrops">Back to Crop List</a>
<%
    } else {
%>

<h2>Edit Crop</h2>
<form action="editCrop" method="post" enctype="multipart/form-data">
    <input type="hidden" name="id" value="<%= crop.getId() %>" />
    <input type="hidden" name="currentImage" value="<%= crop.getImagePath() %>" />
    Name: <input type="text" name="name" value="<%= crop.getName() %>" required /><br/>
    Season: <input type="text" name="season" value="<%= crop.getSeason() %>" required /><br/>
    Start Month: <input type="text" name="startMonth" value="<%= crop.getStartMonth() %>" required /><br/>
    End Month: <input type="text" name="endMonth" value="<%= crop.getEndMonth() %>" required /><br/>
    Description:<br/>
    <textarea name="desp" rows="4" cols="50" required><%= crop.getDescription() %></textarea><br/>
    Current Image:<br/>
    <img src="<%= crop.getImagePath() %>" width="100"/><br/>
    Upload New Image: <input type="file" name="image" accept="image/*"/><br/><br/>
    <input type="submit" value="Update Crop" />
</form>

<a href="listCrops">Back to Crop List</a>

<%
    }
%>

</body>
</html>

