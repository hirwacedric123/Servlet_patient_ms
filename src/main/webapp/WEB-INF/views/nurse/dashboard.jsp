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
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f9fa;
            color: #495057;
        }
        
        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            padding: 0;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            background-color: #344a6c;
            width: 250px;
            transition: all 0.3s ease-in-out;
        }
        
        .sidebar-header {
            background-color: #293952;
            padding: 20px 15px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        
        .sidebar-link {
            display: block;
            padding: 0.75rem 1.25rem;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
            font-weight: 500;
        }
        
        .sidebar-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-left-color: rgba(255, 255, 255, 0.5);
        }
        
        .sidebar-link.active {
            background-color: rgba(255, 255, 255, 0.15);
            color: white;
            border-left-color: #4ca8ef;
        }
        
        .sidebar-link i {
            width: 24px;
            text-align: center;
            margin-right: 8px;
        }
        
        /* Content area */
        .content-area {
            margin-left: 250px;
            padding: 25px;
            min-height: 100vh;
            transition: all 0.3s ease-in-out;
        }
        
        /* Cards */
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            transition: all 0.3s;
            margin-bottom: 24px;
        }
        
        .card:hover {
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
            transform: translateY(-3px);
        }
        
        .card-header {
            background-color: #3498db;
            color: white;
            border-radius: 10px 10px 0 0 !important;
            padding: 15px 20px;
            font-weight: 600;
            border-bottom: none;
        }
        
        /* Welcome banner */
        .welcome-banner {
            background: linear-gradient(135deg, #3498db, #2c3e50);
            color: white;
            padding: 25px;
            border-radius: 10px;
            margin-bottom: 25px;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        
        .welcome-banner h2 {
            font-weight: 600;
            margin-bottom: 10px;
        }
        
        /* Stats cards */
        .stats-card {
            text-align: center;
            padding: 5px;
            border-radius: 10px;
            transition: all 0.3s;
        }
        
        .stats-card .card-body {
            padding: 25px 15px;
        }
        
        .stats-icon {
            font-size: 3rem;
            margin-bottom: 15px;
            background-color: rgba(0, 0, 0, 0.05);
            width: 80px;
            height: 80px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        
        .patients { 
            color: #2ecc71; 
        }
        
        .patients-card {
            border-bottom: 4px solid #2ecc71;
        }
        
        .referrable { 
            color: #e74c3c; 
        }
        
        .referrable-card {
            border-bottom: 4px solid #e74c3c;
        }
        
        .non-referrable { 
            color: #f39c12; 
        }
        
        .non-referrable-card {
            border-bottom: 4px solid #f39c12;
        }
        
        .stats-card h3 {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 5px;
        }
        
        .stats-card h5 {
            color: #6c757d;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        /* Patient images */
        .patient-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
            border: 3px solid #fff;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        
        /* Alerts */
        .alert {
            border-radius: 10px;
            padding: 15px;
            margin-bottom: 20px;
            border: none;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        
        .alert-success {
            background-color: rgba(46, 204, 113, 0.1);
            color: #1e7b34;
            border-left: 4px solid #2ecc71;
        }
        
        .alert-warning {
            background-color: rgba(231, 76, 60, 0.1);
            color: #a82315;
            border-left: 4px solid #e74c3c;
        }
        
        /* Tables */
        .table {
            border-collapse: separate;
            border-spacing: 0;
        }
        
        .table th {
            background-color: #f8f9fa;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            padding: 12px 15px;
            border-top: none;
            border-bottom: 2px solid #e9ecef;
        }
        
        .table td {
            padding: 15px;
            vertical-align: middle;
        }
        
        /* Patient row styles */
        .registered-by-you {
            background-color: rgba(52, 152, 219, 0.05);
            border-left: 4px solid #3498db;
        }
        
        /* Badges */
        .badge {
            padding: 6px 10px;
            font-weight: 500;
            border-radius: 6px;
        }
        
        /* Buttons */
        .btn {
            border-radius: 5px;
            padding: 8px 16px;
            font-weight: 500;
            transition: all 0.2s;
        }
        
        .btn-sm {
            padding: 5px 10px;
            font-size: 0.82rem;
        }
        
        .btn-primary {
            background-color: #3498db;
            border-color: #3498db;
        }
        
        .btn-primary:hover {
            background-color: #2980b9;
            border-color: #2980b9;
        }
        
        .btn-success {
            background-color: #2ecc71;
            border-color: #2ecc71;
        }
        
        .btn-success:hover {
            background-color: #27ae60;
            border-color: #27ae60;
        }
        
        .btn-info {
            background-color: #3498db;
            border-color: #3498db;
            color: white;
        }
        
        .btn-info:hover {
            background-color: #2980b9;
            border-color: #2980b9;
            color: white;
        }
        
        .btn-light {
            background-color: #f8f9fa;
            border-color: #e9ecef;
            color: #495057;
        }
        
        .btn-light:hover {
            background-color: #e9ecef;
            border-color: #dee2e6;
            color: #212529;
        }
        
        .btn-outline-primary {
            color: #3498db;
            border-color: #3498db;
        }
        
        .btn-outline-primary:hover {
            background-color: #3498db;
            border-color: #3498db;
        }
        
        /* Mobile styles */
        @media (max-width: 767.98px) {
            .sidebar {
                position: static;
                width: 100%;
                margin-bottom: 20px;
            }
            
            .content-area {
                margin-left: 0;
                padding: 15px;
            }
            
            .welcome-banner {
                padding: 15px;
            }
            
            .welcome-banner h2 {
                font-size: 1.5rem;
            }
            
            .stats-card h3 {
                font-size: 1.8rem;
            }
            
            .stats-icon {
                font-size: 2.2rem;
                width: 60px;
                height: 60px;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block sidebar collapse">
                <div class="sidebar-header">
                    <i class="fas fa-hospital text-light fa-3x mb-3"></i>
                    <h5 class="text-light m-0">Patient Management System</h5>
                </div>
                <div class="position-sticky">
                    <ul class="nav flex-column mt-3">
                        <li class="nav-item">
                            <a class="sidebar-link active" href="${pageContext.request.contextPath}/nurse/dashboard">
                                <i class="fas fa-tachometer-alt"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/nurse/patient-registration">
                                <i class="fas fa-user-plus"></i>Register Patient
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/nurse/patients">
                                <i class="fas fa-procedures"></i>My Patients
                            </a>
                        </li>
                        <li class="nav-item mt-4">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt"></i>Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-area">
                <!-- Top Navbar for mobile -->
                <nav class="navbar navbar-expand-lg navbar-light bg-white mb-4 shadow-sm rounded d-md-none">
                    <div class="container-fluid">
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target=".sidebar">
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
                    <div class="alert alert-success">
                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                    </div>
                </c:if>
                
                <!-- Error message if present -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-warning">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    </div>
                </c:if>
                
                <!-- Welcome message -->
                <div class="welcome-banner">
                    <h2><i class="fas fa-user-nurse me-2"></i>Welcome, ${nurse.firstName} ${nurse.lastName}!</h2>
                    <p class="mb-0">You are logged in as a nurse from ${nurse.healthCenter} health center.</p>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-4">
                        <div class="card stats-card patients-card h-100">
                            <div class="card-body">
                                <div class="stats-icon patients">
                                    <i class="fas fa-users"></i>
                                </div>
                                <h3>${patientCount}</h3>
                                <h5>Total Patients</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stats-card referrable-card h-100">
                            <div class="card-body">
                                <div class="stats-icon referrable">
                                    <i class="fas fa-hospital-user"></i>
                                </div>
                                <h3>${referrableCount}</h3>
                                <h5>Referrable Cases</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stats-card non-referrable-card h-100">
                            <div class="card-body">
                                <div class="stats-icon non-referrable">
                                    <i class="fas fa-user-check"></i>
                                </div>
                                <h3>${nonReferrableCount}</h3>
                                <h5>Non-Referrable Cases</h5>
                            </div>
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
                                        Patients You've Registered
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                            <a href="${pageContext.request.contextPath}/nurse/patient-registration" class="btn btn-light btn-sm">
                                <i class="fas fa-plus me-1"></i>Register New Patient
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty registeredPatients}">
                                <div class="text-center py-5">
                                    <i class="fas fa-user-plus text-muted fa-4x mb-3"></i>
                                    <p class="text-center text-muted h5">No patients registered yet</p>
                                    <p class="text-center text-muted">Start by registering your first patient</p>
                                </div>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Photo</th>
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
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty patient.profileImage}">
                                                                <img src="${pageContext.request.contextPath}/${patient.profileImage}" class="patient-image" alt="Patient Photo">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${pageContext.request.contextPath}/images/default-avatar.png" class="patient-image" alt="Default Photo">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${patient.patientID}</td>
                                                    <td><strong>${patient.firstName} ${patient.lastName}</strong></td>
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
                                                            <span class="badge bg-primary mt-1">Registered by you</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/nurse/edit-patient?id=${patient.patientID}" class="btn btn-sm btn-primary mb-1">
                                                            <i class="fas fa-edit me-1"></i>Edit
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/nurse/view-patient?id=${patient.patientID}" class="btn btn-sm btn-info mb-1">
                                                            <i class="fas fa-eye me-1"></i>View
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/nurse/create-diagnosis?patientId=${patient.patientID}" class="btn btn-sm btn-success mb-1">
                                                            <i class="fas fa-stethoscope me-1"></i>Diagnose
                                                        </a>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <c:if test="${patientCount > 10}">
                                    <div class="text-center mt-4">
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
</body>
</html> 