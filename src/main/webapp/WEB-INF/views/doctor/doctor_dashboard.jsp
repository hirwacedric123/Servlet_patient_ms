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
        .referrable { color: #e74c3c; }
        .nurses { color: #9b59b6; }
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
        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            padding: 48px 0 0;
            box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
            background-color: #27ae60;
        }
        .sidebar-link {
            display: block;
            padding: 0.5rem 1rem;
            color: white;
            text-decoration: none;
            transition: all 0.3s;
        }
        .sidebar-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
        }
        .sidebar-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
        }
        .content-area {
            margin-left: 250px;
            padding: 20px;
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
                    <h2><i class="fas fa-user-md me-2"></i>Welcome, Dr. ${doctor.firstName} ${doctor.lastName}!</h2>
                    <p>You are logged in as a doctor specializing in ${doctor.specialization} at ${doctor.hospitalName}</p>
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