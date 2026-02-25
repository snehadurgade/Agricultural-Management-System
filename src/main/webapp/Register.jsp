<!DOCTYPE html>
<html lang="en">
<head>
<script type="text/javascript">
   document.getElementById('myForm').addEventListener('submit', function(event) {
	    const nameInput = this.name.value;
	    const regex = /^[A-Za-z]+$/;

	    if (!regex.test(nameInput)) {
	        alert('Please enter only letters (A-Z, a-z).');
	        event.preventDefault(); // Prevent form submission
	    }
	});
   </script>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<title>Farmer Signup</title>
<style>
  body {
    font-family: Arial, sans-serif;
    background: #f2f2f2;
    margin: 0;
    padding: 0;
    
  }
  .login-page {
    max-width: 400px;
    margin: 40px auto 0;
    padding: 20px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  }
  .login-page p.centered-title {
    font-size: 22px;
    font-weight: bold;
    text-align: center;
    margin: 0 0 25px 0;
    color: #333;
  }
  form.login-form {
    display: flex;
    flex-direction: column;
  }
  label {
    margin-bottom: 6px;
    font-weight: 600;
    color: #555;
  }
  input {
    padding: 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 4px;
    font-size: 14px;
  }
  input:focus {
    border-color: #66afe9;
    outline: none;
    box-shadow: 0 0 5px #66afe9;
  }
  button {
    padding: 12px;
    background-color: #28a745;
    border: none;
    color: white;
    font-weight: bold;
    font-size: 16px;
    border-radius: 4px;
    cursor: pointer;
    
  }
  button:hover {
    background-color: #218838;
  }
  p.message {
    margin-top: 20px;
    font-size: 14px;
    text-align: center;
  }
  p.message a {
    color: #007bff;
    text-decoration: none;
  }
  p.message a:hover {
    text-decoration: underline;
  }
  .firstsession  {
   		 background-image: url('farm1.jpg');
	  background-size: 2070px 700px;
   }
</style>
</head>
<body>
<div class="firstsession">
   <div>
   <jsp:include page="header.jsp" />
   </div>

<body>
  <div class="login-page">
    <p class="centered-title">FARMER SIGNUP</p>
    <div class="form">
      <form class="login-form" id="myForm" action="RegisterServlet" method="post"> 
        <label for="name">Name</label>
        <input type="text" placeholder="Name" name="name" id="name" required />

        <label for="uname">Username</label>
        <input type="text" placeholder="Username" name="uname" id="uname" required />

        <label for="password">Password</label>
        <input type="password" placeholder="Password" minlength="6" name="password" id="password" required />

        <label for="email">Email</label>
        <input type="email" placeholder="Email" name="email" id="email" required />

        <label for="mobile">Mobile No</label>
        <input type="text" placeholder="Mobile No" name="mobile" id="mobile" maxlength="10" pattern="[0-9]{10}" title="Enter 10 digit number" required />
		
		<label for="address">Address</label>
		<input type="text" placeholder="Address" name="address" id="address" required />
        <button type="submit">Submit</button>
        <p class="message"><a href="Login.jsp">Back to Login</a></p>
        <% 
            // Display the message if it exists
            String message = (String) request.getAttribute("message");
            if (message != null) {
        %>
            <p style="color: red;"><%= message %></p>
        <%
            }
        %>
      </form> 
    </div>
  </div>
    <div>
<jsp:include page="footer.jsp" />
</div>
</body>
</html>