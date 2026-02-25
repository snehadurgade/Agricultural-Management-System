

import jakarta.servlet.ServletException;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import farm.Pesticide;

import java.io.IOException;


import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.*;

import java.io.*;
import java.nio.file.Paths;
import java.sql.*;
import java.util.*;

@WebServlet(urlPatterns = {"/addPesticide", "/listPesticides", "/editPesticide", "/deletePesticide"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 10, maxRequestSize = 1024 * 1024 * 50)
public class PesticidesServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/addPesticide":
                showAddForm(request, response);
                break;
            case "/listPesticides":
                listPesticides(request, response);
                break;
            case "/editPesticide":
                showEditForm(request, response);
                break;
            case "/deletePesticide":
                deletePesticide(request, response);
                break;
            default:
                response.sendRedirect("listPesticides");
                break;
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getServletPath();

        switch (action) {
            case "/addPesticide":
                addPesticide(request, response);
                break;
            case "/editPesticide":
                updatePesticide(request, response);
                break;
            default:
                response.sendRedirect("listPesticides");
                break;
        }
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.getRequestDispatcher("addPesticide.jsp").forward(request, response);
    }

    private void addPesticide(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String expDate = request.getParameter("expDate");
        String price = request.getParameter("price");
        String description = request.getParameter("desp");

        Part filePart = request.getPart("image");
        String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
        String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdir();

        filePart.write(uploadPath + File.separator + fileName);
        String imagePath = "images/" + fileName;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO pesticides (name, type, expdate, price, desp, img) VALUES (?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, type);
            ps.setString(3, expDate);
            ps.setString(4, price);
            ps.setString(5, description);
            ps.setString(6, imagePath);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("listPesticides");
    }

    private void listPesticides(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<Pesticide> pesticideList = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM pesticides";
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                Pesticide p = new Pesticide();
                p.setId(rs.getInt("id"));
                p.setName(rs.getString("name"));
                p.setType(rs.getString("type"));
                p.setExpDate(rs.getString("expdate"));
                p.setPrice(rs.getString("price"));
                p.setDescription(rs.getString("desp"));
                p.setImagePath(rs.getString("img"));
                pesticideList.add(p);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        request.setAttribute("pesticideList", pesticideList);
        request.getRequestDispatcher("listPesticides.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Pesticide pesticide = null;

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM pesticides WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                pesticide = new Pesticide();
                pesticide.setId(rs.getInt("id"));
                pesticide.setName(rs.getString("name"));
                pesticide.setType(rs.getString("type"));
                pesticide.setExpDate(rs.getString("expdate"));
                pesticide.setPrice(rs.getString("price"));
                pesticide.setDescription(rs.getString("desp"));
                pesticide.setImagePath(rs.getString("img"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        request.setAttribute("pesticide", pesticide);
        request.getRequestDispatcher("editPesticide.jsp").forward(request, response);
    }

    private void updatePesticide(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String type = request.getParameter("type");
        String expDate = request.getParameter("expDate");
        String price = request.getParameter("price");
        String description = request.getParameter("desp");

        String imagePath = request.getParameter("currentImage");
        Part filePart = request.getPart("image");
        if (filePart != null && filePart.getSize() > 0) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String uploadPath = getServletContext().getRealPath("") + File.separator + "images";
            filePart.write(uploadPath + File.separator + fileName);
            imagePath = "images/" + fileName;
        }

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE pesticides SET name=?, type=?, expdate=?, price=?, desp=?, img=? WHERE id=?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, name);
            ps.setString(2, type);
            ps.setString(3, expDate);
            ps.setString(4, price);
            ps.setString(5, description);
            ps.setString(6, imagePath);
            ps.setInt(7, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("listPesticides");
    }

    private void deletePesticide(HttpServletRequest request, HttpServletResponse response) throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM pesticides WHERE id = ?";
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        response.sendRedirect("listPesticides");
    }
}
