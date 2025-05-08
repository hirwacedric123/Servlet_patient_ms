<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register Doctor - Admin Panel</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #1abc9c;
            --light-color: #f8f9fa;
            --dark-color: #222;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-color);
            overflow-x: hidden;
        }
        
        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            padding: 48px 0 0;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
            background: linear-gradient(145deg, var(--primary-color), var(--secondary-color));
            overflow-y: auto;
        }
        
        .sidebar:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,100 C20,0 50,0 100,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
            background-size: 100% 100%;
            pointer-events: none;
        }
        
        .sidebar-link {
            display: block;
            padding: 0.8rem 1.5rem;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
            position: relative;
            z-index: 1;
            margin-bottom: 5px;
            font-weight: 500;
        }
        
        .sidebar-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-left: 4px solid var(--accent-color);
            transform: translateX(5px);
        }
        
        .sidebar-link.active {
            background-color: rgba(255, 255, 255, 0.15);
            color: white;
            border-left: 4px solid var(--accent-color);
            font-weight: 600;
        }
        
        .content-area {
            margin-left: 250px;
            padding: 30px;
            transition: all 0.3s ease;
        }
        
        /* Sidebar Logo */
        .sidebar-logo {
            padding: 15px;
            margin-bottom: 20px;
        }
        
        .sidebar-logo i {
            background: linear-gradient(135deg, #ffffff, rgba(255,255,255,0.7));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 15px;
            filter: drop-shadow(0 3px 5px rgba(0,0,0,0.2));
            transition: all 0.3s ease;
        }
        
        .sidebar-logo:hover i {
            transform: scale(1.1);
        }
        
        .sidebar-logo h5 {
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
            margin: 0;
            letter-spacing: 0.5px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }
        
        /* Card Styles */
        .card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
            border: none;
            transition: all 0.3s ease;
            margin-bottom: 30px;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            padding: 1.2rem 1.5rem;
            font-weight: 600;
            border-bottom: none;
            position: relative;
            overflow: hidden;
        }
        
        .card-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,0 C30,40 70,40 100,0 L100,100 0,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
            background-size: 100% 100%;
        }
        
        .card-body {
            padding: 1.8rem;
            background-color: white;
        }
        
        /* Form Styles */
        .form-control {
            border-radius: 10px;
            padding: 12px 15px;
            border: 1px solid rgba(0, 0, 0, 0.1);
            font-size: 0.95rem;
            transition: all 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            margin-bottom: 10px;
        }
        
        .form-label {
            font-weight: 600;
            color: var(--primary-color);
            margin-bottom: 8px;
            padding-left: 5px;
        }
        
        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
            transform: translateY(-2px);
        }
        
        .form-control:hover {
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }
        
        .required-field::after {
            content: " *";
            color: #e74c3c;
            font-weight: bold;
        }
        
        /* Section Headers */
        h5 {
            color: var(--primary-color);
            font-weight: 700;
            position: relative;
            display: inline-block;
            margin-bottom: 1.5rem;
        }
        
        h5::after {
            content: '';
            position: absolute;
            bottom: -8px;
            left: 0;
            width: 40px;
            height: 3px;
            background: linear-gradient(to right, var(--secondary-color), var(--accent-color));
            border-radius: 3px;
        }
        
        hr {
            opacity: 0.1;
            margin: 2rem 0;
        }
        
        /* Button Styles */
        .btn-primary {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 0.8rem 2rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-primary:hover, .btn-primary:focus {
            background: linear-gradient(to right, var(--secondary-color), var(--primary-color));
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        
        .btn-secondary {
            background: #6c757d;
            border: none;
            padding: 0.8rem 2rem;
            font-weight: 600;
            border-radius: 50px;
            transition: all 0.3s ease;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-secondary:hover, .btn-secondary:focus {
            background: #5a6268;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        
        /* Alert Styles */
        .alert {
            border-radius: 10px;
            padding: 15px 20px;
            font-weight: 500;
            border: none;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .alert-success {
            background-color: rgba(26, 188, 156, 0.15);
            color: #1abc9c;
        }
        
        .alert-danger {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
        }
        
        /* Navbar */
        .navbar {
            background-color: white !important;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
            border-radius: 10px;
            margin-bottom: 25px;
        }
        
        .user-info {
            font-weight: 600;
            color: var(--primary-color);
            padding: 8px 15px;
            border-radius: 50px;
            background-color: rgba(52, 152, 219, 0.1);
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fadeIn {
            animation: fadeIn 0.5s ease;
        }
        
        /* Form Animation */
        .animate-form .form-control {
            transform: translateY(20px);
            opacity: 0;
            animation: formFieldFadeIn 0.5s ease forwards;
        }
        
        @keyframes formFieldFadeIn {
            to { transform: translateY(0); opacity: 1; }
        }
        
        .animate-form .row:nth-child(1) .form-control { animation-delay: 0.1s; }
        .animate-form .row:nth-child(2) .form-control { animation-delay: 0.2s; }
        .animate-form .row:nth-child(3) .form-control { animation-delay: 0.3s; }
        .animate-form .row:nth-child(4) .form-control { animation-delay: 0.4s; }
        .animate-form .row:nth-child(5) .form-control { animation-delay: 0.5s; }
        
        /* Responsive Adjustments */
        @media (max-width: 767.98px) {
            .sidebar {
                position: static;
                padding-top: 0;
                height: auto;
            }
            
            .content-area {
                margin-left: 0;
                padding: 15px;
            }
            
            .card-header {
                padding: 1rem;
            }
            
            .sidebar-link:hover {
                transform: none;
            }
            
            .form-card {
                max-width: 100%;
            }
        }
        
        .form-card {
            max-width: 100%;
        }
        
        /* Form Container */
        .form-container {
            max-width: 1000px;
            margin: 0 auto;
        }
        
        /* Form Container Specific Styling */
        .form-container .card {
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1) !important;
            border-radius: 20px;
            overflow: hidden;
        }
        
        .form-container .card-header {
            padding: 1.5rem;
            text-align: center;
            font-size: 1.1rem;
        }
        
        .form-container .card-body {
            padding: 2rem;
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="position-sticky">
                    <div class="text-center mb-4 mt-3">
                        <div class="sidebar-logo">
                            <i class="fas fa-hospital-user fa-3x mb-3"></i>
                            <h5>Patient Management System</h5>
                        </div>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link active" href="${pageContext.request.contextPath}/admin/register-doctor" id="register-doctor-btn">
                                <i class="fas fa-user-md me-2"></i>Register Doctor
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-area">
                <!-- Top Navbar -->
                <nav class="navbar navbar-expand-lg navbar-light bg-white mb-4 shadow-sm rounded">
                    <div class="container-fluid">
                        <button class="navbar-toggler d-md-none collapsed" type="button" data-bs-toggle="collapse" data-bs-target=".sidebar">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <span class="navbar-brand d-md-none">PMS</span>
                        <div class="d-flex align-items-center ms-auto">
                            <div class="user-info">
                                <i class="fas fa-user-shield me-1"></i>Admin: ${user.username}
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Page Title -->
                <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pb-2 mb-4 border-bottom">
                    <h1 class="h2"><i class="fas fa-user-md me-2 text-primary"></i>Register New Doctor</h1>
                </div>

                <!-- Error message if present -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger fadeIn">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    </div>
                </c:if>
                
                <!-- Success message if present -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success fadeIn">
                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                    </div>
                </c:if>

                <!-- Doctor Registration Form -->
                <div class="row justify-content-center form-container">
                    <div class="col-lg-9 col-xl-8">
                        <div class="card mb-4 shadow">
                            <div class="card-header">
                                <i class="fas fa-user-md me-1"></i>Doctor Registration Form
                            </div>
                            <div class="card-body">
                                <form action="${pageContext.request.contextPath}/admin/register-doctor" method="post" class="animate-form">
                                    <h5 class="mb-4">Personal Information</h5>
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="firstName" class="form-label required-field">First Name</label>
                                            <input type="text" class="form-control" id="firstName" name="firstName" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="lastName" class="form-label required-field">Last Name</label>
                                            <input type="text" class="form-control" id="lastName" name="lastName" required>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="email" class="form-label required-field">Email</label>
                                            <input type="email" class="form-control" id="email" name="email" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="telephone" class="form-label required-field">Telephone</label>
                                            <input type="tel" class="form-control" id="telephone" name="telephone" required>
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-3">
                                        <div class="col-md-12">
                                            <label for="address" class="form-label required-field">Address</label>
                                            <textarea class="form-control" id="address" name="address" rows="2" required></textarea>
                                        </div>
                                    </div>

                                    <hr class="my-4">
                                    <h5 class="mb-4">Professional Information</h5>
                                    
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="hospitalName" class="form-label required-field">Hospital Name</label>
                                            <input type="text" class="form-control" id="hospitalName" name="hospitalName" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="specialization" class="form-label">Specialization</label>
                                            <input type="text" class="form-control" id="specialization" name="specialization">
                                        </div>
                                    </div>
                                    
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="licenseNumber" class="form-label required-field">License Number</label>
                                            <input type="text" class="form-control" id="licenseNumber" name="licenseNumber" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="yearsOfExperience" class="form-label">Years of Experience</label>
                                            <input type="number" class="form-control" id="yearsOfExperience" name="yearsOfExperience" min="0" max="50">
                                        </div>
                                    </div>

                                    <hr class="my-4">
                                    <h5 class="mb-4">Account Information</h5>
                                    
                                    <div class="row mb-3">
                                        <div class="col-md-6">
                                            <label for="username" class="form-label required-field">Username</label>
                                            <input type="text" class="form-control" id="username" name="username" required>
                                        </div>
                                        <div class="col-md-6">
                                            <label for="password" class="form-label required-field">Password</label>
                                            <input type="password" class="form-control" id="password" name="password" required>
                                        </div>
                                    </div>
                                    
                                    <div class="mt-4 text-center">
                                        <button type="submit" class="btn btn-primary btn-lg px-5">
                                            <i class="fas fa-save me-2"></i>Register Doctor
                                        </button>
                                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary btn-lg ms-3 px-5">
                                            <i class="fas fa-times me-2"></i>Cancel
                                        </a>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">&copy; 2025 Patient Management System | Admin Panel</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 