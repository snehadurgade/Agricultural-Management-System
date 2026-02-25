<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<html>
<head>   <title>Delete Crop Confirmation</title>
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
            margin-top: 10px; /* Space above the button */
        }

        input[type="submit"]:hover {
            background-color: #c9302c; /* Darker red on hover */
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
<h2>Are you sure you want to delete this crop?</h2>
<form action="deleteCrop" method="post">
    <input type="hidden" name="id" value="<%= request.getParameter("id") %>"/>
    <input type="submit" value="Yes, Delete" />
    <a href="listCrops">Cancel</a>
</form>
</body>
</html>
    