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
        .referrable { color: #e74c3c; }
        .not-referrable { color: #2ecc71; }
        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            padding: 48px 0 0;
            box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
            background-color: #3498db;
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
                                <i class="fas fa-user-nurse me-1"></i>${nurse.firstName} ${nurse.lastName}
                            </div>
                        </div>
                    </div>
                </nav>
                
                <!-- Welcome message -->
                <div class="welcome-banner">
                    <h2><i class="fas fa-user-nurse me-2"></i>Welcome, ${nurse.firstName} ${nurse.lastName}!</h2>
                    <p>You are logged in as a nurse in the ${nurse.department} department.</p>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-4">
                    <div class="col-md-6">
                        <div class="card stats-card h-100">
                            <div class="card-body">
                                <i class="fas fa-exclamation-triangle stats-icon referrable"></i>
                                <h3>${referrableCount}</h3>
                                <h5>Referrable Cases</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="card stats-card h-100">
                            <div class="card-body">
                                <i class="fas fa-check-circle stats-icon not-referrable"></i>
                                <h3>${notReferrableCount}</h3>
                                <h5>Not Referrable Cases</h5>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Patients List -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-hospital-user me-1"></i>Your Registered Patients
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty registeredPatients}">
                                <p class="text-center text-muted">You haven't registered any patients yet</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Age</th>
                                                <th>Gender</th>
                                                <th>Contact</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${registeredPatients}" var="patient">
                                                <tr>
                                                    <td>${patient.patientID}</td>
                                                    <td>${patient.firstName} ${patient.lastName}</td>
                                                    <td>${patient.age}</td>
                                                    <td>${patient.gender}</td>
                                                    <td>${patient.contactNumber}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${patient.referrable}">
                                                                <span class="badge bg-danger">Referrable</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">Not Referrable</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>
                                                        <a href="${pageContext.request.contextPath}/nurse/view-patient?id=${patient.patientID}" class="btn btn-sm btn-info">
                                                            <i class="fas fa-eye"></i>
                                                        </a>
                                                        <a href="${pageContext.request.contextPath}/nurse/edit-patient?id=${patient.patientID}" class="btn btn-sm btn-primary">
                                                            <i class="fas fa-edit"></i>
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
            </main>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">&copy; 2025 Patient Management System | Nurse Dashboard</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 