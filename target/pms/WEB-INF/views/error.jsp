<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Error - Patient Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .error-container {
            max-width: 600px;
            margin: 100px auto;
        }
        .error-icon {
            font-size: 4rem;
            color: #dc3545;
            margin-bottom: 20px;
        }
        .navbar {
            background-color: #3498db;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/">
                            <i class="fas fa-home me-1"></i>Home
                        </a>
                    </li>
                </ul>
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/login">
                            <i class="fas fa-sign-in-alt me-1"></i>Login
                        </a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Error Content -->
    <div class="container error-container text-center">
        <div class="card shadow-lg">
            <div class="card-body p-5">
                <i class="fas fa-exclamation-triangle error-icon"></i>
                <h2 class="mb-4">An Error Occurred</h2>
                
                <c:choose>
                    <c:when test="${not empty errorMessage}">
                        <div class="alert alert-danger">
                            <p>${errorMessage}</p>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="alert alert-danger">
                            <p>An unexpected error has occurred. Please try again later or contact the administrator.</p>
                        </div>
                    </c:otherwise>
                </c:choose>
                
                <div class="mt-4">
                    <c:choose>
                        <c:when test="${not empty sessionScope.user}">
                            <c:choose>
                                <c:when test="${sessionScope.user.userType == 'Admin'}">
                                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary">
                                        <i class="fas fa-home me-2"></i>Return to Dashboard
                                    </a>
                                </c:when>
                                <c:when test="${sessionScope.user.userType == 'Doctor'}">
                                    <a href="${pageContext.request.contextPath}/doctor/dashboard" class="btn btn-primary">
                                        <i class="fas fa-home me-2"></i>Return to Dashboard
                                    </a>
                                </c:when>
                                <c:when test="${sessionScope.user.userType == 'Nurse'}">
                                    <a href="${pageContext.request.contextPath}/nurse/dashboard" class="btn btn-primary">
                                        <i class="fas fa-home me-2"></i>Return to Dashboard
                                    </a>
                                </c:when>
                                <c:when test="${sessionScope.user.userType == 'Patient'}">
                                    <a href="${pageContext.request.contextPath}/patient/dashboard" class="btn btn-primary">
                                        <i class="fas fa-home me-2"></i>Return to Dashboard
                                    </a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                                        <i class="fas fa-sign-in-alt me-2"></i>Go to Login
                                    </a>
                                </c:otherwise>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/login" class="btn btn-primary">
                                <i class="fas fa-sign-in-alt me-2"></i>Go to Login
                            </a>
                        </c:otherwise>
                    </c:choose>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5 fixed-bottom">
        <p class="mb-0">&copy; 2025 Patient Management System</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 