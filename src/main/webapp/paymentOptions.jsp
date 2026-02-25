<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Payment Options</title>
</head>
<body>
    <h2>Select Payment Method</h2>
    
    <%
        String id = request.getParameter("id");
        // Fetch the product price from the database
        String amount = "0.00"; // Default amount
        String dbUrl = "jdbc:mysql://localhost:3306/farmer";
        String dbUser  = "root"; // Replace with your DB username
        String dbPassword = "sneha@0119"; // Replace with your DB password

        try (Connection connection = DriverManager.getConnection(dbUrl, dbUser , dbPassword)) {
            String sql = "SELECT price FROM pesticides WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
            	   statement.setInt(1, Integer.parseInt(id));
                ResultSet resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    amount = resultSet.getString("price");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    %>

    <form action="PaymentServlet" method="post">
        <input type="hidden" name="amount" value="<%= amount %>"> <!-- Hidden field for amount -->
        <input type="hidden" name="id" value="<%= id %>"> <!-- Hidden field for product ID -->
        
        <label>
            <input type="radio" name="paymentMethod" value="gpay" required>
            Google Pay
        </label><br>
        
        <label>
            <input type="radio" name="paymentMethod" value="cod" required>
            Cash on Delivery
        </label><br><br>
        
        <input type="submit" value="Proceed to Payment">
    </form>
</body>
</html>