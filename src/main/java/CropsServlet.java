

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;



import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.Paths;
import java.sql.*;
import java.util.*;

import farm.Crop;


@WebServlet(urlPatterns = {"/addCrop", "/listCrops", "/editCrop", "/deleteCrop"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class CropsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET method
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/addCrop":
                showAddForm(request, response);
                break;
            case "/listCrops":
                listCrops(request, response);
                break;
            case "/editCrop":
                showEditForm(request, response);
                break;
            case "/deleteCrop":
                deleteCrop(request, response);
                break;
            default:
                response.sendRedirect("listCrops");
                break;
        }
    }

    // POST method
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/addCrop":
                addCrop(request, response);
                break;
            case "/editCrop":
                updateCrop(request, response);
                break;
            default:
                response.sendRedirect("listCrops");
                break;
        }
    }

    // Show form to add crop
    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("addCrop.jsp").forward(request, response);
    }

    // Insert crop
    private void addCrop(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String season = request.getParameter("season");
        String startMonth = request.getParameter("startMonth");
        String endMonth = request.getParameter("endMonth");
        String description = request.getParameter("desp");

        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);
        String imagePath = "images/" + fileName;

        try (Connection conn =DBConnection.getConnection()) {
            String sql = "INSERT INTO crops (name, season, start_month, end_month, desp, img) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, season);
            ps.setString(3, startMonth);
            ps.setString(4, endMonth);
            ps.setString(5, description);
            ps.setString(6, imagePath);
            ps.executeUpdate();
           

            
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("listCrops");
    }

    // List all crops
    private void listCrops(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	  List<Crop> cropList = new ArrayList<>();
          String season = request.getParameter("season"); // Get the season parameter

          try (Connection conn = DBConnection.getConnection()) {
              String sql = "SELECT * FROM crops";
              if (season != null && !season.isEmpty()) {
                  sql += " WHERE season = ?";
              }
              PreparedStatement stmt = conn.prepareStatement(sql);
              if (season != null && !season.isEmpty()) {
                  stmt.setString(1, season);
              }
              ResultSet rs = stmt.executeQuery();
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

      // Select crops based on the season
      private void selectSeason(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
          String selectedSeason = request.getParameter("season");
          listCrops(request, response); // Call listCrops to display crops based on the selected season
      }

    

    // Show form to edit crop
    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Crop crop = null;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM crops WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                crop = new Crop();
                crop.setId(rs.getInt("id"));
                crop.setName(rs.getString("name"));
                crop.setSeason(rs.getString("season"));
                crop.setStartMonth(rs.getString("start_month"));
                crop.setEndMonth(rs.getString("end_month"));
                crop.setDescription(rs.getString("desp"));
                crop.setImagePath(rs.getString("img"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("crop", crop);
        request.getRequestDispatcher("editCrop.jsp").forward(request, response);
    }

    // Update crop
    private void updateCrop(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String season = request.getParameter("season");
        String startMonth = request.getParameter("startMonth");
        String endMonth = request.getParameter("endMonth");
        String description = request.getParameter("desp");

        String imagePath = request.getParameter("currentImage"); // default to old image
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
            filePart.write(uploadPath + File.separator + fileName);
            imagePath = "images/" + fileName;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE crops SET name=?, season=?, start_month=?, end_month=?, desp=?, img=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, season);
            ps.setString(3, startMonth);
            ps.setString(4, endMonth);
            ps.setString(5, description);
            ps.setString(6, imagePath);
            ps.setInt(7, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("listCrops");
    }

    // Delete crop
    private void deleteCrop(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM crops WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("listCrops");
    }
}
