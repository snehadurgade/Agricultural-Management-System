<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="farm.Pesticide" %>
<html>
<head>
    <title>Delete Pesticide</title>
     <style>
        body {
            font-family: Arial, sans-serif; /* Set a default font for the body */
            background-color: #f9f9f9; /* Light background color */
            margin: 20px; /* Add some margin around the body */
        }

        h2 {
            color: #d9534f; /* Red color for the heading to indicate danger */
            text-align: center; /* Center the heading */
        }

        p {
            text-align: center; /* Center the text */
            font-size: 18px; /* Increase font size for better readability */
            margin-bottom: 20px; /* Space below the paragraph */
        }

        form {
            background-color: #fff; /* White background for the form */
            padding: 20px; /* Add padding inside the form */
            border-radius: 5px; /* Rounded corners for the form */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow for depth */
            max-width: 400px; /* Set a maximum width for the form */
            margin: auto; /* Center the form */
            text-align: center; /* Center text in the form */
        }

        input[type="submit"] {
            background-color: #d9534f; /* Red background for delete button */
            color: white; /* White text color for button */
            border: none; /* Remove border */
            padding: 10px 15px; /* Padding for button */
            border-radius: 4px; /* Rounded corners for button */
            cursor: pointer; /* Pointer cursor on hover */
            font-size: 16px; /* Increase font size */
            margin-right: 10px; /* Space between buttons */
        }

        input[type="submit"]:hover {
            background-color: #c9302c; /* Darker red on hover */
        }

        a {
            color: #4CAF50; /* Green color for cancel link */
            text-decoration: none; /* Remove underline from links */
            font-size: 16px; /* Increase font size */
        }

        a:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>
    <h2>Confirm Delete</h2>
    <p>Are you sure you want to delete this pesticide?</p>
    <form action="deletePesticide" method="get">
        <input type="hidden" name="id" value="${param.id}">
        <input type="submit" value="Yes, Delete" />
        <a href="listPesticides">Cancel</a>
    </form>
</body>
</html>
    