<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Patient Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .landing-banner {
            background: linear-gradient(135deg, #2c3e50, #3498db);
            color: white;
            padding: 80px 0;
            min-height: 100vh;
            display: flex;
            align-items: center;
        }
        .landing-title {
            font-size: 3.5rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
        }
        .landing-subtitle {
            font-size: 1.5rem;
            margin-bottom: 2rem;
            opacity: 0.9;
        }
        .btn-login {
            padding: 12px 30px;
            font-size: 1.1rem;
            border-radius: 30px;
            font-weight: 600;
            margin-right: 15px;
        }
        .feature-card {
            padding: 30px;
            border-radius: 15px;
            margin-bottom: 30px;
            background-color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.08);
            height: 100%;
            transition: all 0.3s ease;
        }
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.12);
        }
        .feature-icon {
            font-size: 2.5rem;
            margin-bottom: 20px;
            color: #3498db;
        }
        .features-section {
            padding: 80px 0;
            background-color: #f8f9fa;
        }
        .section-title {
            font-size: 2.5rem;
            font-weight: 600;
            margin-bottom: 50px;
            text-align: center;
            color: #2c3e50;
        }
        footer {
            background-color: #2c3e50;
            color: white;
            padding: 30px 0;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="landing-banner">
        <div class="container">
            <div class="row">
                <div class="col-lg-7">
                    <h1 class="landing-title">Patient Management System</h1>
                    <p class="landing-subtitle">A comprehensive solution for healthcare providers to manage patient records, appointments, and treatments efficiently and securely.</p>
                    <a href="login" class="btn btn-light btn-login">Log In</a>
                    <a href="register" class="btn btn-outline-light btn-login">Register</a>
                </div>
                <div class="col-lg-5">
                    <!-- Placeholder for a future image -->
                </div>
            </div>
        </div>
    </div>

    <section class="features-section">
        <div class="container">
            <h2 class="section-title">Key Features</h2>
            <div class="row">
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-user-md"></i>
                        </div>
                        <h3>Doctor Management</h3>
                        <p>Efficiently manage doctor profiles, specializations, and schedules. Track availability and performance metrics.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-procedures"></i>
                        </div>
                        <h3>Patient Records</h3>
                        <p>Maintain comprehensive patient information including medical history, treatment plans, and progress notes.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-calendar-check"></i>
                        </div>
                        <h3>Appointment Scheduling</h3>
                        <p>Streamline appointment booking, rescheduling, and cancellations with an intuitive calendar interface.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-pills"></i>
                        </div>
                        <h3>Medication Tracking</h3>
                        <p>Record and monitor prescribed medications, dosages, and refill schedules for each patient.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
                        <div class="feature-icon">
                            <i class="fas fa-chart-line"></i>
                        </div>
                        <h3>Analytics Dashboard</h3>
                        <p>Visualize healthcare data with comprehensive analytics to make informed decisions.</p>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="feature-card">
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
</body>
</html> 