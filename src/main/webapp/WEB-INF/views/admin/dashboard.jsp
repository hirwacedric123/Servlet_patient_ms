<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Dashboard - Patient Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .sidebar {
            min-height: 100vh;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .sidebar .nav-link {
            color: #f8f9fa;
            padding: 0.8rem 1rem;
            border-radius: 0.25rem;
            margin: 0.2rem 0;
        }
        .sidebar .nav-link:hover {
            background-color: rgba(255,255,255,0.1);
        }
        .sidebar .nav-link.active {
            background-color: #0d6efd;
        }
        .stats-card {
            transition: transform 0.3s;
        }
        .stats-card:hover {
            transform: translateY(-5px);
        }
        .welcome-banner {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        .table-container {
            background: white;
            padding: 1.5rem;
            border-radius: 10px;
            box-shadow: 0 0 15px rgba(0,0,0,0.1);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block bg-dark sidebar">
                <div class="position-sticky pt-3">
                    <div class="text-center mb-4">
                        <i class="fas fa-hospital text-light fa-3x mb-2"></i>
                        <h6 class="text-light">Patient Management System</h6>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/doctors">
                                <i class="fas fa-user-md me-2"></i>Manage Doctors
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/nurses">
                                <i class="fas fa-user-nurse me-2"></i>Manage Nurses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/patients">
                                <i class="fas fa-procedures me-2"></i>Manage Patients
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/appointments">
                                <i class="fas fa-calendar-check me-2"></i>Appointments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/departments">
                                <i class="fas fa-hospital-alt me-2"></i>Departments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users-cog me-2"></i>User Management
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/profile">
                                <i class="fas fa-user-circle me-2"></i>Profile
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main content -->
            <div class="col-md-9 col-lg-10 ms-sm-auto px-md-4 py-4">
                <!-- Welcome Banner -->
                <div class="welcome-banner">
                    <h2><i class="fas fa-user-shield me-2"></i>Welcome, ${user.username}!</h2>
                    <p class="mb-0">Manage your hospital system efficiently and effectively.</p>
                </div>

                <!-- Statistics Cards -->
                <div class="row g-4 mb-4">
                    <div class="col-12 col-sm-6 col-xl-3">
                        <div class="card stats-card border-0 shadow">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h6 class="text-muted mb-2">Total Doctors</h6>
                                        <h3 class="mb-0">${doctorCount}</h3>
                                    </div>
                                    <div class="col-auto">
                                        <div class="bg-primary text-white rounded-circle p-3">
                                            <i class="fas fa-user-md fa-fw"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-6 col-xl-3">
                        <div class="card stats-card border-0 shadow">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h6 class="text-muted mb-2">Total Nurses</h6>
                                        <h3 class="mb-0">${nurseCount}</h3>
                                    </div>
                                    <div class="col-auto">
                                        <div class="bg-success text-white rounded-circle p-3">
                                            <i class="fas fa-user-nurse fa-fw"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-6 col-xl-3">
                        <div class="card stats-card border-0 shadow">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h6 class="text-muted mb-2">Total Patients</h6>
                                        <h3 class="mb-0">${patientCount}</h3>
                                    </div>
                                    <div class="col-auto">
                                        <div class="bg-info text-white rounded-circle p-3">
                                            <i class="fas fa-procedures fa-fw"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 col-sm-6 col-xl-3">
                        <div class="card stats-card border-0 shadow">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col">
                                        <h6 class="text-muted mb-2">Total Users</h6>
                                        <h3 class="mb-0">${userCount}</h3>
                                    </div>
                                    <div class="col-auto">
                                        <div class="bg-warning text-white rounded-circle p-3">
                                            <i class="fas fa-users fa-fw"></i>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activity Tables -->
                <div class="row">
                    <!-- Recent Doctors -->
                    <div class="col-12 col-lg-6 mb-4">
                        <div class="table-container">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h5 class="mb-0">Recent Doctors</h5>
                                <a href="${pageContext.request.contextPath}/admin/doctors" class="btn btn-sm btn-primary">View All</a>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Specialization</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${doctors}" var="doctor" end="4">
                                            <tr>
                                                <td>${doctor.name}</td>
                                                <td>${doctor.specialization}</td>
                                                <td>
                                                    <span class="badge bg-success">Active</span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>

                    <!-- Recent Nurses -->
                    <div class="col-12 col-lg-6 mb-4">
                        <div class="table-container">
                            <div class="d-flex justify-content-between align-items-center mb-3">
                                <h5 class="mb-0">Recent Nurses</h5>
                                <a href="${pageContext.request.contextPath}/admin/nurses" class="btn btn-sm btn-primary">View All</a>
                            </div>
                            <div class="table-responsive">
                                <table class="table table-hover">
                                    <thead>
                                        <tr>
                                            <th>Name</th>
                                            <th>Department</th>
                                            <th>Status</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <c:forEach items="${nurses}" var="nurse" end="4">
                                            <tr>
                                                <td>${nurse.name}</td>
                                                <td>${nurse.department}</td>
                                                <td>
                                                    <span class="badge bg-success">Active</span>
                                                </td>
                                            </tr>
                                        </c:forEach>
                                    </tbody>
                                </table>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 