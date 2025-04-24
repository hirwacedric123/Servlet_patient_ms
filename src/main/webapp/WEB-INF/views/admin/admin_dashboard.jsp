<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard</title>
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
        
        /* Button Styles */
        .btn-primary {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 0.6rem 1.5rem;
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
        
        /* Welcome Banner */
        .welcome-banner {
            border-radius: 15px;
            padding: 30px;
            margin-bottom: 30px;
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
            color: white;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            position: relative;
            overflow: hidden;
            animation: fadeIn 0.5s ease;
        }
        
        .welcome-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,0 C30,40 70,40 100,0 L100,100 0,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
            background-size: 100% 100%;
        }
        
        .welcome-banner h2 {
            font-weight: 700;
            margin-bottom: 10px;
            position: relative;
        }
        
        .welcome-banner p {
            opacity: 0.9;
            position: relative;
            font-size: 1.1rem;
        }
        
        /* Table Styles */
        .table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .table thead th {
            background-color: rgba(44, 62, 80, 0.05);
            border-color: rgba(0, 0, 0, 0.05);
            color: var(--primary-color);
            font-weight: 600;
            padding: 15px;
        }
        
        .table-striped tbody tr:nth-of-type(odd) {
            background-color: rgba(0, 0, 0, 0.02);
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.08);
            transform: scale(1.01);
            transition: all 0.2s ease;
        }
        
        .badge {
            padding: 6px 12px;
            font-weight: 500;
            border-radius: 30px;
            font-size: 0.85rem;
        }
        
        .badge.bg-primary {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color)) !important;
        }
        
        .badge.bg-success {
            background: linear-gradient(to right, #2ecc71, var(--accent-color)) !important;
        }
        
        /* Navbar */
        .navbar {
            background-color: white !important;
            box-shadow: 0 3px 10px rgba(0, 0, 0, 0.05);
            border-radius: 10px;
        }
        
        .user-info {
            font-weight: 600;
            color: var(--primary-color);
            padding: 8px 15px;
            border-radius: 50px;
            background-color: rgba(52, 152, 219, 0.1);
        }
        
        /* Stats Cards */
        .stats-card {
            text-align: center;
            padding: 25px;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            margin-bottom: 20px;
            border-bottom: 4px solid transparent;
        }
        
        .stats-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
            border-bottom: 4px solid var(--secondary-color);
        }
        
        .stats-icon {
            font-size: 3rem;
            margin-bottom: 15px;
            background: linear-gradient(135deg, var(--secondary-color), var(--accent-color));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .doctor-icon { 
            background: linear-gradient(135deg, var(--secondary-color), #3498db); 
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .nurse-icon { 
            background: linear-gradient(135deg, #2ecc71, var(--accent-color)); 
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
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
            
            .welcome-banner {
                padding: 20px;
            }
            
            .card-header {
                padding: 1rem;
            }
            
            .sidebar-link:hover {
                transform: none;
            }
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
                            <a class="sidebar-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/admin/register-doctor" id="register-doctor-btn">
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

                <!-- Welcome message -->
                <div class="welcome-banner">
                    <h2><i class="fas fa-user-check me-2"></i>Welcome, ${user.username}!</h2>
                    <p>You are logged in as an administrator. Here's an overview of your system.</p>
                </div>

                <!-- Statistics Overview -->
                <div class="row mb-4">
                    <div class="col-md-12 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-chart-bar me-1"></i>Diagnosis Cases Statistics
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Cases Registered by Medical Staff</h5>
                                <div class="row mt-4">
                                    <!-- Doctors Statistics -->
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header">
                                                <i class="fas fa-user-md me-1"></i>Cases by Doctor
                                            </div>
                                            <div class="card-body">
                                                <c:choose>
                                                    <c:when test="${empty doctorCasesStats}">
                                                        <p class="text-center text-muted">No diagnosis cases registered by doctors yet</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="table-responsive">
                                                            <table class="table table-striped table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Doctor</th>
                                                                        <th>Hospital</th>
                                                                        <th>Total Cases</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach items="${doctorCasesStats}" var="stats">
                                                                        <tr>
                                                                            <td>${stats.doctorName}</td>
                                                                            <td>${stats.hospitalName}</td>
                                                                            <td><span class="badge bg-primary">${stats.totalCases}</span></td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <!-- Nurses Statistics -->
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header">
                                                <i class="fas fa-user-nurse me-1"></i>Cases by Nurse
                                            </div>
                                            <div class="card-body">
                                                <c:choose>
                                                    <c:when test="${empty nurseCasesStats}">
                                                        <p class="text-center text-muted">No diagnosis cases registered by nurses yet</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="table-responsive">
                                                            <table class="table table-striped table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Nurse</th>
                                                                        <th>Health Center</th>
                                                                        <th>Total Cases</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach items="${nurseCasesStats}" var="stats">
                                                                        <tr>
                                                                            <td>${stats.nurseName}</td>
                                                                            <td>${stats.healthCenter}</td>
                                                                            <td><span class="badge bg-success">${stats.totalCases}</span></td>
                                                                        </tr>
                                                                    </c:forEach>
                                                                </tbody>
                                                            </table>
                                                        </div>
                                                    </c:otherwise>
                                                </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Doctors List -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-user-md me-1"></i>Registered Doctors
                    </div>
                    <div class="card-body">
                        <div class="mb-3 text-end">
                            <a href="${pageContext.request.contextPath}/admin/register-doctor" class="btn btn-primary">
                                <i class="fas fa-plus me-1"></i>Register New Doctor
                            </a>
                        </div>
                        <c:choose>
                            <c:when test="${empty doctors}">
                                <p class="text-center text-muted">No doctors registered yet</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Specialization</th>
                                                <th>Contact</th>
                                                <th>Email</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${doctors}" var="doctor">
                                                <tr>
                                                    <td>${doctor.doctorID}</td>
                                                    <td>${doctor.name}</td>
                                                    <td>${doctor.specialization}</td>
                                                    <td>${doctor.contactNumber}</td>
                                                    <td>${doctor.email}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Nurses List -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-user-nurse me-1"></i>Registered Nurses
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty nurses}">
                                <p class="text-center text-muted">No nurses registered yet</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Department</th>
                                                <th>Contact</th>
                                                <th>Email</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${nurses}" var="nurse">
                                                <tr>
                                                    <td>${nurse.nurseID}</td>
                                                    <td>${nurse.firstName} ${nurse.lastName}</td>
                                                    <td>${nurse.department}</td>
                                                    <td>${nurse.contactNumber}</td>
                                                    <td>${nurse.email}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">&copy; 2025 Patient Management System | Admin Dashboard</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 