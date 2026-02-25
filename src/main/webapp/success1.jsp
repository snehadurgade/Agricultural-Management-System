<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Feedback Submitted</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100">
    <div class="container mx-auto p-8 mt-20">
        <div class="bg-white p-8 rounded-lg shadow-md text-center">
            <h1 class="text-3xl font-bold text-green-500 mb-4">Thank You!</h1>
            <p class="text-gray-700 mb-6">Your feedback has been successfully submitted.</p>
            <a href="feedback.jsp" 
               class="bg-blue-500 text-white px-4 py-2 rounded-lg hover:bg-blue-600 transition duration-200">
                Submit Another Feedback
            </a>
        </div>
    </div>
</body>
</html>

