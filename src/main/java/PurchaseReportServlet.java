

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
import java.sql.SQLException;
import java.sql.Statement;


@WebServlet("/PurchaseReportServlet")
public class PurchaseReportServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	 private static final String DB_URL = "jdbc:mysql://localhost:3306/farmer";
	    private static final String USER = "root";
	    private static final String PASSWORD = "sneha@0119";
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		   String reportType = request.getParameter("reportType");
	        String query = buildQuery(reportType);
	        
	        response.setContentType("text/html");
	        PrintWriter out = response.getWriter();
	        
	        try (Connection conn = DBConnection.getConnection();
	             Statement stmt = conn.createStatement();
	             ResultSet rs = stmt.executeQuery(query)) {
	            
	            out.println("<html><body>");
	            out.println("<h1>Purchase Report</h1>");
	            
	            if (rs.next()) {
	                out.println("<table border='1'><tr><th>Product Name</th><th>Total Purchased</th></tr>");
	                
	                do {
	                    int productId = rs.getInt("id");
	                    int totalPurchased = rs.getInt("total_purchased");
	                    
	                    // Fetch product details from pesticides table
	                    String productQuery = "SELECT name FROM pesticides WHERE id = ?";
	                    try (PreparedStatement ps = conn.prepareStatement(productQuery)) {
	                        ps.setInt(1, productId);
	                        ResultSet productRs = ps.executeQuery();
	                        if (productRs.next()) {
	                            String productName = productRs.getString("name");
	                            out.println("<tr><td>" + productName + "</td><td>" + totalPurchased + "</td></tr>");
	                        }
	                    }
	                } while (rs.next());
	                
	                out.println("</table>");
	            } else {
	                out.println("<p>No data available for the selected period.</p>");
	            }
	            
	            out.println("</body></html>");
	        } catch (SQLException e) {
	            out.println("<p>Error fetching data: " + e.getMessage() + "</p>");
	        }
	    }

	    private String buildQuery(String reportType) {
	    	String query = "SELECT product_id, SUM(quantity) AS total_purchased FROM purchases ";
	        
	        if ("weekly".equals(reportType)) {
	            query += "WHERE purchase_date >= CURRENT_DATE - INTERVAL 7 DAY ";
	        } else if ("monthly".equals(reportType)) {
	            query += "WHERE purchase_date >= CURRENT_DATE - INTERVAL 30 DAY ";
	        } else if ("yearly".equals(reportType)) {
	            query += "WHERE purchase_date >= CURRENT_DATE - INTERVAL 365 DAY ";
	        }
	        query += "GROUP BY id";
	        return query;
	}

	

}
