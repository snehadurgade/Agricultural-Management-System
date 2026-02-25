

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


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String uname = request.getParameter("uname");
	        String password = request.getParameter("password");

	        boolean isValidUser  = login(uname, password);

	        response.setContentType("text/html");
	        PrintWriter out = response.getWriter();
	        if (isValidUser ) {
	        	response.sendRedirect("Crops.jsp");
	            out.println("<h2>Login successful!</h2>");
	        } else {
	            out.println("<h2>Invalid username or password.</h2>");
	        }
	    }

	    private boolean login(String uname, String password) {
	        boolean isValidUser  = false;
	  
	        try (Connection connection = DBConnection.getConnection()) {
	            String sql = "SELECT * FROM register WHERE uname = ? AND password = ?";
	            PreparedStatement preparedStatement = connection.prepareStatement(sql);
	            preparedStatement.setString(1, uname);
	            preparedStatement.setString(2, password);

	            ResultSet resultSet = preparedStatement.executeQuery();
	            isValidUser  = resultSet.next(); // If a record is found, the user is valid
	            
	        } catch (Exception e) {
	            e.printStackTrace();
	        }

	        return isValidUser ;
	    }
	

	}


