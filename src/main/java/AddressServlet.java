

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;



@WebServlet("/AddressServlet")
public class AddressServlet extends HttpServlet {
	
	private static final long serialVersionUID = 1L;
       
	String jdbcURL = "jdbc:mysql://localhost:3306/farmer";
    String dbUser = "root";
    String dbPassword = "sneha@0119";
    

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String id = request.getParameter("id");
	        String addressLine = request.getParameter("address_line");
	        String city = request.getParameter("city");
	        String state = request.getParameter("state");
	        String zip = request.getParameter("zip");
	        String country = request.getParameter("country");

	        // Combine address parts into a full address
	        String fullAddress = addressLine + ", " + city + ", " + state + ", " + zip + ", " + country;


	        try (Connection conn =DBConnection.getConnection()) {
	            String sql = "INSERT INTO user_address ( address_line, city, state, zip, country) VALUES ( ?, ?, ?, ?, ?)";
	            PreparedStatement ps = conn.prepareStatement(sql);
	           
	         
	            ps.setString(1, addressLine);
	            ps.setString(2, city);
	            ps.setString(3, state);
	            ps.setString(4, zip);
	            ps.setString(5, country);

	            int rows = ps.executeUpdate();

	            if (rows > 0) {
	            	
	                response.sendRedirect("paymentform.jsp?id=" + id);
	            } else {
	                response.getWriter().println("Error: Address was not saved.");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	            response.getWriter().println("Database Error: " + e.getMessage());
	        } 
	    }
	}


