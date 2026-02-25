

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

/**
 * Servlet implementation class AdminLogServlet
 */
@WebServlet("/AdminLogServlet")
public class AdminLogServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 String uname = request.getParameter("uname");
	        String password = request.getParameter("password");

	        boolean isValidUser  = login(uname, password);

	        response.setContentType("text/html");
	        PrintWriter out = response.getWriter();
	      
	        if (isValidUser ) {
	        	 
	              HttpSession session = request.getSession();
	              session.setAttribute("adminName", uname);
	        	response.sendRedirect("dashboard.jsp?message=Login Successful!");
	        } else {
	        	 response.sendRedirect("AdminLogin.jsp?error=Invalid credentials");
	        }
	    }

	    private boolean login(String uname, String password) {
	        boolean isValidUser  = false;
	  
	        try (Connection connection = DBConnection.getConnection()) {
	            String sql = "SELECT * FROM login WHERE uname = ? AND password = ?";
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


