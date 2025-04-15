<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Doctor Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .navbar {
            background-color: #27ae60;
        }
        .card-header {
            background-color: #27ae60;
            color: white;
        }
        .welcome-banner {
            background-color: #27ae60;
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
        .pending { color: #f39c12; }
        .confirmed { color: #2980b9; }
        .badge-pending { background-color: #f39c12; }
        .badge-confirmed { background-color: #2980b9; }
        .alert-warning {
            background-color: #f8d7da;
            color: #721c24;
            border-color: #f5c6cb;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 4px;
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/doctor/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/doctor/diagnose">
                            <i class="fas fa-stethoscope me-1"></i>Diagnose Patients
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
        <!-- Error message if present -->
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-warning">
                <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
            </div>
        </c:if>
        
        <!-- Welcome message -->
        <div class="welcome-banner">
            <h2><i class="fas fa-user-md me-2"></i>Welcome, Dr. ${doctor.name}!</h2>
            <p>You are logged in as a doctor
                <c:if test="${not empty doctor.specialization}">
                    specializing in ${doctor.specialization}
                </c:if>
            </p>
        </div>

        <!-- Statistics Cards -->
        <div class="row mb-4">
            <div class="col-md-6">
                <div class="card stats-card h-100">
                    <div class="card-body">
                        <i class="fas fa-clock stats-icon pending"></i>
                        <h3>${pendingCasesCount}</h3>
                        <h5>Pending Cases</h5>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card stats-card h-100">
                    <div class="card-body">
                        <i class="fas fa-check-double stats-icon confirmed"></i>
                        <h3>${confirmedCasesCount}</h3>
                        <h5>Confirmed Cases</h5>
                    </div>
                </div>
            </div>
        </div>

        <!-- Pending Cases -->
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-clock me-1"></i>Pending Cases
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty pendingCases}">
                        <p class="text-center text-muted">No pending cases at the moment</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Patient Name</th>
                                        <th>Age</th>
                                        <th>Gender</th>
                                        <th>Symptoms</th>
                                        <th>Registered By</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${pendingCases}" var="patientCase">
                                        <tr>
                                            <td>${patientCase.patientID}</td>
                                            <td>${patientCase.patientName}</td>
                                            <td>${patientCase.patientAge}</td>
                                            <td>${patientCase.patientGender}</td>
                                            <td>${patientCase.symptoms}</td>
                                            <td>${patientCase.registeredByNurse}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/doctor/diagnose?id=${patientCase.patientID}" class="btn btn-sm btn-warning">
                                                    <i class="fas fa-stethoscope"></i> Diagnose
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

        <!-- Confirmed Cases -->
        <div class="card mb-4">
            <div class="card-header">
                <i class="fas fa-check-double me-1"></i>Confirmed Cases
            </div>
            <div class="card-body">
                <c:choose>
                    <c:when test="${empty confirmedCases}">
                        <p class="text-center text-muted">No confirmed cases yet</p>
                    </c:when>
                    <c:otherwise>
                        <div class="table-responsive">
                            <table class="table table-striped table-hover">
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>Patient Name</th>
                                        <th>Age</th>
                                        <th>Diagnosis</th>
                                        <th>Treatment</th>
                                        <th>Diagnosed On</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach items="${confirmedCases}" var="patientCase">
                                        <tr>
                                            <td>${patientCase.patientID}</td>
                                            <td>${patientCase.patientName}</td>
                                            <td>${patientCase.patientAge}</td>
                                            <td>${patientCase.diagnosis}</td>
                                            <td>${patientCase.treatment}</td>
                                            <td>${patientCase.diagnosisDate}</td>
                                            <td>
                                                <a href="${pageContext.request.contextPath}/doctor/view-case?id=${patientCase.patientID}" class="btn btn-sm btn-info">
                                                    <i class="fas fa-eye"></i> View
                                                </a>
                                                <a href="${pageContext.request.contextPath}/doctor/update-case?id=${patientCase.patientID}" class="btn btn-sm btn-primary">
                                                    <i class="fas fa-edit"></i> Update
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
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">&copy; 2025 Patient Management System | Doctor Dashboard</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 