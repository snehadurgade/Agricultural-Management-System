

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;



import java.sql.*;

@WebServlet("/AddToCartServlet")
public class AddToCartServlet extends HttpServlet {
    private Connection getConnection() throws SQLException {
        String jdbcURL = "jdbc:mysql://localhost:3306/farmer";
        String dbUser = "root";
        String dbPassword = "sneha@0119";
        return DriverManager.getConnection(jdbcURL, dbUser, dbPassword);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
    throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String price = request.getParameter("price");
       

        try (Connection connection = getConnection()) {
            String sql = "INSERT INTO cart (id, name, price) VALUES (?, ?, ?)";
            	
            		
            PreparedStatement statement = connection.prepareStatement(sql);
            statement.setString(1,id);
            statement.setString(2, name);
            statement.setString(3, price);
      

            statement.executeUpdate();
           
        } catch (SQLException e) {
            throw new ServletException("Database error: " + e.getMessage(), e);
            
        }

        response.sendRedirect("cart.jsp");
    }
}
