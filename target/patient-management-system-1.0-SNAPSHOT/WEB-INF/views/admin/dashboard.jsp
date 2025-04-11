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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <!-- Navigation bar -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/doctors">
                            <i class="fas fa-user-md me-1"></i>Doctors
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/nurses">
                            <i class="fas fa-user-nurse me-1"></i>Nurses
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/patients">
                            <i class="fas fa-hospital-user me-1"></i>Patients
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" role="button" data-bs-toggle="dropdown">
                            <i class="fas fa-user-shield me-1"></i>${user.username}
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/profile">
                                    <i class="fas fa-id-card me-1"></i>Profile
                                </a>
                            </li>
                            <li>
                                <hr class="dropdown-divider">
                            </li>
                            <li>
                                <a class="dropdown-item" href="${pageContext.request.contextPath}/logout">
                                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                                </a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main content -->
    <div class="container-fluid mt-4">
        <div class="row">
            <div class="col-md-12 mb-4">
                <div class="alert alert-success">
                    <h4><i class="fas fa-user-check me-2"></i>Welcome, ${user.username}!</h4>
                    <p>You are logged in as an administrator. You can manage users, view reports, and more.</p>
                </div>
            </div>
        </div>

        <!-- Statistics cards -->
        <div class="row">
            <div class="col-md-3 mb-4">
                <div class="card bg-primary text-white h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase">Total Doctors</h6>
                                <h2 class="mb-0">${doctorCount}</h2>
                            </div>
                            <i class="fas fa-user-md fa-3x opacity-50"></i>
                        </div>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        <a href="${pageContext.request.contextPath}/admin/doctors" class="text-white text-decoration-none">View Details</a>
                        <i class="fas fa-angle-right text-white"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="card bg-success text-white h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase">Total Nurses</h6>
                                <h2 class="mb-0">${nurseCount}</h2>
                            </div>
                            <i class="fas fa-user-nurse fa-3x opacity-50"></i>
                        </div>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        <a href="${pageContext.request.contextPath}/admin/nurses" class="text-white text-decoration-none">View Details</a>
                        <i class="fas fa-angle-right text-white"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="card bg-warning text-white h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase">Total Patients</h6>
                                <h2 class="mb-0">${patientCount}</h2>
                            </div>
                            <i class="fas fa-hospital-user fa-3x opacity-50"></i>
                        </div>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        <a href="${pageContext.request.contextPath}/admin/patients" class="text-white text-decoration-none">View Details</a>
                        <i class="fas fa-angle-right text-white"></i>
                    </div>
                </div>
            </div>

            <div class="col-md-3 mb-4">
                <div class="card bg-danger text-white h-100">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center">
                            <div>
                                <h6 class="text-uppercase">System Users</h6>
                                <h2 class="mb-0">${userCount}</h2>
                            </div>
                            <i class="fas fa-users fa-3x opacity-50"></i>
                        </div>
                    </div>
                    <div class="card-footer d-flex align-items-center justify-content-between">
                        <a href="${pageContext.request.contextPath}/admin/users" class="text-white text-decoration-none">View Details</a>
                        <i class="fas fa-angle-right text-white"></i>
                    </div>
                </div>
            </div>
        </div>

        <!-- Doctors List -->
        <div class="row mt-4">
            <div class="col-md-12 mb-4">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <i class="fas fa-user-md me-1"></i>Registered Doctors
                    </div>
                    <div class="card-body">
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
                                                <th>Action</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${doctors}" var="doctor">
                                                <tr>
                                                    <td>${doctor.doctorID}</td>
                                                    <td>${doctor.firstName} ${doctor.lastName}</td>
                                                    <td>${doctor.specialization}</td>
                                                    <td>${doctor.contactNumber}</td>
                                                    <td>${doctor.email}</td>
                                                    <td>
                                                        <div class="btn-group btn-group-sm">
                                                            <a href="${pageContext.request.contextPath}/admin/doctor/view?id=${doctor.doctorID}" class="btn btn-info">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/admin/doctor/edit?id=${doctor.doctorID}" class="btn btn-warning">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/admin/doctor/delete?id=${doctor.doctorID}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this doctor?')">
                                                                <i class="fas fa-trash"></i>
                                                            </a>
                                                        </div>
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
        </div>

        <!-- Nurses List -->
        <div class="row mt-4">
            <div class="col-md-12 mb-4">
                <div class="card">
                    <div class="card-header bg-success text-white">
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
                                                <th>Action</th>
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
                                                    <td>
                                                        <div class="btn-group btn-group-sm">
                                                            <a href="${pageContext.request.contextPath}/admin/nurse/view?id=${nurse.nurseID}" class="btn btn-info">
                                                                <i class="fas fa-eye"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/admin/nurse/edit?id=${nurse.nurseID}" class="btn btn-warning">
                                                                <i class="fas fa-edit"></i>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/admin/nurse/delete?id=${nurse.nurseID}" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this nurse?')">
                                                                <i class="fas fa-trash"></i>
                                                            </a>
                                                        </div>
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
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">&copy; 2025 Patient Management System | Admin Dashboard</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 