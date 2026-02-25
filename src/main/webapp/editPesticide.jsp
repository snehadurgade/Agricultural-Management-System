<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="farm.Pesticide" %>

<html>
<head>
    <title>Edit Pesticides</title>
    <title>Edit Pesticides</title>
    <title>Edit Pesticides</title>
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

        form {
            background-color: #fff; /* White background for the form */
            padding: 20px; /* Add padding inside the form */
            border-radius: 5px; /* Rounded corners for the form */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            max-width: 500px; /* Set a maximum width for the form */
            margin: auto; /* Center the form */
        }

        p {
            margin-bottom: 15px; /* Space between form elements */
        }

        label {
            display: block; /* Make labels block elements */
            margin-bottom: 5px; /* Space between label and input */
            font-weight: bold; /* Bold text for labels */
        }

        input[type="text"],
        input[type="date"],
        textarea,
        input[type="file"],
        select {
            width: 100%; /* Full width for inputs */
            padding: 10px; /* Padding inside inputs */
            margin-top: 5px; /* Space above inputs */
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
            width: 100%; /* Full width for button */
        }

        input[type="submit"]:hover {
            background-color: #45a049; /* Darker green on hover */
        }

        a {
            display: inline-block; /* Make the link an inline block */
            margin-top: 10px; /* Space above the link */
            color: #4CAF50; /* Green color for links */
            text-decoration: none; /* Remove underline from links */
            text-align: center; /* Center the link */
        }

        a:hover {
            text-decoration: underline; /* Underline on hover */
        }

        img {
            border-radius: 4px; /* Rounded corners for images */
            margin-top: 10px; /* Space above the image */
        }
    </style>
</head>
<body>
    <h2>Edit Pesticides</h2>
    <%
        Pesticide p = (Pesticide) request.getAttribute("pesticide");
    %>
    <form action="editPesticide" method="post" enctype="multipart/form-data">
        <input type="hidden" name="id" value="<%= p.getId() %>"/>
        <input type="hidden" name="currentImage" value="<%= p.getImagePath() %>" />
        <p>Name: <input type="text" name="name" value="<%= p.getName() %>" required /></p>
       
              <p>Type:  <select name="type"  required >

 			<option value="Herbicide" <%= "Herbicide".equals(p.getType()) ? "selected" : "" %>>Herbicide</option>
        <option value="Insecticide" <%= "Insecticide".equals(p.getType()) ? "selected" : "" %>>Insecticide</option>
        <option value="Fungicide" <%= "Fungicide".equals(p.getType()) ? "selected" : "" %>>Fungicide</option>
        <option value="Rodenticides" <%= "Rodenticides".equals(p.getType()) ? "selected" : "" %>>Rodenticides</option>
        <option value="Larvicides" <%= "Larvicides".equals(p.getType()) ? "selected" : "" %>>Larvicides</option>
        <option value="Molluscicides" <%= "Molluscicides".equals(p.getType()) ? "selected" : "" %>>Molluscicides</option>
        <option value="Bactericides" <%= "Bactericides".equals(p.getType()) ? "selected" : "" %>>Bactericides</option>
        <option value="Algaecides" <%= "Algaecides".equals(p.getType()) ? "selected" : "" %>>Algaecides</option>
    </select>
</p>
        <p>Expiry Date: <input type="date" name="expDate" value="<%= p.getExpDate() %>" required /></p>
        <p>Price: <input type="text" name="price" value="<%= p.getPrice() %>" required /></p>
        <p>Description: <textarea name="desp" required><%= p.getDescription() %></textarea></p>
        <p>Current Image: <img src="<%= p.getImagePath() %>" width="100" height="100"/></p>
        <p>New Image (optional): <input type="file" name="image" /></p>
        <p><input type="submit" value="Update Pesticide" /></p>
    </form>
    <p><a href="listPesticides">Back to List</a></p>
</body>
</html>
    