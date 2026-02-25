

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class RegisterServlet
 */
@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String name = request.getParameter("name");
		String uname = request.getParameter("uname");
	        String password = request.getParameter("password");
	        String email = request.getParameter("email");
	        String mno=request.getParameter("mobile");
	        String address=request.getParameter("address")	   ;
	        Connection connection = null;
	        PreparedStatement statement = null;
	        PreparedStatement checkEmailStatement = null;
	        ResultSet resultSet = null;
	        String message = null;
	        PreparedStatement countStatement = null;
	        
	        ResultSet countResultSet = null;
	        int userCount = 0;

	        try {
	            connection = DBConnection.getConnection();
	            String checkEmailSql = "SELECT * FROM register WHERE email = ?";
	            checkEmailStatement = connection.prepareStatement(checkEmailSql);
	            checkEmailStatement.setString(1, email);
	            resultSet = checkEmailStatement.executeQuery();
	            if (resultSet.next()) {
	                // Email already exists
	            	message = "Email is already registered. Please use a different email.";
	            } else {
	            String sql = "INSERT INTO register (name,uname, password, email,mobile_no,address) VALUES (?, ?, ?,?,?,?)";
	            statement = connection.prepareStatement(sql);
	            statement.setString(1, name);
	            statement.setString(2, uname);
	            statement.setString(3, password);
	            statement.setString(4, email);
	            statement.setString(5, mno);
	            statement.setString(6, address);

	            int row = statement.executeUpdate();
	            if (row > 0) {
                    // Registration successful, redirect to login page
                    response.sendRedirect("Login.jsp");
                    return; // Exit the method after redirecting
                } else {
                    message = "Error registering user.";
                }
            }
	            String countSql = "SELECT COUNT(*) AS totalUsers FROM register"; // your user registration table
	            countStatement = connection.prepareStatement(countSql);
	            countResultSet = countStatement.executeQuery();
	            
	            if (countResultSet.next()) {
	                userCount = countResultSet.getInt("totalUsers");
	            }
        } catch (Exception e) {
            e.printStackTrace();
            message = "An error occurred while processing your request.";
        } finally {
            try {
                if (resultSet != null) resultSet.close();
                if (checkEmailStatement != null) checkEmailStatement.close();
                if (statement != null) statement.close();
                if (connection != null) connection.close();
                if (countResultSet != null) countResultSet.close();
                if (countStatement != null) countStatement.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
	        request.setAttribute("message", message);
	        request.setAttribute("userCount", userCount);
	    
        request.getRequestDispatcher("Register.jsp").forward(request, response);
	   
	}
}

	

