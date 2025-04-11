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
        .navbar {
            background-color: #2c3e50;
        }
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
                        <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
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
        <!-- Welcome message -->
        <div class="welcome-banner">
            <h2><i class="fas fa-user-check me-2"></i>Welcome, ${user.username}!</h2>
            <p>You are logged in as an administrator. Here's an overview of your system.</p>
        </div>

        <!-- Doctors List -->
        <div class="card mb-4">
            <div class="card-header">
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
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">&copy; 2025 Patient Management System | Admin Dashboard</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 