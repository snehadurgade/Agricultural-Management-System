<%@ page language="java" contentType="text/html; charset=ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Select Report Type</title>
</head>
<body>
    <h1>Select Purchase Report Type</h1>
    <form action="PurchaseReportServlet" method="get">
        <label for="reportType">Select Report Type:</label>
        <select name="reportType" id="reportType">
            <option value="weekly">Weekly Report</option>
            <option value="monthly">Monthly Report</option>
            <option value="yearly">Yearly Report</option>
        </select>
        <input type="submit" value="Generate Report">
    </form>
</body>
</html>
