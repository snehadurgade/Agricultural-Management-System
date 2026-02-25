<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Success</title>
     <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 20px;
            text-align: center;
        }
        .container {
            background: white;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            display: inline-block;
            max-width: 400px;
            margin: auto;
        }
        h2 {
            color: #28a745; /* Green color for success */
        }
        p {
            font-size: 16px;
            margin: 10px 0;
        }
        a {
            text-decoration: none;
            color: #007bff; /* Blue color for links */
            font-weight: bold;
        }
        a:hover {
            text-decoration: underline; /* Underline on hover */
        }
    </style>
</head>
<body>
    <h2>Payment Successful!</h2>
    <p>Thank you for your purchase. Your transaction has been completed.</p>
    <a href="Pesticides.jsp">Return to Product Page</a>
</body>
</html>