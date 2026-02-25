<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Shipping Address</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color:#88f388;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .form-container {
            background: white;
            padding: 30px 30px;
            max-width: 400px;
            width: 100%;
            border-radius: 10px;
            box-shadow: 0 6px 15px rgba(0,0,0,0.1);
        }
        h2 {
            color: #2a83f1;
            text-align: center;
            margin-bottom: 24px;
        }
        form {
            display: flex;
            flex-direction: column;
        }
        label {
            font-weight: 600;
            margin-bottom: 6px;
            margin-top: 14px;
            color: #333;
        }
        input[type=text] {
            padding: 10px 14px;
            font-size: 1rem;
            border: 2px solid #ccc;
            border-radius: 6px;
            transition: border-color 0.3s ease;
        }
        input[type=text]:focus {
            border-color: #2a83f1;
            outline: none;
        }
        button {
            margin-top: 28px;
            background-color: #2a83f1;
            color: white;
            font-weight: 700;
            font-size: 1.1rem;
            border: none;
            padding: 12px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }
        button:hover,
        button:focus {
            background-color: #1060d8;
            outline: none;
        }
          .btn-cancel {
            display: block;
            width: 100px;
            margin: 20px auto;
            text-align: center;
            padding: 10px;
            background-color: #007BFF; /* Blue */
            text-decoration: none;
            color: white;
            border-radius: 5px;
        }
        @media (max-width: 480px) {
            .form-container {
              margin: 15px;
              padding: 20px;
            }
        }
    </style>
</head>
<body>
		<% String id = request.getParameter("id");%>
    <div class="form-container" role="main" aria-labelledby="shipping-heading">
        <h2 id="shipping-heading">Enter Address</h2>
        <form action="AddressServlet" method="post" novalidate>
			<input type="hidden" name="id" value="<%= id %>" />             

            <label for="address_line">Address Line</label>
            <input type="text" name="address_line" id="address_line" placeholder="123 Main St, Apt 4B" required />

            <label for="city">City</label>
            <input type="text" name="city" id="city" placeholder="City" required />

            <label for="state">State</label>
            <input type="text" name="state" id="state" placeholder="State" required />

            <label for="zip">Pin Code</label>
            <input type="text" name="zip" id="zip" placeholder="Zip Code" required  title="Please enter a valid zip code" />

            <label for="country">Country</label>
            <input type="text" name="country" id="country" placeholder="Country" required />

            <button type="submit">Place Order</button>
             <a href="Pesticides.jsp" class="btn-cancel">Cancel</a>
        </form>
    </div>
</body>
</html>