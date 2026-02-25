

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;


import java.io.IOException;

import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.util.regex.Pattern;

@WebServlet("/FeedbackServlet")
public class FeedbackServlet extends HttpServlet {
		

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String feedback = request.getParameter("feedback");
        String error = null;
        Connection connection = null;
        PreparedStatement statement = null;
        
        try {
            connection = DBConnection.getConnection();
           
           
            String sql = "INSERT INTO feedback (name,email,feedback) VALUES (?, ?, ?)";
            statement = connection.prepareStatement(sql);
            statement.setString(1, name);
            statement.setString(2, email);
            statement.setString(3, feedback);
            
            int row = statement.executeUpdate();
            response.setContentType("text/html");
            PrintWriter out = response.getWriter();
            if (row > 0) {
                out.println("Feedback Completed!");
            } else {
                out.println("");
            }
        }catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "An error occurred while processing your request.");
        }finally {
            try {
                if (statement != null) statement.close();
                if (connection != null) connection.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        // Validation
        if (name == null || name.trim().isEmpty()) {
            error = "Name is required.";
        } else if (email == null || !isValidEmail(email)) {
            error = "Invalid email format.";
        } else if (feedback == null || feedback.trim().isEmpty()) {
            error = "Feedback cannot be empty.";
        }

        if (error != null) {
            request.setAttribute("error", error);
            
            return;
        }

        // Save to file
//        try (PrintWriter out = new PrintWriter(new FileWriter(getServletContext().getRealPath(FEEDBACK_FILE), true))) {
//            out.println("Name: " + name);
//            out.println("Email: " + email);
//            out.println("Feedback: " + feedback);
//            out.println("------------------------------");
//        }

        // Redirect to success page
        response.sendRedirect("success1.jsp");
    }

    private boolean isValidEmail(String email) {
        String regex = "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$";
        return Pattern.compile(regex).matcher(email).matches();
    }
}