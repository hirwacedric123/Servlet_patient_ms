<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Nurse Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #1abc9c;
            --light-color: #f8f9fa;
            --dark-color: #222;
            --patients-color: #2ecc71;
            --referrable-color: #e74c3c;
            --non-referrable-color: #f39c12;
            --sidebar-width: 250px;
            --sidebar-width-collapsed: 60px;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-color);
            color: #333;
            font-size: 14px;
            overflow-x: hidden;
        }
        
        .card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
            border: none;
            transition: all 0.3s ease;
            margin-bottom: 20px;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            font-weight: 600;
            border: none;
            padding: 1.2rem 1.5rem;
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
        
        .welcome-icon {
            color: rgba(255, 255, 255, 0.9);
            background: linear-gradient(135deg, rgba(255,255,255,0.9), rgba(255,255,255,0.7));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            filter: drop-shadow(0 2px 3px rgba(0,0,0,0.3));
            animation: floatIcon 3s ease-in-out infinite;
        }
        
        @keyframes floatIcon {
            0% { transform: translateY(0); }
            50% { transform: translateY(-10px); }
            100% { transform: translateY(0); }
        }
        
        .stats-card {
            text-align: center;
            padding: 25px;
            background-color: white;
            border-radius: 15px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
            margin-bottom: 20px;
            border-bottom: 4px solid transparent;
            height: 100%;
        }
        
        .stats-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .stats-card:nth-child(1):hover {
            border-bottom: 4px solid var(--patients-color);
        }
        
        .stats-card:nth-child(2):hover {
            border-bottom: 4px solid var(--referrable-color);
        }
        
        .stats-card:nth-child(3):hover {
            border-bottom: 4px solid var(--non-referrable-color);
        }
        
        .stats-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        .patients { 
            background: linear-gradient(135deg, var(--patients-color), #27ae60); 
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .referrable { 
            background: linear-gradient(135deg, var(--referrable-color), #c0392b); 
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .non-referrable { 
            background: linear-gradient(135deg, var(--non-referrable-color), #d35400); 
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .stats-card h3 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
            color: var(--primary-color);
        }
        
        .stats-card h5 {
            color: #666;
            font-weight: 600;
            font-size: 1.1rem;
        }
        
        .patient-image {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #fff;
            box-shadow: 0 0 0 1px #ddd;
            transition: transform 0.3s ease;
        }
        
        .patient-image:hover {
            transform: scale(1.15);
        }
        
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
        
        .alert-warning {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
        }
        
        /* Table styling */
        .table {
            border-radius: 10px;
            overflow: hidden;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            font-size: 0.9rem;
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
        
        /* Badge styling */
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
        
        .badge.bg-danger {
            background: linear-gradient(to right, var(--referrable-color), #c0392b) !important;
        }
        
        /* Button styling */
        .btn {
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.85rem;
        }
        
        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.75rem;
        }
        
        .btn-primary {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            border-radius: 50px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-primary:hover, .btn-primary:focus {
            background: linear-gradient(to right, var(--secondary-color), var(--primary-color));
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        
        .btn-info {
            background: linear-gradient(to right, #17a2b8, #00d2ff);
            border: none;
            border-radius: 50px;
            color: white;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-info:hover, .btn-info:focus {
            background: linear-gradient(to right, #00d2ff, #17a2b8);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
            color: white;
        }
        
        .btn-success {
            background: linear-gradient(to right, #28a745, #20c997);
            border: none;
            border-radius: 50px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-success:hover, .btn-success:focus {
            background: linear-gradient(to right, #20c997, #28a745);
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        
        .btn-light {
            background-color: white;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.05);
            border-radius: 50px;
            color: var(--primary-color);
            border: 1px solid rgba(0, 0, 0, 0.05);
        }
        
        .btn-light:hover, .btn-light:focus {
            background-color: white;
            transform: translateY(-3px);
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .action-buttons {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
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
            width: var(--sidebar-width);
            transition: all 0.3s ease;
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
        
        .sidebar.collapsed {
            width: var(--sidebar-width-collapsed);
        }
        
        /* Sidebar Logo */
        .sidebar-header {
            padding: 15px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .sidebar-header i {
            background: linear-gradient(135deg, #ffffff, rgba(255,255,255,0.7));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 15px;
            filter: drop-shadow(0 3px 5px rgba(0,0,0,0.2));
            transition: all 0.3s ease;
        }
        
        .sidebar-header:hover i {
            transform: scale(1.1);
        }
        
        .sidebar-header h5 {
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
            margin: 0;
            letter-spacing: 0.5px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }
        
        .sidebar.collapsed .sidebar-header h5 {
            opacity: 0;
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
            white-space: nowrap;
            overflow: hidden;
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
        
        .sidebar-link i {
            width: 20px;
            text-align: center;
            margin-right: 10px;
            font-size: 1rem;
        }
        
        .sidebar-link span {
            transition: opacity 0.3s;
        }
        
        .sidebar.collapsed .sidebar-link span {
            opacity: 0;
        }
        
        .content-area {
            margin-left: var(--sidebar-width);
            padding: 30px;
            transition: all 0.3s ease;
        }
        
        .content-area.expanded {
            margin-left: var(--sidebar-width-collapsed);
        }
        
        .toggle-sidebar {
            position: fixed;
            bottom: 20px;
            left: calc(var(--sidebar-width) - 15px);
            z-index: 101;
            width: 30px;
            height: 30px;
            background: var(--secondary-color);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            border: none;
        }
        
        .toggle-sidebar:hover {
            transform: scale(1.1);
        }
        
        .toggle-sidebar.collapsed {
            left: calc(var(--sidebar-width-collapsed) - 15px);
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
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fadeIn {
            animation: fadeIn 0.5s ease;
        }
        
        .registered-by-you {
            background-color: rgba(52, 152, 219, 0.05);
            border-left: 4px solid var(--secondary-color);
        }
        
        /* Responsive Adjustments */
        @media (max-width: 1199.98px) {
            .stats-icon {
                font-size: 2.5rem;
            }
            
            .stats-card h3 {
                font-size: calc(1.3rem + 0.6vw);
            }
            
            .stats-card h5 {
                font-size: 0.85rem;
            }
        }
        
        @media (max-width: 991.98px) {
            .action-buttons .btn-sm span {
                display: none;
            }
            
            .welcome-banner h2 {
                font-size: calc(1.2rem + 0.5vw);
            }
            
            .welcome-banner p {
                font-size: 0.9rem;
            }
        }
        
        @media (max-width: 767.98px) {
            .sidebar {
                position: static;
                padding-top: 0;
                height: auto;
                margin-left: calc(-1 * var(--sidebar-width));
                position: fixed;
                z-index: 999;
            }
            
            .sidebar.show {
                margin-left: 0;
            }
            
            .content-area {
                margin-left: 0;
                padding: 15px;
            }
            
            .welcome-banner {
                padding: 20px;
            }
            
            .sidebar-link:hover {
                transform: none;
            }
            
            .toggle-sidebar {
                display: none;
            }
        }
        
        @media (max-width: 575.98px) {
            .welcome-banner {
                padding: 15px;
            }
            
            .welcome-banner h2 {
                font-size: 1.2rem;
            }
            
            .welcome-banner p {
                font-size: 0.8rem;
            }
            
            .badge {
                font-size: 0.7rem;
                padding: 0.3em 0.5em;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block sidebar" id="sidebar">
                <div class="position-sticky">
                    <div class="text-center mb-4 mt-3">
                        <div class="sidebar-header">
                            <i class="fas fa-user-nurse fa-3x mb-3"></i>
                            <h5>Patient Management System</h5>
                        </div>
                </div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="sidebar-link active" href="${pageContext.request.contextPath}/nurse/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="sidebar-link" href="${pageContext.request.contextPath}/nurse/patient-registration">
                                <i class="fas fa-user-plus me-2"></i>Register Patient
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

            <!-- Toggle sidebar button -->
            <button class="toggle-sidebar" id="toggleSidebar">
                <i class="fas fa-chevron-left" id="toggleIcon"></i>
            </button>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-area" id="mainContent">
                <!-- Top Navbar for mobile -->
                <nav class="navbar navbar-expand-lg navbar-light mb-4 shadow-sm rounded d-md-none">
                    <div class="container-fluid">
                        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target=".sidebar">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <span class="navbar-brand">PMS</span>
                        <div class="d-flex align-items-center ms-auto">
                            <div class="user-info">
                                <i class="fas fa-user-nurse me-1"></i>${nurse.firstName} ${nurse.lastName}
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Success message if present -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success fadeIn">
                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                    </div>
                </c:if>
                
                <!-- Error message if present -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-warning fadeIn">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    </div>
                </c:if>
                
                <!-- Welcome message -->
                <div class="welcome-banner">
                    <div class="row align-items-center">
                        <div class="col-md-1 text-center">
                            <i class="fas fa-user-nurse fa-3x welcome-icon"></i>
                        </div>
                        <div class="col-md-11">
                            <h2>Welcome, ${nurse.firstName} ${nurse.lastName}!</h2>
                            <p>You are logged in as a nurse from ${nurse.healthCenter} health center.</p>
                        </div>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <div class="stats-card">
                            <i class="fas fa-users stats-icon patients"></i>
                                <h3>${patientCount}</h3>
                                <h5>Total Patients</h5>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stats-card">
                            <i class="fas fa-hospital-user stats-icon referrable"></i>
                                <h3>${referrableCount}</h3>
                                <h5>Referrable Cases</h5>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="stats-card">
                            <i class="fas fa-user-check stats-icon non-referrable"></i>
                                <h3>${nonReferrableCount}</h3>
                                <h5>Non-Referrable Cases</h5>
                        </div>
                    </div>
                </div>

                <!-- Patient List -->
                <div class="card mb-4">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">
                                <i class="fas fa-users me-2"></i>
                                <c:choose>
                                    <c:when test="${pageContext.request.servletPath == '/nurse/patients'}">
                                        All Patients in System
                                    </c:when>
                                    <c:otherwise>
                                        Patients Diagnosis Table
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                            <a href="${pageContext.request.contextPath}/nurse/patient-registration" class="btn btn-light btn-sm">
                                <i class="fas fa-plus me-1"></i>Register Patient
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty registeredPatients}">
                                <div class="text-center py-4">
                                    <i class="fas fa-clipboard-list text-muted fa-3x mb-3"></i>
                                    <p class="text-muted">No patients registered yet</p>
                                    <a href="${pageContext.request.contextPath}/nurse/patient-registration" class="btn btn-primary mt-2">
                                        <i class="fas fa-plus me-1"></i>Register Your First Patient
                                    </a>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover table-striped">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Patient Name</th>
                                                <th>Gender</th>
                                                <th>Contact</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${registeredPatients}" var="patient" varStatus="loop">
                                                <tr class="${patient.getCreatedBy() == nurse.getNurseID() ? 'registered-by-you' : ''}">
                                                    <td>${patient.patientID}</td>
                                                    <td>${patient.firstName} ${patient.lastName}</td>
                                                    <td>${patient.gender}</td>
                                                    <td>${patient.contactNumber}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${patient.isReferrable()}">
                                                                <span class="badge bg-danger">Referrable</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">Non-Referrable</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <c:if test="${patient.getCreatedBy() == nurse.getNurseID()}">
                                                            <span class="badge bg-primary">Registered by you</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <a href="${pageContext.request.contextPath}/nurse/edit-patient?id=${patient.patientID}" class="btn btn-sm btn-primary">
                                                                <i class="fas fa-edit"></i> <span>Edit</span>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/nurse/view-patient?id=${patient.patientID}" class="btn btn-sm btn-info">
                                                                <i class="fas fa-eye"></i> <span>View</span>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/nurse/create-diagnosis?patientId=${patient.patientID}" class="btn btn-sm btn-success">
                                                                <i class="fas fa-stethoscope"></i> <span>Diagnose</span>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <c:if test="${patientCount > 10}">
                                    <div class="text-center mt-3">
                                        <a href="${pageContext.request.contextPath}/nurse/patients" class="btn btn-outline-primary">
                                            <i class="fas fa-list me-1"></i>View All Patients
                                        </a>
                                    </div>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle sidebar on mobile
        document.addEventListener('DOMContentLoaded', function() {
            const mobileToggle = document.querySelector('[data-bs-toggle="collapse"]');
            if (mobileToggle) {
                mobileToggle.addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('show');
        });
            }
        
        // Toggle sidebar collapse for desktop
        const toggleBtn = document.getElementById('toggleSidebar');
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        const toggleIcon = document.getElementById('toggleIcon');
        
            if (toggleBtn) {
        toggleBtn.addEventListener('click', function() {
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('expanded');
            toggleBtn.classList.toggle('collapsed');
            
            if (sidebar.classList.contains('collapsed')) {
                toggleIcon.classList.remove('fa-chevron-left');
                toggleIcon.classList.add('fa-chevron-right');
            } else {
                toggleIcon.classList.remove('fa-chevron-right');
                toggleIcon.classList.add('fa-chevron-left');
            }
        });
            }
        });
    </script>
</body>
</html> 