<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
   <%
    String adminName = (String) session.getAttribute("adminName");
    if (adminName == null) {
        adminName = "Admin"; // fallback or guest name if missing
    }
%>
<!DOCTYPE html>
<html>
<head>
	 <link rel="stylesheet" href="style.css">
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="${pageContext.request.contextPath}/assets/css/style.css" rel="stylesheet">
</head>
<body>
    <div class="d-flex" id="wrapper">
        <!-- Sidebar -->
        <div class="bg-dark border-right" id="sidebar-wrapper">
            <div class="sidebar-heading text-white p-3">Dashboard</div>
            <div class="list-group list-group-flush">
            <a href="Home.html" class="list-group-item list-group-item-action bg-dark text-white">
                    <i class="fas fa-users me-2"></i>Home
                </a>
                <a href="listCrops"
                 class="list-group-item list-group-item-action bg-dark text-white active">
                    <i class="fas fa-tachometer-alt me-2"></i>Crop Page
                </a>
                <a href="listPesticides" class="list-group-item list-group-item-action bg-dark text-white">
                    <i class="fas fa-users me-2"></i>Pesticide Page
                </a>
                <a href="#" class="list-group-item list-group-item-action bg-dark text-white">
                    <i class="fas fa-project-diagram me-2"></i>About us
                </a>
                  <a href="feedbackshow.jsp" class="list-group-item list-group-item-action bg-dark text-white">
                    <i class="fas fa-project-diagram me-2"></i>Feedback
                </a>
            </div>
        </div>

        <!-- Page Content -->
        <div id="page-content-wrapper">
            <!-- Top Navigation -->
            <nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
                <div class="container-fluid">
                    <button class="btn btn-primary" id="menu-toggle">
                        <i class="fas fa-bars"></i>
                    </button>
                    <div class="dropdown ms-auto">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-circle me-1"></i><%= adminName %>
                        </a>
                        <ul class="dropdown-menu">
                            <li><a class="dropdown-item" href="AdminLogin.jsp">Profile </a></li>
                           
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="Home.html">Logout</a></li>
                        </ul>
                    </div>
                </div>
            </nav>

            <!-- Main Content -->
            <div class="container-fluid px-4">
                <div class="row g-3 my-2">
                    <div class="col-md-4">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div>
                                <h3 class="fs-2">${userCount}</h3>
                                <p class="fs-5">Users</p>
                            </div>
                            <i class="fas fa-users fs-1 text-primary"></i>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div>
                                <h3 class="fs-2">${activeProjects}</h3>
                                <p class="fs-5">Projects</p>
                            </div>
                            <i class="fas fa-project-diagram fs-1 text-success"></i>
                        </div>
                    </div>
                       <div class="col-md-4">
                        <div class="p-3 bg-white shadow-sm d-flex justify-content-around align-items-center rounded">
                            <div>
                                <h3 class="fs-2">${activeProjects}</h3>
                                <p class="fs-5">Projects</p>
                            </div>
                            <i class="fas fa-project-diagram fs-1 text-success"></i>
                        </div>
                    </div>
                </div>

                <!-- Recent Activities -->
                <div class="row my-4">
                    <div class="col-lg-6">
                        <div class="card mb-4">
                            <div class="card-header">
                                <h5>Recent Activities</h5>
                            </div>
                            <div class="card-body">
                                <ul class="list-group list-group-flush">
                                    <c:forEach items="${recentActivities}" var="activity">
                                        <li class="list-group-item">${activity}</li>
                                    </c:forEach>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- JavaScript Libraries -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
        <script>
            document.getElementById('menu-toggle').addEventListener('click', function() {
                document.getElementById('wrapper').classList.toggle('toggled');
            });
        </script>
    </div>
</body>
</html>