<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Result</title>
    <style>
        table {
            width: 60%;
            border-collapse: collapse;
            margin: 20px auto;
            font-family: Arial, sans-serif;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        h2 {
            text-align: center;
            font-family: Arial, sans-serif;
        }
        .btn-cancel {
            display: block;
            width: 100px;
            margin: 20px auto;
            text-align: center;
            padding: 10px;
            background-color: #007BFF; /* Blue */
            text-decoration: none;
            color: white;
            border-radius: 5px;
        }
        .btn-cancel:hover {
            background-color: #0056b3; /* Darker blue on hover */
        }
    </style>
</head>
<body>
    <h2>Payment Receipt</h2>
    <table>
        <tr>
            <th>Receipt Code</th>
            <td><%= request.getAttribute("receiptCode") %></td>
        </tr>
        <tr>
            <th>Name</th>
            <td><%= request.getAttribute("name") %></td>
        </tr>
        <tr>
            <th>Price</th>
            <td><%= request.getAttribute("amount") %></td>
        </tr>
        <tr>
            <th>Item Name</th>
            <td><%= request.getAttribute("itemName") %></td>
        </tr>
        <tr>
            <th>Transaction Date</th>
            <td><%= request.getAttribute("transactionDate") %></td>
        </tr>
        <tr>
            <th>Status</th>
            <td><%= request.getAttribute("paymentStatus") %></td>
        </tr>
    </table>
    <a href="Pesticides.jsp" class="btn-cancel">Done</a>
</body>
</html>