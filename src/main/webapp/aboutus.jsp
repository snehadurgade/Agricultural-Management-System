<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>About Us - Agriculture Management System</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      background: #88f388;
      color: #2f4f4f;
      line-height: 1.6;
    }
    .container {
       
      max-width: 720px;
      margin: 40px auto;
      background: #88f388;
      padding: 30px 25px;
      border-radius: 10px;
      box-shadow: 0 6px 15px rgba(47, 79, 79, 0.1);
    }
    h1, h2 {
      color: #2e7d32;
      margin-bottom: 20px;
      font-weight: 700;
    }
    h1 {
      font-size: 2.4rem;
      text-align: center;
      margin-bottom: 40px;
    }
    h2 {
      font-size: 1.6rem;
      border-bottom: 2px solid #c8e6c9;
      padding-bottom: 8px;
    }
    p {
      margin-bottom: 20px;
      font-size: 1.1rem;
    }
    ul {
      margin-left: 20px;
      margin-bottom: 20px;
    }
    li {
      font-size: 1.05rem;
      margin-bottom: 10px;
    }
    .contact-info p {
      margin: 6px 0;
      font-size: 1.1rem;
    }
    img {
      display: block;
      max-width: 140px;
      margin: 0 auto 35px auto;
    }
    footer {
      text-align: center;
      margin-top: 40px;
      color: #99a3a4;
      font-size: 0.9rem;
    }
    @media (max-width: 600px) {
      .container {
        margin: 20px;
        padding: 20px 15px;
      }
      h1 {
        font-size: 2rem;
      }
      h2 {
        font-size: 1.3rem;
      }
      p, li, .contact-info p {
        font-size: 1rem;
      }
      img {
        max-width: 110px;
      }
    }
  </style>
</head>
<body>
<div>
<jsp:include page="header1.jsp" />
</div>
  <main class="container" role="main" aria-label="About Us Page">
    <h1>About Us</h1>
    <img src="https://img.icons8.com/external-flatart-icons-outline-flatarticons/64/2e7d32/farmer.png" alt="Team Icon" />
    
    <section aria-labelledby="system-title">
      <h2 id="system-title">About Our System</h2>
      <p>
        Our Agriculture Management System is designed to support farmers and agricultural professionals in managing their daily farming activities efficiently. The system integrates crop monitoring, equipment management, pest control, weather tracking, and market information in an easy-to-use platform.
      </p>
      <p>
        By leveraging data-driven insights and automation, it helps improve productivity, reduce waste, and promote sustainable farming practices tailored to your unique land and crops.
      </p>
    </section>
    
    <section aria-labelledby="mission-title">
      <h2 id="mission-title">Our Mission</h2>
      <p>
        Our mission is to empower the agricultural community through innovative technology solutions that simplify farm management and drive sustainable growth. We commit to continuous development, listening closely to farmer needs, and delivering reliable tools to boost yields and optimize resource use.
      </p>
    </section>
    
    <section aria-labelledby="contact-title">
      <h2 id="contact-title">Contact Us</h2>
      <div class="contact-info">
        <p><strong>Email:</strong> support@agriculturems.com</p>
        <p><strong>Phone:</strong> 9967555256</p>
        
      </div>
    </section>
    
    <footer>
      &copy; 2024 Agriculture Management System. All rights reserved.
    </footer>
  </main>
</body>
</html>