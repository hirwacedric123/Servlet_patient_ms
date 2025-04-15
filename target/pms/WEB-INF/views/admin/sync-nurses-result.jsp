<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Sync Nurses - Result</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .navbar {
            background-color: #3498db;
        }
        .card-header {
            background-color: #3498db;
            color: white;
        }
        .success-count {
            color: #28a745;
        }
        .skipped-count {
            color: #ffc107;
        }
        .total-count {
            color: #17a2b8;
        }
    </style>
</head>
<body>
    <!-- Navigation bar -->
    <nav class="navbar navbar-expand-lg navbar-dark">
        <div class="container-fluid">
            <a class="navbar-brand" href="#">
                <i class="fas fa-hospital me-2"></i>Patient Management System - Admin
            </a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                            <i class="fas fa-users me-1"></i>Users
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
        <div class="row mb-4">
            <div class="col-12">
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Sync Nurses</li>
                    </ol>
                </nav>
                
                <div class="card">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-sync me-2"></i>Nurse Synchronization Results</h5>
                    </div>
                    <div class="card-body">
                        <div class="row mb-4">
                            <div class="col-md-4">
                                <div class="card text-center">
                                    <div class="card-body">
                                        <h3 class="success-count">${created}</h3>
                                        <p class="mb-0">Nurse records created</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card text-center">
                                    <div class="card-body">
                                        <h3 class="skipped-count">${skipped}</h3>
                                        <p class="mb-0">Records skipped</p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-4">
                                <div class="card text-center">
                                    <div class="card-body">
                                        <h3 class="total-count">${total}</h3>
                                        <p class="mb-0">Total nurse users</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                        
                        <h5 class="mb-3">Detailed Results:</h5>
                        <div class="list-group">
                            <c:forEach items="${results}" var="result">
                                <div class="list-group-item">
                                    <c:choose>
                                        <c:when test="${result.startsWith('Created')}">
                                            <i class="fas fa-check-circle text-success me-2"></i>
                                        </c:when>
                                        <c:when test="${result.startsWith('Skipped')}">
                                            <i class="fas fa-info-circle text-warning me-2"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-times-circle text-danger me-2"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    ${result}
                                </div>
                            </c:forEach>
                        </div>
                        
                        <div class="mt-4">
                            <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-primary">
                                <i class="fas fa-arrow-left me-2"></i>Return to Dashboard
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">&copy; 2025 Patient Management System | Admin Portal</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 