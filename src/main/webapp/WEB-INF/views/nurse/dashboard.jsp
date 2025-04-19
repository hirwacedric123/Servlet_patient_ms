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
    <style>
        .navbar {
            background-color: #3498db;
        }
        .card-header {
            background-color: #3498db;
            color: white;
        }
        .welcome-banner {
            background-color: #3498db;
            color: white;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .stats-card {
            text-align: center;
            margin-bottom: 20px;
        }
        .stats-icon {
            font-size: 2.5rem;
            margin-bottom: 10px;
        }
        .patients { color: #2ecc71; }
        .referrable { color: #e74c3c; }
        .non-referrable { color: #f39c12; }
        .patient-image {
            width: 50px;
            height: 50px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #ddd;
        }
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-color: #c3e6cb;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .alert-warning {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 4px;
        }
        .registered-by-you {
            background-color: rgba(52, 152, 219, 0.2);
            border-left: 4px solid #3498db;
        }
    </style>
</head>
<body>
    <!-- Navigation bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-hospital me-2"></i>Patient Management System
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link active" href="${pageContext.request.contextPath}/nurse/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/nurse/patient-registration">
                            <i class="fas fa-user-plus me-1"></i>Register Patient
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/nurse/patients">
                            <i class="fas fa-procedures me-1"></i>My Patients
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt me-1"></i>Logout
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main content -->
    <div class="container mt-4">
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
            <p>You are logged in as a nurse from ${nurse.healthCenter} health center.</p>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-4">
                <div class="card stats-card h-100">
                    <div class="card-body">
                        <i class="fas fa-users stats-icon patients"></i>
                        <h3>${patientCount}</h3>
                        <h5>Total Patients</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stats-card h-100">
                    <div class="card-body">
                        <i class="fas fa-hospital-user stats-icon referrable"></i>
                        <h3>${referrableCount}</h3>
                        <h5>Referrable Cases</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card stats-card h-100">
                    <div class="card-body">
                        <i class="fas fa-user-check stats-icon non-referrable"></i>
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
                        <p class="text-center text-muted">No patients registered yet</p>
                        <!-- Debug information (will be removed in production) -->
                        <p class="text-center text-muted small">Debug: Empty patients list</p>
                    </c:when>
                    <c:otherwise>
                        <!-- Debug information (will be removed in production) -->
                        <p class="text-center text-muted small">Debug: Found ${registeredPatients.size()} patients</p>
                        
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
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
                                                <a href="${pageContext.request.contextPath}/nurse/edit-patient?id=${patient.patientID}" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-edit"></i> Edit
                                                </a>
                                                <a href="${pageContext.request.contextPath}/nurse/view-patient?id=${patient.patientID}" class="btn btn-sm btn-info">
                                                    <i class="fas fa-eye"></i> View
                                                </a>
                                                <a href="${pageContext.request.contextPath}/nurse/create-diagnosis?patientId=${patient.patientID}" class="btn btn-sm btn-success">
                                                    <i class="fas fa-stethoscope"></i> Diagnose
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                        <c:if test="${patientCount > 10}">
                            <div class="text-center mt-3">
                                <a href="${pageContext.request.contextPath}/nurse/patients" class="btn btn-outline-primary">
                                    View All Patients
                                </a>
                            </div>
                        </c:if>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">&copy; 2025 Patient Management System | Nurse Dashboard</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 