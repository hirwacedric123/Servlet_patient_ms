<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Patient Diagnosis</title>
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
        .patient-info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .btn-primary {
            background-color: #27ae60;
            border-color: #27ae60;
        }
        .btn-primary:hover {
            background-color: #219652;
            border-color: #219652;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/doctor/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link active" href="#">
                            <i class="fas fa-stethoscope me-1"></i>Diagnose Patient
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/doctor/register-nurse">
                            <i class="fas fa-user-nurse me-1"></i>Register Nurse
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
        <div class="card">
            <div class="card-header">
                <h4><i class="fas fa-stethoscope me-2"></i>Patient Diagnosis</h4>
            </div>
            <div class="card-body">
                <!-- Patient Information -->
                <div class="patient-info">
                    <h5>Patient Information</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Name:</strong> ${patient.firstName} ${patient.lastName}</p>
                            <p><strong>Gender:</strong> ${patient.gender}</p>
                            <p><strong>Age:</strong> ${patient.age}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Contact:</strong> ${patient.contactNumber}</p>
                            <p><strong>Email:</strong> ${patient.email}</p>
                            <p><strong>Blood Group:</strong> ${patient.bloodGroup}</p>
                        </div>
                    </div>
                </div>

                <!-- Diagnosis Information -->
                <div class="patient-info">
                    <h5>Diagnosis Information</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Diagnosis ID:</strong> ${diagnosis.diagnosisID}</p>
                            <p><strong>Status:</strong> 
                                <span class="badge bg-${diagnosis.diagnoStatus eq 'Referrable' ? 'danger' : 'success'}">
                                    ${diagnosis.diagnoStatus}
                                </span>
                            </p>
                            <p><strong>Current Result:</strong> ${diagnosis.result}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Referred by Nurse:</strong> ${nurseName}</p>
                            <p><strong>Created Date:</strong> ${diagnosis.createdDate}</p>
                            <p><strong>Last Updated:</strong> ${diagnosis.updatedDate}</p>
                        </div>
                    </div>
                </div>

                <!-- Error Message if present -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger mb-3">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    </div>
                </c:if>

                <!-- Diagnosis Form - Only show if referrable and pending -->
                <c:choose>
                    <c:when test="${diagnosis.diagnoStatus eq 'Referrable' && diagnosis.result eq 'Pending'}">
                        <form action="${pageContext.request.contextPath}/doctor/diagnose" method="post">
                            <input type="hidden" name="diagnosisId" value="${diagnosis.diagnosisID}">
                            
                            <div class="mb-3">
                                <label for="diagnosisResult" class="form-label">Diagnosis Result <span class="text-danger">*</span></label>
                                <textarea class="form-control" id="diagnosisResult" name="diagnosisResult" rows="5" required></textarea>
                                <div class="form-text">Enter your detailed diagnosis and treatment plan for the patient.</div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <a href="${pageContext.request.contextPath}/doctor/dashboard" class="btn btn-secondary me-md-2">
                                    <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                                </a>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-1"></i>Save Diagnosis
                                </button>
                            </div>
                        </form>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-warning mb-3">
                            <i class="fas fa-exclamation-triangle me-2"></i>
                            <c:choose>
                                <c:when test="${diagnosis.diagnoStatus ne 'Referrable'}">
                                    This case is marked as "Not Referrable" and cannot be updated.
                                </c:when>
                                <c:otherwise>
                                    This case has already been diagnosed and cannot be updated again.
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                            <a href="${pageContext.request.contextPath}/doctor/dashboard" class="btn btn-secondary">
                                <i class="fas fa-arrow-left me-1"></i>Back to Dashboard
                            </a>
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>

    <!-- Bootstrap & jQuery JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 