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
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #1abc9c;
            --light-color: #f8f9fa;
            --dark-color: #222;
            --success-color: #2ecc71;
            --warning-color: #f39c12;
            --danger-color: #e74c3c;
            --info-color: #3498db;
        }
        
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f5f7fa;
            color: #333;
            overflow-x: hidden;
        }
        
        .sidebar {
            background: linear-gradient(180deg, var(--primary-color) 0%, #1a252f 100%);
            min-height: 100vh;
            box-shadow: 4px 0 10px rgba(0,0,0,0.1);
            position: fixed;
            top: 0;
            left: 0;
            width: 250px;
            z-index: 100;
            transition: all 0.3s ease;
            padding-top: 1rem;
        }
        
        .sidebar-header {
            padding: 1.5rem 1.5rem 2rem;
            border-bottom: 1px solid rgba(255,255,255,0.1);
            margin-bottom: 1rem;
        }
        
        .sidebar .nav-link {
            color: rgba(255,255,255,0.7);
            padding: 0.75rem 1.5rem;
            border-radius: 0;
            margin: 0.2rem 0;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            font-size: 0.95rem;
            border-left: 4px solid transparent;
        }
        
        .sidebar .nav-link:hover {
            background-color: rgba(255,255,255,0.1);
            color: white;
            border-left-color: rgba(255,255,255,0.5);
        }
        
        .sidebar .nav-link.active {
            background-color: rgba(52, 152, 219, 0.2);
            color: white;
            border-left-color: var(--secondary-color);
        }
        
        .sidebar .nav-link i {
            margin-right: 10px;
            font-size: 1.1rem;
            width: 24px;
            text-align: center;
        }
        
        .main-content {
            margin-left: 250px;
            padding: 2rem;
            transition: all 0.3s ease;
        }
        
        .top-navbar {
            background-color: white;
            box-shadow: 0 2px 10px rgba(0,0,0,0.05);
            padding: 0.8rem 2rem;
            margin-bottom: 2rem;
            border-radius: 10px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .welcome-banner {
            background: linear-gradient(135deg, var(--primary-color) 0%, var(--secondary-color) 100%);
            color: white;
            padding: 2.5rem;
            border-radius: 15px;
            margin-bottom: 2rem;
            position: relative;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
        
        .welcome-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,0 C30,40 70,40 100,0 L100,100 0,100 Z" fill="rgba(255,255,255,0.1)"/></svg>');
            background-size: 100% 100%;
        }
        
        .welcome-banner h2 {
            font-weight: 600;
            margin-bottom: 1rem;
            position: relative;
        }
        
        .welcome-banner p {
            opacity: 0.9;
            max-width: 700px;
            position: relative;
        }
        
        .stats-card {
            border-radius: 15px;
            background: white;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            padding: 1.5rem;
            transition: all 0.3s ease;
            border: none;
            height: 100%;
        }
        
        .stats-card:hover {
            transform: translateY(-7px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
        }
        
        .stats-card .card-title {
            color: #6c757d;
            font-size: 0.9rem;
            font-weight: 600;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }
        
        .stats-card .stats-number {
            font-size: 2.2rem;
            font-weight: 700;
            margin-bottom: 0.75rem;
            color: var(--dark-color);
        }
        
        .stats-card .stats-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 1rem;
        }
        
        .stats-card .stats-icon i {
            font-size: 1.5rem;
        }
        
        .bg-gradient-primary {
            background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
        }
        
        .bg-gradient-success {
            background: linear-gradient(135deg, #2ecc71, #1abc9c);
        }
        
        .bg-gradient-info {
            background: linear-gradient(135deg, #3498db, #00d2ff);
        }
        
        .bg-gradient-warning {
            background: linear-gradient(135deg, #f39c12, #f1c40f);
        }
        
        .table-container {
            background: white;
            padding: 1.5rem;
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-bottom: 2rem;
        }
        
        .table-container h5 {
            color: var(--dark-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            position: relative;
            padding-bottom: 0.75rem;
        }
        
        .table-container h5::after {
            content: '';
            position: absolute;
            bottom: 0;
            left: 0;
            width: 40px;
            height: 3px;
            background: var(--secondary-color);
            border-radius: 2px;
        }
        
        .table thead th {
            background-color: rgba(245, 247, 250, 0.8);
            color: #6c757d;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            letter-spacing: 0.5px;
            padding: 0.75rem 1rem;
            border-bottom: none;
        }
        
        .table tbody td {
            padding: 1rem;
            vertical-align: middle;
            border-top: 1px solid rgba(0,0,0,0.05);
        }
        
        .table-hover tbody tr:hover {
            background-color: rgba(52, 152, 219, 0.05);
        }
        
        .badge {
            padding: 0.5rem 0.75rem;
            font-weight: 500;
            font-size: 0.75rem;
            border-radius: 30px;
        }
        
        .badge.bg-success {
            background-color: rgba(46, 204, 113, 0.15) !important;
            color: #2ecc71;
        }
        
        .badge.bg-warning {
            background-color: rgba(243, 156, 18, 0.15) !important;
            color: #f39c12;
        }
        
        .badge.bg-danger {
            background-color: rgba(231, 76, 60, 0.15) !important;
            color: #e74c3c;
        }
        
        .btn-primary {
            background: var(--secondary-color);
            border-color: var(--secondary-color);
            border-radius: 6px;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: all 0.3s ease;
        }
        
        .btn-primary:hover {
            background: var(--primary-color);
            border-color: var(--primary-color);
            transform: translateY(-2px);
            box-shadow: 0 5px 10px rgba(0,0,0,0.1);
        }
        
        .btn-sm {
            border-radius: 6px;
            font-size: 0.8rem;
            padding: 0.4rem 0.8rem;
        }
        
        .user-dropdown {
            display: flex;
            align-items: center;
            cursor: pointer;
        }
        
        .user-dropdown img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            object-fit: cover;
            margin-right: 10px;
        }
        
        .search-bar {
            position: relative;
            width: 300px;
        }
        
        .search-bar input {
            width: 100%;
            padding: 0.6rem 1rem 0.6rem 2.5rem;
            border: 1px solid #eaedf2;
            border-radius: 30px;
            background-color: #f8f9fa;
            transition: all 0.3s ease;
        }
        
        .search-bar input:focus {
            background-color: white;
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.25);
            border-color: var(--secondary-color);
        }
        
        .search-bar i {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: #6c757d;
        }
        
        .quick-actions {
            display: flex;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        
        .quick-action-card {
            flex: 1;
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            transition: all 0.3s ease;
            border: 1px solid rgba(0,0,0,0.05);
            display: block;
            text-decoration: none;
            color: var(--dark-color);
        }
        
        .quick-action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 25px rgba(0,0,0,0.1);
            border-color: var(--secondary-color);
            color: var(--secondary-color);
        }
        
        .quick-action-card i {
            font-size: 2rem;
            margin-bottom: 0.5rem;
            display: block;
            color: var(--secondary-color);
        }
        
        .quick-action-card h6 {
            margin-bottom: 0;
            font-weight: 600;
        }
        
        .system-status {
            background: white;
            border-radius: 15px;
            padding: 1.5rem;
            box-shadow: 0 5px 15px rgba(0,0,0,0.05);
            margin-top: 2rem;
        }
        
        .system-status h5 {
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        
        .system-status-item {
            display: flex;
            justify-content: space-between;
            padding: 0.75rem 0;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }
        
        .system-status-item:last-child {
            border-bottom: none;
        }
        
        .system-status-item .status-label {
            color: #6c757d;
            font-weight: 500;
        }
        
        .system-status-item .status-value {
            font-weight: 600;
        }
        
        .footer {
            margin-top: 2rem;
            padding: 1.5rem 0;
            text-align: center;
            color: #6c757d;
            border-top: 1px solid rgba(0,0,0,0.05);
        }
        
        @media (max-width: 992px) {
            .sidebar {
                margin-left: -250px;
            }
            
            .sidebar.active {
                margin-left: 0;
            }
            
            .main-content {
                margin-left: 0;
            }
            
            .main-content.active {
                margin-left: 250px;
            }
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="sidebar-header">
            <div class="text-center">
                <i class="fas fa-hospital text-light fa-3x mb-3"></i>
                <h5 class="text-light fw-bold">Patient Management</h5>
                <p class="text-muted small mb-0">Admin Dashboard</p>
            </div>
        </div>
        <ul class="nav flex-column">
            <li class="nav-item">
                <a class="nav-link active" href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-tachometer-alt"></i>Dashboard
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/doctors">
                    <i class="fas fa-user-md"></i>Manage Doctors
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/nurses">
                    <i class="fas fa-user-nurse"></i>Manage Nurses
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/patients">
                    <i class="fas fa-procedures"></i>Manage Patients
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/appointments">
                    <i class="fas fa-calendar-check"></i>Appointments
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/departments">
                    <i class="fas fa-hospital"></i>Departments
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/users">
                    <i class="fas fa-users-cog"></i>User Management
                </a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="${pageContext.request.contextPath}/admin/profile">
                    <i class="fas fa-user-circle"></i>Profile
                </a>
            </li>
            <li class="nav-item mt-3">
                <a class="nav-link" href="${pageContext.request.contextPath}/logout">
                    <i class="fas fa-sign-out-alt"></i>Logout
                </a>
            </li>
        </ul>
    </div>

    <!-- Main content -->
    <div class="main-content">
        <!-- Top Navigation bar -->
        <div class="top-navbar">
            <div class="d-flex align-items-center">
                <button id="sidebarToggle" class="btn btn-sm me-3 d-lg-none">
                    <i class="fas fa-bars"></i>
                </button>
                <div class="search-bar">
                    <i class="fas fa-search"></i>
                    <input type="text" class="form-control" placeholder="Search...">
                </div>
            </div>
            <div class="user-dropdown">
                <img src="https://randomuser.me/api/portraits/men/1.jpg" alt="User">
                <div>
                    <div class="fw-bold">${user.username}</div>
                    <div class="text-muted small">Administrator</div>
                </div>
            </div>
        </div>
        
        <!-- Welcome Banner -->
        <div class="welcome-banner">
            <h2><i class="fas fa-user-shield me-2"></i>Welcome, ${user.username}!</h2>
            <p>Manage your hospital's operations from one central dashboard. Monitor statistics, track staff and patients, and access all administrative functions.</p>
        </div>

        <!-- Quick Actions -->
        <div class="quick-actions">
            <a href="${pageContext.request.contextPath}/admin/doctors/add" class="quick-action-card">
                <i class="fas fa-user-md"></i>
                <h6>Add Doctor</h6>
            </a>
            <a href="${pageContext.request.contextPath}/admin/patients/add" class="quick-action-card">
                <i class="fas fa-user-plus"></i>
                <h6>Add Patient</h6>
            </a>
            <a href="${pageContext.request.contextPath}/admin/appointments/schedule" class="quick-action-card">
                <i class="fas fa-calendar-plus"></i>
                <h6>New Appointment</h6>
            </a>
            <a href="${pageContext.request.contextPath}/admin/reports" class="quick-action-card">
                <i class="fas fa-chart-bar"></i>
                <h6>Reports</h6>
            </a>
        </div>

        <!-- Statistics Cards -->
        <div class="row g-4 mb-4">
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stats-card">
                    <div class="stats-icon bg-gradient-primary text-white">
                        <i class="fas fa-user-md"></i>
                    </div>
                    <h6 class="card-title">TOTAL DOCTORS</h6>
                    <div class="stats-number">${doctorCount}</div>
                    <div class="d-flex align-items-center">
                        <span class="text-success me-2">
                            <i class="fas fa-arrow-up"></i> 12%
                        </span>
                        <span class="text-muted small">Since last month</span>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stats-card">
                    <div class="stats-icon bg-gradient-success text-white">
                        <i class="fas fa-user-nurse"></i>
                    </div>
                    <h6 class="card-title">TOTAL NURSES</h6>
                    <div class="stats-number">${nurseCount}</div>
                    <div class="d-flex align-items-center">
                        <span class="text-success me-2">
                            <i class="fas fa-arrow-up"></i> 8%
                        </span>
                        <span class="text-muted small">Since last month</span>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stats-card">
                    <div class="stats-icon bg-gradient-info text-white">
                        <i class="fas fa-procedures"></i>
                    </div>
                    <h6 class="card-title">TOTAL PATIENTS</h6>
                    <div class="stats-number">${patientCount}</div>
                    <div class="d-flex align-items-center">
                        <span class="text-success me-2">
                            <i class="fas fa-arrow-up"></i> 16%
                        </span>
                        <span class="text-muted small">Since last month</span>
                    </div>
                </div>
            </div>
            <div class="col-12 col-sm-6 col-xl-3">
                <div class="stats-card">
                    <div class="stats-icon bg-gradient-warning text-white">
                        <i class="fas fa-users"></i>
                    </div>
                    <h6 class="card-title">TOTAL USERS</h6>
                    <div class="stats-number">${userCount}</div>
                    <div class="d-flex align-items-center">
                        <span class="text-success me-2">
                            <i class="fas fa-arrow-up"></i> 5%
                        </span>
                        <span class="text-muted small">Since last month</span>
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
                        <h5>Recent Doctors</h5>
                        <a href="${pageContext.request.contextPath}/admin/doctors" class="btn btn-sm btn-primary">
                            <i class="fas fa-arrow-right me-1"></i> View All
                        </a>
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
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light rounded-circle p-2 me-2">
                                                    <i class="fas fa-user-md text-primary"></i>
                                                </div>
                                                ${doctor.name}
                                            </div>
                                        </td>
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
                        <h5>Recent Nurses</h5>
                        <a href="${pageContext.request.contextPath}/admin/nurses" class="btn btn-sm btn-primary">
                            <i class="fas fa-arrow-right me-1"></i> View All
                        </a>
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
                                        <td>
                                            <div class="d-flex align-items-center">
                                                <div class="bg-light rounded-circle p-2 me-2">
                                                    <i class="fas fa-user-nurse text-success"></i>
                                                </div>
                                                ${nurse.name}
                                            </div>
                                        </td>
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
        
        <!-- System Status -->
        <div class="system-status">
            <h5>System Status</h5>
            <div class="system-status-item">
                <div class="status-label">Server Status</div>
                <div class="status-value text-success">Operational</div>
            </div>
            <div class="system-status-item">
                <div class="status-label">Database Status</div>
                <div class="status-value text-success">Connected</div>
            </div>
            <div class="system-status-item">
                <div class="status-label">Last Backup</div>
                <div class="status-value">Today, 03:45 AM</div>
            </div>
            <div class="system-status-item">
                <div class="status-label">System Version</div>
                <div class="status-value">v2.5.0</div>
            </div>
        </div>
        
        <!-- Footer -->
        <div class="footer">
            <p class="mb-0">&copy; 2025 Patient Management System. All rights reserved.</p>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Sidebar toggle for mobile
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.querySelector('.sidebar').classList.toggle('active');
            document.querySelector('.main-content').classList.toggle('active');
        });
    </script>
</body>
</html> 