<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .card-header {
            background-color: #2c3e50;
            color: white;
        }
        .welcome-banner {
            background-color: #2c3e50;
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
        .doctor-icon { color: #3498db; }
        .nurse-icon { color: #2ecc71; }
        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            padding: 48px 0 0;
            box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
            background-color: #2c3e50;
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
                            <a class="sidebar-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/admin/register-doctor" id="register-doctor-btn">
                                <i class="fas fa-user-md me-2"></i>Register Doctor
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
                                <i class="fas fa-user-shield me-1"></i>Admin: ${user.username}
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Welcome message -->
                <div class="welcome-banner">
                    <h2><i class="fas fa-user-check me-2"></i>Welcome, ${user.username}!</h2>
                    <p>You are logged in as an administrator. Here's an overview of your system.</p>
                </div>

                <!-- Statistics Overview -->
                <div class="row mb-4">
                    <div class="col-md-12 mb-4">
                        <div class="card">
                            <div class="card-header">
                                <i class="fas fa-chart-bar me-1"></i>Diagnosis Cases Statistics
                            </div>
                            <div class="card-body">
                                <h5 class="card-title">Cases Registered by Medical Staff</h5>
                                <div class="row mt-4">
                                    <!-- Doctors Statistics -->
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header">
                                                <i class="fas fa-user-md me-1"></i>Cases by Doctor
                                            </div>
                                            <div class="card-body">
                                                <c:choose>
                                                    <c:when test="${empty doctorCasesStats}">
                                                        <p class="text-center text-muted">No diagnosis cases registered by doctors yet</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="table-responsive">
                                                            <table class="table table-striped table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Doctor</th>
                                                                        <th>Hospital</th>
                                                                        <th>Total Cases</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach items="${doctorCasesStats}" var="stats">
                                                                        <tr>
                                                                            <td>${stats.doctorName}</td>
                                                                            <td>${stats.hospitalName}</td>
                                                                            <td><span class="badge bg-primary">${stats.totalCases}</span></td>
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
                                    
                                    <!-- Nurses Statistics -->
                                    <div class="col-md-6">
                                        <div class="card">
                                            <div class="card-header">
                                                <i class="fas fa-user-nurse me-1"></i>Cases by Nurse
                                            </div>
                                            <div class="card-body">
                                                <c:choose>
                                                    <c:when test="${empty nurseCasesStats}">
                                                        <p class="text-center text-muted">No diagnosis cases registered by nurses yet</p>
                                                    </c:when>
                                                    <c:otherwise>
                                                        <div class="table-responsive">
                                                            <table class="table table-striped table-hover">
                                                                <thead>
                                                                    <tr>
                                                                        <th>Nurse</th>
                                                                        <th>Health Center</th>
                                                                        <th>Total Cases</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                                    <c:forEach items="${nurseCasesStats}" var="stats">
                                                                        <tr>
                                                                            <td>${stats.nurseName}</td>
                                                                            <td>${stats.healthCenter}</td>
                                                                            <td><span class="badge bg-success">${stats.totalCases}</span></td>
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
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Doctors List -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-user-md me-1"></i>Registered Doctors
                    </div>
                    <div class="card-body">
                        <div class="mb-3 text-end">
                            <a href="${pageContext.request.contextPath}/admin/register-doctor" class="btn btn-primary">
                                <i class="fas fa-plus me-1"></i>Register New Doctor
                            </a>
                        </div>
                        <c:choose>
                            <c:when test="${empty doctors}">
                                <p class="text-center text-muted">No doctors registered yet</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Specialization</th>
                                                <th>Contact</th>
                                                <th>Email</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${doctors}" var="doctor">
                                                <tr>
                                                    <td>${doctor.doctorID}</td>
                                                    <td>${doctor.name}</td>
                                                    <td>${doctor.specialization}</td>
                                                    <td>${doctor.contactNumber}</td>
                                                    <td>${doctor.email}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>

                <!-- Nurses List -->
                <div class="card mb-4">
                    <div class="card-header">
                        <i class="fas fa-user-nurse me-1"></i>Registered Nurses
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty nurses}">
                                <p class="text-center text-muted">No nurses registered yet</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th>ID</th>
                                                <th>Name</th>
                                                <th>Department</th>
                                                <th>Contact</th>
                                                <th>Email</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${nurses}" var="nurse">
                                                <tr>
                                                    <td>${nurse.nurseID}</td>
                                                    <td>${nurse.firstName} ${nurse.lastName}</td>
                                                    <td>${nurse.department}</td>
                                                    <td>${nurse.contactNumber}</td>
                                                    <td>${nurse.email}</td>
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
        <p class="mb-0">&copy; 2025 Patient Management System | Admin Dashboard</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 