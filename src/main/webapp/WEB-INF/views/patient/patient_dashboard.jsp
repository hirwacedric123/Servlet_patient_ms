<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Patient Dashboard - Patient Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #1abc9c;
            --light-color: #f8f9fa;
            --dark-color: #222;
            --success-color: #2ecc71;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
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
        
        .health-widget {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px 10px;
            border-radius: 15px;
            transition: all 0.3s ease;
            min-height: 180px;
            text-align: center;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.08);
        }
        
        .health-widget:hover {
            transform: translateY(-10px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.15);
        }
        
        .health-widget-icon {
            font-size: 3.5rem;
            margin-bottom: 15px;
            background: linear-gradient(135deg, rgba(255,255,255,0.9), rgba(255,255,255,0.7));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            filter: drop-shadow(0 2px 3px rgba(0,0,0,0.3));
        }
        
        .health-widget h3 {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 10px;
        }
        
        .health-widget h5 {
            font-weight: 600;
            margin-bottom: 0;
            font-size: 1.1rem;
        }
        
        .health-widget.pending {
            background: linear-gradient(to bottom right, var(--warning-color), #ffca28);
            color: white;
        }
        
        .health-widget.not-referrable,
        .health-widget.negative {
            background: linear-gradient(to bottom right, #6c757d, #495057);
            color: white;
        }
        
        .health-widget.confirmed {
            background: linear-gradient(to bottom right, var(--success-color), #66bb6a);
            color: white;
        }
        
        .patient-info-text {
            color: #495057;
            font-weight: 500;
        }
        
        .diagnosis-card {
            transition: all 0.3s ease;
            margin-bottom: 20px;
            border: none;
        }
        
        .diagnosis-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .diagnosis-card.pending {
            border-left: 4px solid var(--warning-color);
        }
        
        .diagnosis-card.confirmed {
            border-left: 4px solid var(--success-color);
        }
        
        .diagnosis-card.negative {
            border-left: 4px solid #6c757d;
        }
        
        /* Animation classes */
        .animated-card {
            animation: fadeIn 0.5s ease-out;
        }
        
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fadeIn {
            animation: fadeIn 0.5s ease;
        }
        
        @media (max-width: 767.98px) {
            .sidebar {
                position: static;
                padding-top: 0;
            }
            .content-area {
                margin-left: 0;
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
                        <i class="fas fa-hospital text-light fa-3x mb-3"></i>
                        <h5 class="text-light">Patient Management System</h5>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="sidebar-link active" href="${pageContext.request.contextPath}/patient/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/patient/profile">
                                <i class="fas fa-user-circle me-2"></i>My Profile
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
                                <i class="fas fa-user-circle me-1"></i>${patient.firstName} ${patient.lastName}
                            </div>
                        </div>
                    </div>
                </nav>

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
                            <i class="fas fa-user fa-3x welcome-icon"></i>
                        </div>
                        <div class="col-md-9">
                            <h2>Welcome, ${patient.firstName} ${patient.lastName}!</h2>
                            <p>Here's your health information at a glance.</p>
                        </div>
                        <div class="col-md-2 text-end">
                            <c:if test="${not empty patient.profileImage}">
                                <img src="${pageContext.request.contextPath}${patient.profileImage}" 
                                     alt="Patient Photo" class="img-thumbnail rounded-circle" 
                                     style="width: 80px; height: 80px; object-fit: cover; border: 3px solid white; box-shadow: 0 5px 15px rgba(0,0,0,0.1);">
                            </c:if>
                            <c:if test="${empty patient.profileImage}">
                                <div class="text-center">
                                    <i class="fas fa-user-circle text-white" style="font-size: 4rem; filter: drop-shadow(0 5px 15px rgba(0,0,0,0.1));"></i>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Health Status Widgets -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-4">
                        <div class="health-widget pending">
                            <i class="fas fa-clock health-widget-icon"></i>
                            <h3>${pendingCount}</h3>
                            <h5>Pending Diagnoses</h5>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-4">
                        <div class="health-widget confirmed">
                            <i class="fas fa-check-circle health-widget-icon"></i>
                            <h3>${confirmedCount}</h3>
                            <h5>Confirmed Diagnoses</h5>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-4">
                        <div class="health-widget negative">
                            <i class="fas fa-shield-alt health-widget-icon"></i>
                            <h3>${negativeCount}</h3>
                            <h5>Not Referable</h5>
                        </div>
                    </div>
                </div>

                <!-- Patient Information Card -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Patient Profile</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty patient.gender || empty patient.dateOfBirth || empty patient.contactNumber || empty patient.email || empty patient.address}">
                                <div class="alert alert-warning">
                                    <i class="fas fa-exclamation-triangle me-2"></i>
                                    Your profile is incomplete. Please update your information to ensure you receive the best healthcare service.
                                    <div class="mt-3">
                                        <a href="${pageContext.request.contextPath}/patient/profile" class="btn btn-primary">
                                            <i class="fas fa-user-edit me-2"></i>Complete Profile
                                        </a>
                                    </div>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="row">
                                    <div class="col-md-6">
                                        <p><strong>Full Name:</strong> <span class="patient-info-text">${patient.firstName} ${patient.lastName}</span></p>
                                        <p><strong>Gender:</strong> <span class="patient-info-text">${patient.gender}</span></p>
                                        <p><strong>Date of Birth:</strong> <span class="patient-info-text">
                                            <fmt:formatDate value="${patient.dateOfBirth}" pattern="MMMM dd, yyyy" />
                                        </span></p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><strong>Contact Number:</strong> <span class="patient-info-text">${patient.contactNumber}</span></p>
                                        <p><strong>Email:</strong> <span class="patient-info-text">${patient.email}</span></p>
                                        <p><strong>Address:</strong> <span class="patient-info-text">${patient.address}</span></p>
                                    </div>
                                </div>
                                <div class="text-end mt-3">
                                    <a href="${pageContext.request.contextPath}/patient/profile" class="btn btn-primary">
                                        <i class="fas fa-user-edit me-1"></i>Edit Profile
                                    </a>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Recent Diagnoses -->
                <div class="card mb-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-heartbeat me-2"></i>Diagnosis Status</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty diagnoses}">
                                <div class="text-center p-4">
                                    <i class="fas fa-clipboard-list text-muted mb-3" style="font-size: 3rem;"></i>
                                    <h5 class="text-muted">No diagnoses available</h5>
                                    <p class="text-muted">You don't have any diagnoses recorded in the system yet.</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead class="table-light">
                                            <tr>
                                                <th>ID</th>
                                                <th>Nurse</th>
                                                <th>Doctor</th>
                                                <th>Status</th>
                                                <th>Result</th>
                                                <th>Date</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="diagnosis" items="${diagnoses}">
                                                <tr>
                                                    <td>${diagnosis.diagnosisID}</td>
                                                    <td>Nurse ${diagnosis.nurseName}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty diagnosis.doctorName}">
                                                                Dr. ${diagnosis.doctorName}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">N/A</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${diagnosis.isReferrable}">
                                                                <span class="badge bg-danger">Referrable</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">Not Referrable</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${diagnosis.isPending}">
                                                                <span class="badge bg-warning text-dark">Pending</span>
                                                            </c:when>
                                                            <c:when test="${diagnosis.isNegative}">
                                                                <span class="badge bg-secondary">Negative</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">${diagnosis.result}</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <fmt:formatDate value="${diagnosis.createdDate}" pattern="MMM dd, yyyy" />
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

                <!-- Detailed Diagnosis Cards -->
                <div class="row">
                    <c:forEach var="diagnosis" items="${diagnoses}" varStatus="status">
                        <div class="col-md-6 mb-4">
                            <div class="card diagnosis-card ${diagnosis.isPending ? 'pending' : diagnosis.isNegative ? 'negative' : 'confirmed'}">
                                <div class="card-body">
                                    <h5 class="card-title">
                                        <c:choose>
                                            <c:when test="${diagnosis.isPending}">
                                                <i class="fas fa-clock text-warning me-2"></i>Pending Diagnosis
                                            </c:when>
                                            <c:when test="${diagnosis.isConfirmed}">
                                                <i class="fas fa-check-circle text-success me-2"></i>Confirmed Diagnosis
                                            </c:when>
                                            <c:when test="${diagnosis.isNegative}">
                                                <i class="fas fa-shield-alt text-secondary me-2"></i>Not Referable
                                            </c:when>
                                        </c:choose>
                                    </h5>
                                    <h6 class="card-subtitle mb-2 text-muted">
                                        <fmt:formatDate value="${diagnosis.createdDate}" pattern="MMMM dd, yyyy" />
                                    </h6>
                                    <hr>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <p><strong>Status:</strong> ${diagnosis.diagnoStatus}</p>
                                            <p><strong>Result:</strong> ${diagnosis.result}</p>
                                        </div>
                                        <div class="col-md-6">
                                            <p><strong>Nurse:</strong> ${diagnosis.nurseName}</p>
                                            <p><strong>Doctor:</strong> 
                                                <c:choose>
                                                    <c:when test="${not empty diagnosis.doctorName}">
                                                        Dr. ${diagnosis.doctorName}
                                                    </c:when>
                                                    <c:otherwise>
                                                        <span class="text-muted">Not assigned</span>
                                                    </c:otherwise>
                                                </c:choose>
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </main>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-2">
        <p class="mb-0">&copy; 2025 Patient Management System | Patient Dashboard</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 