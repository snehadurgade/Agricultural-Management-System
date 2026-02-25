

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;


@WebServlet("/PestRetriveServlet")
public class PestRetriveServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
  
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String imageId = request.getParameter("id"); // Get the image ID from the request
        response.setContentType("image/jpeg"); // Set the content type to image


        try ( Connection connection = DBConnection.getConnection()) {
            String sql = "SELECT img FROM pesticides WHERE id = ?";
            PreparedStatement pstmt = connection.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(imageId));

            
            ResultSet rs = pstmt.executeQuery();


            if (rs.next()) {
                String imagePath = rs.getString("img"); // Get the image path
                File imageFile = new File(getServletContext().getRealPath("") + File.separator + imagePath);
                
                if (imageFile.exists()) {
                    // Set the content length
                    response.setContentLength((int) imageFile.length());
                    
                    // Write the image to the response
                    try (FileInputStream fis = new FileInputStream(imageFile);
                         OutputStream os = response.getOutputStream()) {
                        byte[] buffer = new byte[1024];
                        int bytesRead;
                        while ((bytesRead = fis.read(buffer)) != -1) {
                            os.write(buffer, 0, bytesRead);
                        }
                        os.flush();
                    }
                } else {
                    response.sendError(HttpServletResponse.SC_NOT_FOUND); // Image file not found
                }
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND); // Image not found in database
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // Handle errors
        }
    }

	

}
