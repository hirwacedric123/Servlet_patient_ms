<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #1abc9c;
            --light-color: #f8f9fa;
            --dark-color: #222;
        }
        
        body {
            overflow-x: hidden;
        }
        
        .landing-banner {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 100px 0 80px;
            min-height: 100vh;
            display: flex;
            align-items: center;
            position: relative;
        }
        
        .landing-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,100 C20,0 50,0 100,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
            background-size: 100% 100%;
        }
        
        .landing-title {
            font-size: 3.8rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            background: linear-gradient(90deg, #ffffff, #f0f0f0);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            text-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .landing-subtitle {
            font-size: 1.5rem;
            margin-bottom: 2.5rem;
            opacity: 0.9;
            line-height: 1.6;
        }
        
        .btn-login {
            padding: 14px 34px;
            font-size: 1.1rem;
            border-radius: 50px;
            font-weight: 600;
            margin-right: 15px;
            letter-spacing: 0.5px;
            position: relative;
            overflow: hidden;
            z-index: 1;
            transition: all 0.4s ease;
            box-shadow: 0 6px 15px rgba(0,0,0,0.15);
        }
        
        .btn-login:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.2);
        }
        
        .btn-login:active {
            transform: translateY(-1px);
            box-shadow: 0 5px 10px rgba(0,0,0,0.2);
        }
        
        .feature-card {
            padding: 40px 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            background-color: white;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.05);
            height: 100%;
            transition: all 0.4s ease;
            border-bottom: 5px solid transparent;
        }
        
        .feature-card:hover {
            transform: translateY(-15px);
            box-shadow: 0 15px 40px rgba(0, 0, 0, 0.1);
            border-bottom: 5px solid var(--secondary-color);
        }
        
        .feature-icon {
            font-size: 3rem;
            margin-bottom: 25px;
            color: var(--secondary-color);
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .features-section {
            padding: 100px 0;
            background-color: var(--light-color);
            position: relative;
            z-index: 1;
        }
        
        .features-section::before {
            content: '';
            position: absolute;
            top: -100px;
            left: 0;
            width: 100%;
            height: 100px;
            background: var(--light-color);
            clip-path: polygon(0 0, 100% 100%, 100% 100%, 0% 100%);
            z-index: 0;
        }
        
        .section-title {
            font-size: 2.8rem;
            font-weight: 700;
            margin-bottom: 70px;
            text-align: center;
            color: var(--primary-color);
            position: relative;
            padding-bottom: 20px;
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 50%;
            transform: translateX(-50%);
            width: 80px;
            height: 4px;
            background: linear-gradient(90deg, var(--secondary-color), var(--accent-color));
            border-radius: 2px;
        }
        
        footer {
            background-color: var(--primary-color);
            color: white;
            padding: 40px 0;
            text-align: center;
        }
        
        .navbar {
            background-color: transparent !important;
            padding: 25px 0;
            transition: all 0.4s ease;
            position: absolute;
            width: 100%;
            z-index: 1000;
        }
        
        .navbar.scrolled {
            background-color: rgba(44, 62, 80, 0.95) !important;
            padding: 15px 0;
            position: fixed;
            top: 0;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .navbar-brand {
            font-weight: 800;
            font-size: 1.8rem;
            color: white !important;
            letter-spacing: 1px;
        }
        
        .navbar-brand span {
            color: var(--accent-color);
        }
        
        .navbar-nav .nav-link {
            color: rgba(255, 255, 255, 0.9) !important;
            margin: 0 12px;
            font-weight: 600;
            transition: all 0.3s ease;
            position: relative;
            padding: 8px 0;
        }
        
        .navbar-nav .nav-link::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 0;
            height: 2px;
            background-color: white;
            transition: width 0.3s ease;
        }
        
        .navbar-nav .nav-link:hover::after {
            width: 100%;
        }
        
        .navbar-nav .nav-link:hover {
            color: white !important;
            transform: translateY(-2px);
        }
        
        .navbar-nav .btn {
            margin-left: 15px;
            border-radius: 30px;
            padding: 10px 24px;
            font-weight: 600;
            background-color: var(--accent-color);
            border-color: var(--accent-color);
            transition: all 0.3s ease;
        }
        
        .navbar-nav .btn:hover {
            background-color: white;
            border-color: white;
            color: var(--primary-color) !important;
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(0,0,0,0.1);
        }
        
        .hero-image {
            max-width: 100%;
            border-radius: 20px;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.2);
            transform: perspective(1000px) rotateY(-5deg);
            transition: all 0.6s ease;
            animation: float 6s ease-in-out infinite;
        }
        
        .hero-image:hover {
            transform: perspective(1000px) rotateY(5deg);
        }
        
        .image-container {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100%;
            position: relative;
            z-index: 1;
        }
        
        @keyframes float {
            0% {
                transform: translateY(0px) perspective(1000px) rotateY(-5deg);
            }
            50% {
                transform: translateY(-20px) perspective(1000px) rotateY(5deg);
            }
            100% {
                transform: translateY(0px) perspective(1000px) rotateY(-5deg);
            }
        }
        
        .typing-container {
            height: 30px;
            position: relative;
        }
        
        .typing-text {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            overflow: hidden;
            white-space: nowrap;
            animation: typing 4s steps(40, end) forwards;
        }
        
        @keyframes typing {
            from { width: 0 }
            to { width: 100% }
        }
        
        .animate-on-scroll {
            opacity: 0;
            transform: translateY(30px);
            transition: all 0.8s ease;
        }
        
        .animated {
            opacity: 1;
            transform: translateY(0);
        }
        
        .delay-1 {
            transition-delay: 0.1s;
        }
        
        .delay-2 {
            transition-delay: 0.2s;
        }
        
        .delay-3 {
            transition-delay: 0.3s;
        }
        
        .delay-4 {
            transition-delay: 0.4s;
        }
        
        .delay-5 {
            transition-delay: 0.5s;
        }
        
        .pulse {
            animation: pulse 2s infinite;
        }
        
        @keyframes pulse {
            0% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
            100% {
                transform: scale(1);
            }
        }
    </style>
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container">
            <a class="navbar-brand" href="#">PMS<span>.</span></a>
            <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item active">
                        <a class="nav-link" href="#">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#features">Features</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link btn btn-light text-primary" href="login">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="landing-banner">
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <h1 class="landing-title animate__animated animate__fadeInUp">Patient Management System</h1>
                    <div class="typing-container">
                        <p class="typing-text animate__animated animate__fadeIn animate__delay-1s">Healthcare made simple.</p>
                    </div>
                    <p class="landing-subtitle animate__animated animate__fadeInUp animate__delay-2s">A comprehensive solution for healthcare providers to manage patient records, appointments, and treatments efficiently and securely.</p>
                    <a href="login" class="btn btn-light btn-login animate__animated animate__fadeInUp animate__delay-3s pulse">Log In Now</a>
                </div>
                <div class="col-lg-6">
                    <div class="image-container animate__animated animate__zoomIn animate__delay-1s">
                        <img src="images/patients.png" alt="Healthcare Dashboard" class="hero-image">
                    </div>
                </div>
            </div>
        </div>
    </div>

    <section class="features-section" id="features">
        <div class="container">
            <h2 class="section-title animate-on-scroll">Key Features</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="feature-card animate-on-scroll delay-1">
                        <div class="feature-icon">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <h3>Doctor Management</h3>
                        <p>Efficiently manage doctor profiles, specializations, and schedules. Track availability and performance metrics.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card animate-on-scroll delay-2">
                        <div class="feature-icon">
                            <i class="fas fa-procedures"></i>
                        </div>
                        <h3>Patient Records</h3>
                        <p>Maintain comprehensive patient information including medical history, treatment plans, and progress notes.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card animate-on-scroll delay-3">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h3>Appointment Scheduling</h3>
                        <p>Streamline appointment booking, rescheduling, and cancellations with an intuitive calendar interface.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card animate-on-scroll delay-1">
                        <div class="feature-icon">
                            <i class="fas fa-pills"></i>
                        </div>
                        <h3>Medication Tracking</h3>
                        <p>Record and monitor prescribed medications, dosages, and refill schedules for each patient.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card animate-on-scroll delay-2">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h3>Analytics Dashboard</h3>
                        <p>Visualize healthcare data with comprehensive analytics to make informed decisions.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card animate-on-scroll delay-3">
                        <div class="feature-icon">
                            <i class="fas fa-lock"></i>
                        </div>
                        <h3>Secure Access</h3>
                        <p>Role-based access control ensures that sensitive patient information is only accessible to authorized personnel.</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <footer>
        <div class="container">
            <p>&copy; 2023 Patient Management System. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Smooth scrolling for anchor links
        document.querySelectorAll('a[href^="#"]').forEach(anchor => {
            anchor.addEventListener('click', function (e) {
                e.preventDefault();
                document.querySelector(this.getAttribute('href')).scrollIntoView({
                    behavior: 'smooth'
                });
            });
        });
        
        // Navbar scroll effect
        window.addEventListener('scroll', function() {
            const navbar = document.querySelector('.navbar');
            if (window.scrollY > 50) {
                navbar.classList.add('scrolled');
            } else {
                navbar.classList.remove('scrolled');
            }
        });
        
        // Animate on scroll
        function animateOnScroll() {
            const elements = document.querySelectorAll('.animate-on-scroll');
            elements.forEach(element => {
                const elementPosition = element.getBoundingClientRect().top;
                const windowHeight = window.innerHeight;
                if (elementPosition < windowHeight - 50) {
                    element.classList.add('animated');
                }
            });
        }
        
        // Initial check for elements in view
        window.addEventListener('load', animateOnScroll);
        // Check for elements on scroll
        window.addEventListener('scroll', animateOnScroll);
    </script>
</body>
</html> 