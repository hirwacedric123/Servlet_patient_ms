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
                            <a class="sidebar-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/admin/doctors">
                                <i class="fas fa-user-md me-2"></i>Doctors
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/admin/nurses">
                                <i class="fas fa-user-nurse me-2"></i>Nurses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/admin/patients">
                                <i class="fas fa-hospital-user me-2"></i>Patients
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users me-2"></i>Users
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
                                    <i class="fas fa-user-shield me-1"></i>${user.username}
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end">
                                    <li>
                                        <a class="dropdown-item" href="${pageContext.request.contextPath}/admin/profile">
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

                <!-- Welcome message -->
                <div class="welcome-banner mb-4">
                    <h2><i class="fas fa-user-check me-2"></i>Welcome, ${user.username}!</h2>
                    <p class="mb-0">You are logged in as an administrator. Here's an overview of your system.</p>
                </div>

                <!-- Statistics cards -->
                <div class="row mb-4">
                    <div class="col-md-3 mb-4">
                        <div class="card dashboard-card shadow-sm h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-user-md dashboard-icon text-primary"></i>
                                <h6 class="text-uppercase fw-bold">Total Doctors</h6>
                                <h2 class="mb-0 display-5">${doctorCount}</h2>
                                <a href="${pageContext.request.contextPath}/admin/doctors" class="btn btn-sm btn-outline-primary mt-3">
                                    View Details <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="card dashboard-card shadow-sm h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-user-nurse dashboard-icon text-success"></i>
                                <h6 class="text-uppercase fw-bold">Total Nurses</h6>
                                <h2 class="mb-0 display-5">${nurseCount}</h2>
                                <a href="${pageContext.request.contextPath}/admin/nurses" class="btn btn-sm btn-outline-success mt-3">
                                    View Details <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="card dashboard-card shadow-sm h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-hospital-user dashboard-icon text-warning"></i>
                                <h6 class="text-uppercase fw-bold">Total Patients</h6>
                                <h2 class="mb-0 display-5">${patientCount}</h2>
                                <a href="${pageContext.request.contextPath}/admin/patients" class="btn btn-sm btn-outline-warning mt-3">
                                    View Details <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                    <div class="col-md-3 mb-4">
                        <div class="card dashboard-card shadow-sm h-100">
                            <div class="card-body text-center">
                                <i class="fas fa-users dashboard-icon text-danger"></i>
                                <h6 class="text-uppercase fw-bold">System Users</h6>
                                <h2 class="mb-0 display-5">${userCount}</h2>
                                <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-sm btn-outline-danger mt-3">
                                    View Details <i class="fas fa-arrow-right ms-1"></i>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Recent Activities -->
                <div class="card shadow-sm mb-4">
                    <div class="card-header">
                        <h5 class="mb-0"><i class="fas fa-history me-2"></i>Recent Activities</h5>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty recentActivities}">
                                <p class="text-center text-muted">No recent activities to display</p>
                            </c:when>
                            <c:otherwise>
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>User</th>
                                                <th>Activity</th>
                                                <th>Date & Time</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${recentActivities}" var="activity">
                                                <tr>
                                                    <td>${activity.user}</td>
                                                    <td>${activity.description}</td>
                                                    <td>${activity.timestamp}</td>
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
    <footer class="bg-dark text-white text-center py-3 mt-2">
        <p class="mb-0">&copy; 2025 Patient Management System | Admin Dashboard</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 