

import jakarta.servlet.ServletException;
import farm.Pesticide;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import farm.Crop;


@WebServlet("/SearchPesticidesServlet")
public class SearchPesticidesServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
   
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException { 
		
	    
	        String query = request.getParameter("query");
	        if (query == null) query = "";
	       
	        List<Pesticide> pesticideList = new ArrayList<>();
	        try (Connection conn = DBConnection.getConnection()) {
	            String sql = "SELECT * FROM pesticides WHERE name LIKE ? OR type LIKE ?";
	            PreparedStatement ps = conn.prepareStatement(sql);
	            ps.setString(1, "%" + query + "%");
	            ps.setString(2, "%" + query + "%");
	            ResultSet rs = ps.executeQuery();
	            while (rs.next()) {
	                Pesticide pesticide = new Pesticide();
	                pesticide.setId(rs.getInt("id"));
	                pesticide.setName(rs.getString("name"));
	                pesticide.setType(rs.getString("type"));
	                pesticide.setPrice(rs.getString("price"));
	                pesticide.setDescription(rs.getString("desp"));
	                pesticide.setExpDate(rs.getString("expdate"));
	                
	                pesticide.setImagePath(rs.getString("img")); // Assuming img column holds image path
	                pesticideList.add(pesticide);
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        request.setAttribute("pesticideList", pesticideList);
	        request.getRequestDispatcher("listPesticides.jsp").forward(request, response);
}
}