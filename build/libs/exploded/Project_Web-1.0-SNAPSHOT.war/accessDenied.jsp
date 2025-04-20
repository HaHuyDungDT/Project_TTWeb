<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Access Denied</title>
  <!-- Sử dụng Google Fonts -->
  <link href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;700&display=swap" rel="stylesheet">
  <style>
    :root {
      --primary-color: #3498db;
      --secondary-color: #8e44ad;
      --accent-color: #e74c3c;
      --bg-light: #fdfdfd;
    }
    * {
      box-sizing: border-box;
    }
    body {
      margin: 0;
      padding: 0;
      font-family: 'Roboto', sans-serif;
      background: linear-gradient(135deg, var(--secondary-color), var(--primary-color));
      display: flex;
      align-items: center;
      justify-content: center;
      min-height: 100vh;
      color: #444;
    }
    .container {
      background: var(--bg-light);
      border-radius: 12px;
      padding: 50px 40px;
      max-width: 500px;
      width: 90%;
      text-align: center;
      box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
      position: relative;
      overflow: hidden;
      animation: slideDown 0.8s ease-out;
    }
    /* Overlay animation */
    .container::before {
      content: "";
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: radial-gradient(circle at center, rgba(255,255,255,0.15), transparent 60%);
      transform: rotate(25deg);
      animation: pulse 4s infinite ease-in-out;
    }
    @keyframes slideDown {
      from { opacity: 0; transform: translateY(-30px); }
      to { opacity: 1; transform: translateY(0); }
    }
    @keyframes pulse {
      0%, 100% { opacity: 0.4; }
      50% { opacity: 0.15; }
    }
    h1 {
      font-size: 2.5em;
      margin-bottom: 20px;
      color: var(--accent-color);
      z-index: 1;
      position: relative;
    }
    p {
      font-size: 1.1em;
      margin: 15px 0;
      line-height: 1.6;
      z-index: 1;
      position: relative;
    }
    a {
      display: inline-block;
      margin-top: 25px;
      padding: 12px 30px;
      background: var(--primary-color);
      color: #fff;
      border-radius: 30px;
      text-decoration: none;
      font-weight: 700;
      transition: background 0.3s ease, transform 0.3s ease;
      z-index: 1;
      position: relative;
    }
    a:hover {
      background: #2980b9;
      transform: translateY(-3px);
    }
    /* Responsive */
    @media (max-width: 500px) {
      .container {
        padding: 30px 20px;
      }
      h1 {
        font-size: 2em;
      }
      p {
        font-size: 1em;
      }
    }
  </style>
</head>
<body>
<div class="container">
  <h1>Access Denied</h1>
  <p>Bạn không thể đăng nhập bằng Facebook thành công.</p>
  <p>Vui lòng thử lại hoặc sử dụng phương thức đăng nhập khác.</p>
  <a href="dangnhap.jsp">Quay về trang đăng nhập</a>
</div>
</body>
</html>