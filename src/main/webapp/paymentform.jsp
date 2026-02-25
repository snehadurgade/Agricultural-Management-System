<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
     <title>Payment Processing</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh; /* Full viewport height */
            margin: 0; /* Remove default margin */
            
              background-color:#88f388;
        }
        .form-container {
            background-color: white; /* White background for the form */
            padding: 20px; /* Padding around the form */
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
            width: 300px; /* Fixed width for the form */
        }
        .hidden {
            display: none;
        }
        h2 {
            text-align: center; /* Center the heading */
        }
        label {
            display: block; /* Make labels block elements */
            margin: 10px 0 5px; /* Margin for spacing */
        }
        input, select {
            width: 100%; /* Full width for inputs and selects */
            padding: 8px; /* Padding inside inputs */
            margin-bottom: 10px; /* Space below inputs */
            border: 1px solid #ccc; /* Border for inputs */
            border-radius: 4px; /* Rounded corners for inputs */
        }
        input[type="submit"] {
            background-color: #28a745; /* Green background for submit button */
            color: white; /* White text for submit button */
            border: none; /* No border for submit button */
            cursor: pointer; /* Pointer cursor on hover */
        }
        input[type="submit"]:hover {
            background-color: #218838; /* Darker green on hover */
        }
         p.instruction {
    font-size: 0.95rem;
    color: #555555;
    margin-top: 9px;
    font-style: italic;
  }
    </style>
         <script>
        function toggleCardDetails() {
            var paymentMethod = document.getElementById("paymentMethod").value;
            var cardDetails = document.getElementById("cardDetails");
            if (paymentMethod === "creditCard" || paymentMethod === "debitCard") {
                cardDetails.classList.remove("hidden");
            } else {
                cardDetails.classList.add("hidden");
            }
        }
    </script>
</head>
<body>

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
	 <div class="form-container">
        <h2>Payment Form</h2>
        <form action="PaymentServlet" method="post">
         <input type="hidden" name="id" value="<%= id %>"> 
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" required>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" required>

            <label for="amount">Amount:</label>
            <input type="number" id="amount" name="amount" value="<%= amount %>" required>

            <label for="paymentMethod">Payment Method:</label>
            <select id="paymentMethod" name="paymentMethod" onchange="toggleCardDetails()" required>
                <option value="creditCard">Credit Card</option>
                <option value="debitCard">Debit Card</option>
                <option value="cashOnDelivery">Cash on Delivery</option>
            </select>

            <div id="cardDetails" class="hidden">
                <label for="cardNumber">Card Number:</label>
                <input type="text" id="cardNumber" name="cardNumber">
                 <p class="instruction" id="instruction">Enter 16 digit</p>
   				 
  
                
                  <label for="expiry">Expiry Date:</label>
            <input type="month" id="expiry" name="expiry">

                
                <label for="cvv">CVV:</label>
                <input type="text" id="cvv" name="cvv">
                 <p class="instruction" id="instruction">Enter 3 digit</p>
            </div>

            <input type="submit" value="Submit Payment">
               <a href="Pesticides.jsp" class="btn-cancel">Cancel</a>
        </form>
	
	
	<%
            // Check if the payment status is set in the request
            String paymentStatus = request.getParameter("paymentStatus");
            if (paymentStatus != null) {
                out.println("<h3 style='text-align: center;'>Payment Status: " + paymentStatus + "</h3>");
            }
        %>
    </div>

   
</body>
</html>