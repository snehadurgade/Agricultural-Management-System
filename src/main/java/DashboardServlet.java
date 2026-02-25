
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Set sample data for dashboard
        request.setAttribute("pageTitle", "Dashboard Overview");
        request.setAttribute("userCount", 42);
        request.setAttribute("activeProjects", 7);
        request.setAttribute("recentActivities", new String[]{
            "New user registered",
            "Project X updated",
            "System maintenance scheduled"
        });
        
        // Forward to dashboard view
        request.getRequestDispatcher("/WEB-INF/views/dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}