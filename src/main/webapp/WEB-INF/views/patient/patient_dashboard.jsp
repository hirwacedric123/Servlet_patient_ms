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
        .diagnosis-card {
            transition: all 0.3s ease;
            margin-bottom: 20px;
            border: none;
        }
        .diagnosis-card:hover {
            transform: translateY(-5px);
        }
        .diagnosis-card.pending {
            border-left: 4px solid #ffc107;
        }
        .diagnosis-card.completed {
            border-left: 4px solid #28a745;
        }
        .status-badge {
            position: absolute;
            top: 10px;
            right: 10px;
        }
        .patient-info-text {
            color: #495057;
        }
        .health-widget {
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 20px 10px;
            border-radius: 10px;
            transition: all 0.3s ease;
            min-height: 180px;
        }
        .health-widget:hover {
            transform: translateY(-5px);
        }
        .health-widget-icon {
            font-size: 3rem;
            margin-bottom: 15px;
        }
        .health-widget.referrable {
            background: linear-gradient(to bottom right, #ff7e7e, #ef5350);
            color: white;
        }
        .health-widget.not-referrable {
            background: linear-gradient(to bottom right, #a8e063, #56ab2f);
            color: white;
        }
        .health-widget.pending {
            background: linear-gradient(to bottom right, #ffeb3b, #ffa000);
            color: white;
        }
        .timeline {
            position: relative;
            padding-left: 30px;
        }
        .timeline:before {
            content: '';
            position: absolute;
            left: 0;
            top: 10px;
            bottom: 0;
            width: 2px;
            background: #e9ecef;
        }
        .timeline-item {
            position: relative;
            padding-bottom: 20px;
        }
        .timeline-item:before {
            content: '';
            position: absolute;
            left: -30px;
            top: 0;
            width: 12px;
            height: 12px;
            border-radius: 50%;
            background: #007bff;
        }
        .timeline-date {
            font-size: 0.8rem;
            color: #6c757d;
        }
        .animated-card {
            animation: fadeIn 0.5s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                <div class="position-sticky pt-3">
                    <div class="text-center mb-4">
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
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/patient/diagnoses">
                                <i class="fas fa-stethoscope me-2"></i>My Diagnoses
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
                            <div class="dropdown">
                                <a class="dropdown-toggle text-decoration-none text-dark" href="#" role="button" data-bs-toggle="dropdown">
                                    <i class="fas fa-user-circle me-1"></i>${patient.firstName} ${patient.lastName}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/patient/profile">
                                            <i class="fas fa-id-card me-1"></i>Profile
                                        </a>
                                    </li>
                                    <li><hr class="dropdown-divider"></li>
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                            <i class="fas fa-sign-out-alt me-1"></i>Logout
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Error message if present -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-warning animated-card">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    </div>
                </c:if>

                <!-- Welcome message -->
                <div class="welcome-banner mb-4 animated-card">
                    <div class="row align-items-center">
                        <div class="col-md-8">
                            <h2><i class="fas fa-user me-2"></i>Welcome, ${patient.firstName} ${patient.lastName}!</h2>
                            <p class="mb-0">Here's your health information at a glance.</p>
                        </div>
                        <div class="col-md-4 text-md-end">
                            <c:if test="${not empty patient.pImageLink}">
                                <img src="${pageContext.request.contextPath}/${patient.pImageLink}" 
                                     alt="Patient Photo" class="img-thumbnail rounded-circle" 
                                     style="width: 100px; height: 100px; object-fit: cover;">
                            </c:if>
                            <c:if test="${empty patient.pImageLink}">
                                <div class="text-center">
                                    <i class="fas fa-user-circle text-secondary" style="font-size: 5rem;"></i>
                                </div>
                            </c:if>
                        </div>
                    </div>
                </div>

                <!-- Health Status Widgets -->
                <div class="row mb-4">
                    <div class="col-md-4 mb-4">
                        <div class="health-widget ${hasPendingDiagnosis ? 'pending' : 'not-referrable'} shadow-sm rounded animated-card">
                            <i class="fas ${hasPendingDiagnosis ? 'fa-clock' : 'fa-check-circle'} health-widget-icon"></i>
                            <h3>${hasPendingDiagnosis ? 'Pending' : 'Completed'}</h3>
                            <h5>Diagnostic Status</h5>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-4">
                        <div class="card h-100 shadow-sm animated-card">
                            <div class="card-body text-center">
                                <i class="fas fa-calendar-alt health-widget-icon text-primary"></i>
                                <h3>${diagnosesCount}</h3>
                                <h5>Total Diagnoses</h5>
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-md-4 mb-4">
                        <div class="health-widget ${diagnoses[0].isReferrable ? 'referrable' : 'not-referrable'} shadow-sm rounded animated-card">
                            <i class="fas ${diagnoses[0].isReferrable ? 'fa-exclamation-triangle' : 'fa-shield-alt'} health-widget-icon"></i>
                            <h3>${diagnoses[0].isReferrable ? 'Referrable' : 'Not Referrable'}</h3>
                            <h5>Current Status</h5>
                        </div>
                    </div>
                </div>

                <!-- Patient Information Card -->
                <div class="card mb-4 shadow-sm animated-card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-info-circle me-2"></i>Patient Information</h5>
                    </div>
                    <div class="card-body">
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
                    </div>
                </div>

                <!-- Recent Diagnoses -->
                <div class="card mb-4 shadow-sm animated-card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-heartbeat me-2"></i>Recent Diagnoses</h5>
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
                                <div class="timeline">
                                    <c:forEach var="diagnosis" items="${diagnoses}">
                                        <div class="timeline-item">
                                            <div class="card diagnosis-card ${diagnosis.isPending ? 'pending' : 'completed'} shadow-sm">
                                                <div class="card-body">
                                                    <span class="status-badge badge bg-${diagnosis.isPending ? 'warning' : 'success'}">
                                                        ${diagnosis.isPending ? 'Pending' : 'Completed'}
                                                    </span>
                                                    <h5 class="card-title">
                                                        <i class="fas ${diagnosis.isReferrable ? 'fa-exclamation-triangle text-danger' : 'fa-check-circle text-success'} me-2"></i>
                                                        ${diagnosis.diagnoStatus}
                                                    </h5>
                                                    <p class="timeline-date">
                                                        <i class="far fa-calendar-alt me-1"></i>
                                                        <fmt:formatDate value="${diagnosis.createdDate}" pattern="MMMM dd, yyyy" />
                                                        <c:if test="${diagnosis.updatedDate != diagnosis.createdDate}">
                                                            (Updated: <fmt:formatDate value="${diagnosis.updatedDate}" pattern="MMMM dd, yyyy" />)
                                                        </c:if>
                                                    </p>
                                                    <hr>
                                                    <p><strong>Result:</strong> ${diagnosis.result}</p>
                                                    <p><strong>Diagnosed by:</strong> 
                                                        <c:choose>
                                                            <c:when test="${not empty diagnosis.doctorName}">
                                                                Dr. ${diagnosis.doctorName}
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="text-muted">Pending doctor review</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </p>
                                                    <p><strong>Registered by:</strong> Nurse ${diagnosis.nurseName}</p>
                                                </div>
                                            </div>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Health Tips Section -->
                <div class="card mb-4 shadow-sm animated-card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-lightbulb me-2"></i>Health Tips</h5>
                    </div>
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h5 class="card-title"><i class="fas fa-heart text-danger me-2"></i>Stay Active</h5>
                                        <p class="card-text">Aim for at least 30 minutes of physical activity daily to maintain good cardiovascular health.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h5 class="card-title"><i class="fas fa-apple-alt text-success me-2"></i>Healthy Diet</h5>
                                        <p class="card-text">Consume a balanced diet rich in fruits, vegetables, whole grains, and lean proteins.</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4 mb-3">
                                <div class="card h-100">
                                    <div class="card-body">
                                        <h5 class="card-title"><i class="fas fa-bed text-primary me-2"></i>Adequate Sleep</h5>
                                        <p class="card-text">Aim for 7-9 hours of quality sleep each night to support overall health and wellbeing.</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
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