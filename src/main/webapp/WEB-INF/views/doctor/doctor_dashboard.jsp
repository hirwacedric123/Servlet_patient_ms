<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Doctor Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #27ae60;
            --accent-color: #1abc9c;
            --light-color: #f8f9fa;
            --dark-color: #222;
            --pending-color: #f39c12;
            --confirmed-color: #3498db;
            --referrable-color: #e74c3c;
            --nurses-color: #9b59b6;
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
        }
        
        .stats-card:nth-child(1):hover {
            border-bottom: 4px solid var(--pending-color);
        }
        
        .stats-card:nth-child(2):hover {
            border-bottom: 4px solid var(--confirmed-color);
        }
        
        .stats-card:nth-child(3):hover {
            border-bottom: 4px solid var(--referrable-color);
        }
        
        .stats-card:nth-child(4):hover {
            border-bottom: 4px solid var(--nurses-color);
        }
        
        .stats-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        
        .pending { 
            background: linear-gradient(135deg, var(--pending-color), #f1c40f); 
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .confirmed { 
            background: linear-gradient(135deg, var(--confirmed-color), #2980b9); 
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .referrable { 
            background: linear-gradient(135deg, var(--referrable-color), #c0392b); 
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .nurses { 
            background: linear-gradient(135deg, var(--nurses-color), #8e44ad); 
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
            background-color: rgba(39, 174, 96, 0.08);
            transform: scale(1.01);
            transition: all 0.2s ease;
        }
        
        /* Badge & Button Styles */
        .badge {
            padding: 6px 12px;
            font-weight: 500;
            border-radius: 30px;
            font-size: 0.85rem;
        }
        
        .bg-warning {
            background: linear-gradient(to right, var(--pending-color), #f1c40f) !important;
        }
        
        .bg-success {
            background: linear-gradient(to right, var(--secondary-color), var(--accent-color)) !important;
        }
        
        .bg-danger {
            background: linear-gradient(to right, var(--referrable-color), #c0392b) !important;
        }
        
        .btn-primary {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            padding: 0.6rem 1.2rem;
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
            background-color: rgba(39, 174, 96, 0.1);
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
        
        .alert-warning {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fadeIn {
            animation: fadeIn 0.5s ease;
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
                            <i class="fas fa-user-md fa-3x mb-3"></i>
                            <h5>Patient Management System</h5>
                        </div>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="sidebar-link active" href="${pageContext.request.contextPath}/doctor/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/doctor/register-nurse">
                                <i class="fas fa-user-nurse me-2"></i>Register Nurse
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
                                <i class="fas fa-user-md me-1"></i>Dr. ${doctor.firstName} ${doctor.lastName}
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
                            <i class="fas fa-user-md fa-3x welcome-icon"></i>
                        </div>
                        <div class="col-md-11">
                            <h2>Welcome, Dr. ${doctor.firstName} ${doctor.lastName}!</h2>
                            <p>You are logged in as a doctor specializing in ${doctor.specialization} at ${doctor.hospitalName}</p>
                        </div>
                    </div>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-3">
                        <div class="card stats-card h-100">
                            <div class="card-body">
                                <i class="fas fa-clock stats-icon pending"></i>
                                <h3>${pendingCount}</h3>
                                <h5>Pending Cases</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stats-card h-100">
                            <div class="card-body">
                                <i class="fas fa-check-double stats-icon confirmed"></i>
                                <h3>${confirmedCount}</h3>
                                <h5>Confirmed Cases</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stats-card h-100">
                            <div class="card-body">
                                <i class="fas fa-exclamation-triangle stats-icon referrable"></i>
                                <h3>${referrableCount}</h3>
                                <h5>Referrable Cases</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="card stats-card h-100">
                            <div class="card-body">
                                <i class="fas fa-user-nurse stats-icon nurses"></i>
                                <h3>${nursesCount}</h3>
                                <h5>Registered Nurses</h5>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Pending Referrals -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-clock me-1"></i>Pending Referrals from Nurses
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty pendingReferrals}">
                                <p class="text-center text-muted">No pending referrals at the moment</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Diag. ID</th>
                                                <th>Patient Name</th>
                                                <th>Age</th>
                                                <th>Gender</th>
                                                <th>Submitted By</th>
                                                <th>Status</th>
                                                <th>Date</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${pendingReferrals}" var="referral">
                                                <tr>
                                                    <td>${referral.diagnosisID}</td>
                                                    <td>${referral.patientName}</td>
                                                    <td>${referral.patientAge}</td>
                                                    <td>${referral.patientGender}</td>
                                                    <td>${referral.submittedByNurse}</td>
                                                    <td>
                                                        <span class="badge bg-warning">${referral.diagnosisResult}</span>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${referral.createdDate}" pattern="dd-MM-yyyy" />
                                                    </td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/doctor/diagnose?id=${referral.diagnosisID}" class="btn btn-sm btn-primary">
                                                            <i class="fas fa-stethoscope"></i> Update
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Completed Cases -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-check-double me-1"></i>Completed Referrals
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty completedCases}">
                                <p class="text-center text-muted">No completed referrals yet</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Diag. ID</th>
                                                <th>Patient Name</th>
                                                <th>Age</th>
                                                <th>Gender</th>
                                                <th>Submitted By</th>
                                                <th>Result</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${completedCases}" var="caseData">
                                                <tr>
                                                    <td>${caseData.diagnosisID}</td>
                                                    <td>${caseData.patientName}</td>
                                                    <td>${caseData.patientAge}</td>
                                                    <td>${caseData.patientGender}</td>
                                                    <td>${caseData.submittedByNurse}</td>
                                                    <td>${caseData.diagnosisResult}</td>
                                                    <td>
                                                        <fmt:formatDate value="${caseData.createdDate}" pattern="dd-MM-yyyy" />
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <!-- Non-Referrable Cases (Read Only) -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-ban me-1"></i>Non-Referrable Cases (Read-Only)
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty nonReferrableCases}">
                                <p class="text-center text-muted">No non-referrable cases available</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>Diag. ID</th>
                                                <th>Patient Name</th>
                                                <th>Age</th>
                                                <th>Gender</th>
                                                <th>Submitted By</th>
                                                <th>Result</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${nonReferrableCases}" var="caseData">
                                                <tr>
                                                    <td>${caseData.diagnosisID}</td>
                                                    <td>${caseData.patientName}</td>
                                                    <td>${caseData.patientAge}</td>
                                                    <td>${caseData.patientGender}</td>
                                                    <td>${caseData.submittedByNurse}</td>
                                                    <td>${caseData.diagnosisResult}</td>
                                                    <td>
                                                        <fmt:formatDate value="${caseData.createdDate}" pattern="dd-MM-yyyy" />
                                                    </td>
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
        <p class="mb-0">&copy; 2025 Patient Management System | Doctor Dashboard</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 