

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class ReceiptServlet
 */
@WebServlet("/ReceiptServlet")
public class ReceiptServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	 private static final String DB_URL = "jdbc:mysql://localhost:3306/farmer";
	    private static final String DB_USER = "root"; // Replace with your DB username
	    private static final String DB_PASSWORD = "sneha@0119"; // Replace with your DB password
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		 String transactionId = request.getParameter("tid");
	        
	        try (Connection connection = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD)) {
	            String sql = "SELECT amount, payment_method, status FROM transactions WHERE tid = ?";
	            PreparedStatement statement = connection.prepareStatement(sql);
	            statement.setString(1, transactionId);
	            ResultSet resultSet = statement.executeQuery();
	            
	            if (resultSet.next()) {
	                String amount = resultSet.getString("amount");
	                String paymentMethod = resultSet.getString("payment_method");
	                String status = resultSet.getString("status");
	                
	                request.setAttribute("amount", amount);
	                request.setAttribute("paymentMethod", paymentMethod);
	                request.setAttribute("status", status);
	                
	                request.getRequestDispatcher("receipt.jsp").forward(request, response);
	            } else {
	                response.getWriter().println("No transaction found for the given ID.");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().println("Error retrieving transaction data.");
	        }
	    }
	}

	

