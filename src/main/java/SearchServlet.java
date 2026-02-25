import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import farm.Crop;

@WebServlet("/SearchServlet")
public class SearchServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String query = request.getParameter("query");
        List<Crop> cropList = new ArrayList<>();

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM crops WHERE name LIKE ? OR season LIKE ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Crop crop = new Crop();
                crop.setId(rs.getInt("id"));
                crop.setName(rs.getString("name"));
                crop.setSeason(rs.getString("season"));
                crop.setStartMonth(rs.getString("start_month"));
                crop.setEndMonth(rs.getString("end_month"));
                crop.setDescription(rs.getString("desp"));
                crop.setImagePath(rs.getString("img"));
                cropList.add(crop);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("cropList", cropList);
        request.getRequestDispatcher("listCrops.jsp").forward(request, response);
    }
}