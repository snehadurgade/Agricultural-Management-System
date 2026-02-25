<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback Form</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-SgOJa3DmI69IUzQ2PVdRZhwQ+dy64/BUtbMJw1MZ8t5HZApcHrRKUc4W0kG879m7" crossorigin="anonymous">
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
	<nav class="navbar navbar-expand-lg bg-body-tertiary">
	  <div class="container-fluid">
	    <a class="navbar-brand" href="Home.html">Home</a>
	    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent">
	      <span class="navbar-toggler-icon"></span>
	    </button>
	    <div class="collapse navbar-collapse" id="navbarSupportedContent">
	      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
	        <li class="nav-item">
	          <a class="nav-link active" href="Home.html">Home</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="Pesticides.jsp">Pesticides</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="feedback.jsp">Feedback</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link" href="about.html">About us</a>
	        </li>
	        <li class="nav-item">
	          <a class="nav-link disabled" aria-disabled="true">Disabled</a>
	        </li>
	      </ul>
	      <form class="d-flex" role="search">
	        <input class="form-control me-2" type="search" placeholder="Search">
	        <button class="btn btn-outline-success" type="submit">Search</button>
	      </form>
	    </div>
	  </div>
	</nav>

    <!-- Centered Form Container -->
    <div class="min-h-screen flex items-center justify-center" style="background-color:#88f388;">
        <div class="w-full max-w-md bg-white p-8 rounded-lg shadow-md">
            <h1 class="text-3xl font-bold text-center mb-6">Feedback Form</h1>

            <form action="FeedbackServlet" method="post">
                <div class="mb-4">
                    <label for="name" class="block text-gray-700 font-bold mb-2">Name</label>
                    <input type="text" id="name" name="name"
                           class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500"
                           required>
                </div>

                <div class="mb-4">
                    <label for="email" class="block text-gray-700 font-bold mb-2">Email</label>
                    <input type="email" id="email" name="email"
                           class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500"
                           required>
                </div>

                <div class="mb-4">
                    <label for="feedback" class="block text-gray-700 font-bold mb-2">Feedback</label>
                    <textarea id="feedback" name="feedback" rows="4"
                              class="w-full px-3 py-2 border rounded-lg focus:outline-none focus:border-blue-500"
                              required></textarea>
                </div>

                <div class="mb-4">
                    <% String error = (String) request.getAttribute("error"); %>
                    <% if (error != null) { %>
                        <p class="text-red-500 text-sm italic"><%= error %></p>
                    <% } %>
                </div>

                <button type="submit"
                        class="w-full bg-blue-500 text-white py-2 px-4 rounded-lg hover:bg-blue-600 transition duration-200">
                    Submit Feedback
                </button>
            </form>
        </div>
    </div>

    <div>
        <jsp:include page="footer.jsp" />
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.5/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
</body>
</html>