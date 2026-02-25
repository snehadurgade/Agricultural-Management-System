<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Result</title>
    <style>
        table {
            width: 50%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        th, td {
            border: 1px solid #ddd;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
    </style>
</head>
<body>
    <h2 style="text-align: center;">Payment Receipt</h2>
    <table>
        <tr>
            <th>Receipt Code</th>
            <th>Name</th>
            <th>Item Name</th>
            <th>Amount</th>
            <th>Transaction Date</th>
            <th>Status</th>
        </tr>
        <tr>
            <td><%= request.getAttribute("receiptCode") %></td>
            <td><%= request.getAttribute("name") %></td>
            <td><%= request.getAttribute("itemName") %></td>
            <td><%= request.getAttribute("amount") %></td>
            <td><%= request.getAttribute("transactionDate") %></td>
            <td><%= request.getAttribute("paymentStatus") %></td>
        </tr>
    </table>
</body>
</html>