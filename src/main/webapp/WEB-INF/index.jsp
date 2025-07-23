<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Fitness Management</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', sans-serif;
            min-height: 100vh;
            background: linear-gradient(-45deg, #dbeafe, #e0f7fa, #fff3e0, #e1f5fe);
            background-size: 400% 400%;
            animation: backgroundMotion 15s ease infinite;
            color: #333;
        }

        @keyframes backgroundMotion {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        header {
            background: linear-gradient(90deg, #1C6CD5, #1E88E5);
            padding: 30px;
            text-align: center;
            color: white;
            box-shadow: 0 4px 10px rgba(0,0,0,0.2);
        }

        nav {
            background-color: #174a8b;
            display: flex;
            justify-content: center;
            gap: 20px;
            padding: 15px;
        }

        nav a {
            color: #fff;
            font-weight: bold;
            padding: 12px 20px;
            text-decoration: none;
            border-radius: 20px;
            transition: all 0.3s ease;
        }

        nav a:hover {
            background-color: #1e88e5;
            transform: scale(1.05);
        }

        section {
            display: none;
            justify-content: center;
            padding: 40px 20px;
            animation: fadeIn 1s ease-in;
        }

        section.active {
            display: flex;
            flex-direction: column; /* added so image and quote stack */
            align-items: center;    /* center contents */
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .content {
            background: white;
            padding: 35px;
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 600px;
        }

        h2 {
            color: #1c6cd5;
            margin-bottom: 20px;
            text-align: center;
        }

        p {
            line-height: 1.6;
        }

        form {
            display: flex;
            flex-direction: column;
        }

        form label {
            margin-top: 12px;
            font-weight: bold;
        }

        form input, form select {
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 8px;
            margin-top: 5px;
        }

        input[type="submit"] {
            background: linear-gradient(to right, #1C6CD5, #1E88E5);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 8px;
            margin-top: 20px;
            font-size: 16px;
            cursor: pointer;
            transition: transform 0.3s ease, background 0.3s;
        }

        input[type="submit"]:hover {
            background: #1558b0;
            transform: scale(1.05);
        }

        @media (max-width: 600px) {
            nav {
                flex-direction: column;
                align-items: center;
            }
            .content {
                padding: 20px;
            }
        }

        /* Image slider styles */
        .slider-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 400px;      /* Keep height to control vertical size */
            width: 90%;
            max-width: 800px;
            margin: auto;
            /* Removed background, border-radius, and box-shadow */
        }

        .slider-container img {
            max-width: 100%;
            max-height: 100%;
            object-fit: contain;
            border-radius: 0;   /* Remove rounded corners */
            display: block;     /* Remove any inline spacing below image */
        }

        /* Quote styling */
   .quote {
    margin-top: 20px;
    font-weight: bold;
    font-style: normal;
    background: linear-gradient(90deg, #1c6cd5, #1e88e5); /* blue gradient matching header/nav */
    -webkit-background-clip: text;
    -webkit-text-fill-color: transparent;
    font-size: 1.6rem;
    text-align: center;
    max-width: 800px;
    margin-left: auto;
    margin-right: auto;
    user-select: none;
    animation: fadePulse 3s ease-in-out infinite alternate;
}

@keyframes fadePulse {
    0% {
        opacity: 0.8;
        transform: scale(1);
        filter: drop-shadow(0 0 5px #1c6cd5);
    }
    50% {
        opacity: 1;
        transform: scale(1.05);
        filter: drop-shadow(0 0 10px #1e88e5);
    }
    100% {
        opacity: 0.8;
        transform: scale(1);
        filter: drop-shadow(0 0 5px #1c6cd5);
    }
}
    </style>
</head>
<body>

<header>
    <h1>Fitness Management</h1>
</header>

<nav>
    <a href="#" onclick="showContent('home')">Home</a>
    <a href="#" onclick="showContent('register')">Register</a>
    <a href="#" onclick="showContent('login')">Login</a>
    <a href="#" onclick="showContent('admin')">Admin</a>
</nav>

<section id="home" class="active">
    <div class="slider-container">
        <img id="animatedSlider" src="" alt="Fitness Image">
    </div>
    <div class="quote">
        “Health is a state of body. Wellness is a state of being.”
    </div>
</section>

<section id="register">
    <div class="content">
        <% 
            String msg = request.getParameter("msg");
            if(msg != null){
                if(msg.equalsIgnoreCase("success")){
                    out.println("<script>alert('Registration is successful.');</script>");
                } else {
                    out.println("<script>alert('Registration failed.');</script>");
                }
            }
        %>
        <h2>User Registration</h2>
        <form action="RegisterServlet" method="post">
            <label>Name:</label><input type="text" name="name" required>
            <label>Password:</label><input type="password" name="password" required>
            <label>Gender:</label>
            <select name="gender" required>
                <option value="">Select</option>
                <option value="male">Male</option>
                <option value="female">Female</option>
                <option value="other">Other</option>
            </select>
            <label>Age:</label><input type="number" name="age" min="18" max="100" required>
            <label>Height (cm):</label><input type="number" name="height" min="50" max="250" required>
            <label>Weight (kg):</label><input type="number" name="weight" min="30" max="300" required>
            <label>Address:</label><input type="text" name="address" required>
            <label>Email:</label><input type="email" name="email" required>
            <label>Mobile:</label><input type="tel" name="mobile" pattern="[0-9]{10}" required>
            <label>Fitness Goal:</label><input type="text" name="goal" required>
            <input type="submit" value="Register">
        </form>
    </div>
</section>

<section id="login">
    <div class="content">
        <% 
            String msgs = request.getParameter("msgs");
            if(msgs != null){
                if(msgs.equalsIgnoreCase("success")){
                    out.println("<script>alert('Login is successful.');</script>");
                } else {
                    out.println("<script>alert('Login failed.');</script>");
                }
            }
        %> 
        <h2>User Login</h2>
        <form action="LoginServlet" method="post">
            <label>Email:</label><input type="email" name="email" required>
            <label>Password:</label><input type="password" name="password" required>
            <input type="submit" value="Login">
        </form>
    </div>
</section>

<section id="admin">
    <div class="content">
        <h2>Admin Panel</h2>

        <!-- Admin Login Form -->
        <form action="AdminLoginServlet" method="post">
            <label>Admin ID:</label><input type="text" name="adminId" required>
            <label>Password:</label><input type="password" name="adminPass" required>
            <input type="submit" value="Login as Admin">
        </form>

        <!-- Change Password Button -->
<div style="text-align:center; margin-top:20px;">
    <form action="ChangePassword.jsp" method="get">
        <input type="submit" value="Change Password" style="padding: 10px 20px; background-color: #1C6CD5; color: white; border: none; border-radius: 6px; cursor: pointer;">
    </form>
</div>

       
    </div>
</section>
<script>
    function toggleChangePassword() {
        const form = document.getElementById("changePasswordForm");
        form.style.display = (form.style.display === "none") ? "block" : "none";
    }
</script>

<script>
    function showContent(id) {
        const sections = ['home', 'register', 'login', 'admin'];
        sections.forEach(sec => {
            document.getElementById(sec).classList.remove('active');
        });
        document.getElementById(id).classList.add('active');
    }

    const imageUrls = [
        "https://static.vecteezy.com/system/resources/previews/005/283/009/original/workout-at-gym-concept-in-flat-cartoon-design-man-doing-exercises-with-dumbbells-in-sports-club-doing-weightlifting-and-strength-training-at-gym-illustration-with-people-scene-background-vector.jpg",
        "https://img.freepik.com/premium-vector/yoga-girl-sitting-lotus-pose_621685-16.jpg",
        "https://images.creativemarket.com/0.1.0/ps/10805303/3640/2410/m1/fpnw/wm1/gym-sim1-.jpg?1629089766&s=42244573975d28ecd5bc1e111ba64eb5",
        "https://thumbs.dreamstime.com/b/healthy-food-poster-fruits-vegetables-background-vector-illustration-182084638.jpg",
        "https://media.giphy.com/media/13beCEg2qPMmIg/giphy.gif"
    ];

    let currentIndex = 0;

    function showNextImage() {
        const slider = document.getElementById("animatedSlider");
        slider.src = imageUrls[currentIndex];
        currentIndex = (currentIndex + 1) % imageUrls.length;
    }

    window.onload = function () {
        showContent('home'); // Default section
        showNextImage();     // Start image slider
        setInterval(showNextImage, 5000); // Change every 5s
    };
</script>

</body>
</html>
