
import java.io.IOException;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.Date;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/PaymentServlet")
public class PaymentServlet extends HttpServlet {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/farmer";
    private static final String DB_USER = "root"; // Replace with your DB username
    private static final String DB_PASSWORD = "sneha@0119"; // Replace with your DB password

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
       
        String paymentMethod = request.getParameter("paymentMethod");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        double amounts = Double.parseDouble(request.getParameter("amount"));
//       
        String cardNumber = request.getParameter("cardNumber");
        String expiry = request.getParameter("expiry");
        String cvv = request.getParameter("cvv");	
        String paymentStatus;
        String amount = "0.00";
        String pname=request.getParameter(name);
        String receiptCode = generateReceiptCode();

        // Fetch the amount from the database based on the product ID
       // Default amount
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "SELECT name,price FROM pesticides WHERE id = ?";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setInt(1, Integer.parseInt(id));
                ResultSet resultSet = statement.executeQuery();
                if (resultSet.next()) {
                    amount = resultSet.getString("price");
                    pname=resultSet.getString("name");
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        if ("creditCard".equals(paymentMethod) || "debitCard".equals(paymentMethod)) {
            paymentStatus = "successful";
            System.out.println("Storing transaction for card payment: Amount = " + amount + ", Payment Method = " + paymentMethod);
          storeTransaction(amount, paymentMethod, "Success");
          request.setAttribute("receiptCode", receiptCode);
      	   request.setAttribute("name", name);
      	   request.setAttribute("amount", amounts);
            
             request.setAttribute("itemName",pname); // You can fetch the actual item name if needed
             request.setAttribute("transactionDate", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
             request.setAttribute("paymentStatus", paymentStatus);
             RequestDispatcher dispatcher = request.getRequestDispatcher("paymentResult.jsp");
             dispatcher.forward(request, response);
           
        } else if ("cashOnDelivery".equals(paymentMethod)) {
            paymentStatus = "pending"; 
            storeTransaction(amount, paymentMethod, "pending");// COD payments are pending
        } else {
            paymentStatus = "unknown"; // Handle unexpected payment methods
        }
//        
        try(Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)){
        	   String sql = "INSERT INTO payments (name, email, amount, payment_method, card_number, expiry, cvv, payment_status,receipt_code) VALUES (?, ?, ?, ?, ?, ?, ?, ?,?)";
               PreparedStatement statement = connection.prepareStatement(sql);
               statement.setString(1, name);
               statement.setString(2, email);
               statement.setDouble(3, amounts);
               statement.setString(4, paymentMethod);
               statement.setString(5, paymentMethod.equals("creditCard") || paymentMethod.equals("debitCard") ? cardNumber : null);
               statement.setString(6, paymentMethod.equals("creditCard") || paymentMethod.equals("debitCard") ? expiry : null);
               statement.setString(7, paymentMethod.equals("creditCard") || paymentMethod.equals("debitCard") ? cvv : null);
               statement.setString(8, paymentStatus);
               statement.setString(9, receiptCode);
               int row = statement.executeUpdate();
               if (row > 0) {
                   // Redirect to the receipt page with payment details
            	   request.setAttribute("receiptCode", receiptCode);
            	   request.setAttribute("name", name);
            	   request.setAttribute("amount", amounts);
                  
                  
                   request.setAttribute("itemName",pname); // You can fetch the actual item name if needed
                   request.setAttribute("transactionDate", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
                   request.setAttribute("paymentStatus", paymentStatus);
                   RequestDispatcher dispatcher = request.getRequestDispatcher("paymentResult.jsp");
                   dispatcher.forward(request, response);
               } else {
                   response.getWriter().println("Error processing payment.");
               }
           } catch (Exception e) {
               e.printStackTrace();
               response.getWriter().println("Database error: " + e.getMessage());
           }
       }
        // Simulating payment processing based on the selected method
       

        // Store transaction in the database
    
    private String generateReceiptCode() {
        return "RC" + System.currentTimeMillis();
    }

  
    private void storeTransaction(String amount, String paymentMethod, String status) {
        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
            String sql = "INSERT INTO transactions (amount, payment_method, status) VALUES (?, ?, ?)";
            try (PreparedStatement statement = connection.prepareStatement(sql)) {
                statement.setBigDecimal(1, new java.math.BigDecimal(amount));
                statement.setString(2, paymentMethod);
                statement.setString(3, status);
                statement.executeUpdate();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
} 

