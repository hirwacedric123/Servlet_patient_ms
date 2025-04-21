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
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --sidebar-width: 220px;
            --sidebar-width-collapsed: 60px;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f0f5fa;
            color: #333;
            font-size: 14px;
            overflow-x: hidden;
        }
        
        .card {
            border: none;
            border-radius: 10px;
            box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.05);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            margin-bottom: 16px;
            overflow: hidden;
        }
        
        .card:hover {
            transform: translateY(-3px);
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            font-weight: 500;
            border: none;
            padding: 12px 16px;
        }
        
        .welcome-banner {
            background: linear-gradient(135deg, #3498db, #2980b9);
            color: white;
            padding: 16px 20px;
            border-radius: 10px;
            margin-bottom: 16px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 0.25rem 0.5rem rgba(0, 0, 0, 0.1);
        }
        
        .welcome-banner::before {
            content: '';
            position: absolute;
            top: -50px;
            right: -50px;
            background-color: rgba(255, 255, 255, 0.1);
            width: 100px;
            height: 100px;
            border-radius: 50%;
        }
        
        .welcome-banner::after {
            content: '';
            position: absolute;
            bottom: -50px;
            left: -50px;
            background-color: rgba(255, 255, 255, 0.1);
            width: 120px;
            height: 120px;
            border-radius: 50%;
        }
        
        .welcome-banner h2 {
            font-weight: 600;
            margin-bottom: 5px;
            font-size: calc(1.2rem + 0.6vw);
        }
        
        .stats-card {
            text-align: center;
            margin-bottom: 16px;
            border-radius: 10px;
            padding: 8px;
            height: 100%;
        }
        
        .stats-card .card-body {
            padding: 16px 12px;
        }
        
        .stats-icon {
            font-size: 1.8rem;
            margin-bottom: 12px;
            background: rgba(0, 0, 0, 0.05);
            width: 60px;
            height: 60px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
        }
        
        .stats-card h3 {
            font-size: calc(1.5rem + 1vw);
            font-weight: 700;
            margin-bottom: 4px;
        }
        
        .stats-card h5 {
            color: #666;
            font-weight: 500;
            font-size: 0.9rem;
        }
        
        .patients { 
            color: #2ecc71; 
        }
        
        .patients-bg {
            background: rgba(46, 204, 113, 0.1);
        }
        
        .referrable { 
            color: #e74c3c; 
        }
        
        .referrable-bg {
            background: rgba(231, 76, 60, 0.1);
        }
        
        .non-referrable { 
            color: #f39c12; 
        }
        
        .non-referrable-bg {
            background: rgba(243, 156, 18, 0.1);
        }
        
        .patient-image {
            width: 40px;
            height: 40px;
            object-fit: cover;
            border-radius: 50%;
            border: 2px solid #fff;
            box-shadow: 0 0 0 1px #ddd;
            transition: transform 0.3s ease;
        }
        
        .patient-image:hover {
            transform: scale(1.15);
        }
        
        .alert {
            border-radius: 8px;
            padding: 12px;
            margin-bottom: 16px;
            border: none;
        }
        
        .alert-success {
            background-color: #d4edda;
            color: #155724;
            border-left: 4px solid #28a745;
        }
        
        .alert-warning {
            background-color: #f8d7da;
            color: #721c24;
            border-left: 4px solid #dc3545;
        }
        
        .registered-by-you {
            background-color: rgba(52, 152, 219, 0.05);
            border-left: 4px solid #3498db;
        }
        
        /* Table styling */
        .table {
            border-collapse: separate;
            border-spacing: 0;
            font-size: 0.85rem;
        }
        
        .table thead th {
            background-color: #f8f9fa;
            border-bottom: 2px solid #dee2e6;
            color: #495057;
            font-weight: 600;
            text-transform: uppercase;
            font-size: 0.75rem;
            padding: 10px;
        }
        
        .table tbody td {
            padding: 10px;
            vertical-align: middle;
            border-bottom: 1px solid #dee2e6;
        }
        
        .table tbody tr:hover {
            background-color: rgba(0, 0, 0, 0.02);
        }
        
        /* Badge styling */
        .badge {
            padding: 0.4em 0.6em;
            font-weight: 500;
            font-size: 0.7rem;
            border-radius: 4px;
        }
        
        /* Button styling */
        .btn {
            border-radius: 6px;
            font-weight: 500;
            padding: 0.4rem 0.8rem;
            transition: all 0.3s ease;
            font-size: 0.85rem;
        }
        
        .btn-sm {
            padding: 0.25rem 0.5rem;
            font-size: 0.75rem;
        }
        
        .btn-primary {
            background-color: #3498db;
            border-color: #3498db;
        }
        
        .btn-primary:hover, .btn-primary:focus {
            background-color: #2980b9;
            border-color: #2980b9;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.15);
        }
        
        .btn-info {
            background-color: #17a2b8;
            border-color: #17a2b8;
        }
        
        .btn-info:hover, .btn-info:focus {
            background-color: #138496;
            border-color: #117a8b;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.15);
        }
        
        .btn-success {
            background-color: #28a745;
            border-color: #28a745;
        }
        
        .btn-success:hover, .btn-success:focus {
            background-color: #218838;
            border-color: #1e7e34;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.15);
        }
        
        .btn-light {
            background-color: #f8f9fa;
            border-color: #f8f9fa;
            color: #212529;
        }
        
        .btn-light:hover, .btn-light:focus {
            background-color: #e2e6ea;
            border-color: #dae0e5;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.15);
        }
        
        .action-buttons {
            display: flex;
            gap: 5px;
            flex-wrap: wrap;
        }
        
        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            padding: 0;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            background: linear-gradient(180deg, #2c3e50, #3498db);
            width: var(--sidebar-width);
            transition: all 0.3s ease;
        }
        
        .sidebar.collapsed {
            width: var(--sidebar-width-collapsed);
        }
        
        .sidebar-header {
            padding: 16px 10px;
            background: rgba(0, 0, 0, 0.1);
            text-align: center;
        }
        
        .sidebar-header h5 {
            font-size: 0.9rem;
            margin-top: 8px;
            transition: opacity 0.3s;
        }
        
        .sidebar.collapsed .sidebar-header h5 {
            opacity: 0;
        }
        
        .sidebar-link {
            display: flex;
            align-items: center;
            padding: 10px 16px;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s;
            border-left: 3px solid transparent;
            margin: 3px 0;
            white-space: nowrap;
            overflow: hidden;
        }
        
        .sidebar-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-left-color: rgba(255, 255, 255, 0.5);
        }
        
        .sidebar-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            color: white;
            border-left-color: white;
            font-weight: 500;
        }
        
        .sidebar-link i {
            width: 20px;
            text-align: center;
            margin-right: 10px;
            font-size: 1rem;
        }
        
        .sidebar-link span {
            transition: opacity 0.3s;
        }
        
        .sidebar.collapsed .sidebar-link span {
            opacity: 0;
        }
        
        .content-area {
            margin-left: var(--sidebar-width);
            padding: 16px;
            transition: all 0.3s ease;
        }
        
        .content-area.expanded {
            margin-left: var(--sidebar-width-collapsed);
        }
        
        .toggle-sidebar {
            position: fixed;
            bottom: 20px;
            left: calc(var(--sidebar-width) - 15px);
            z-index: 101;
            width: 30px;
            height: 30px;
            background: #3498db;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            cursor: pointer;
            transition: left 0.3s ease;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
            border: none;
        }
        
        .toggle-sidebar.collapsed {
            left: calc(var(--sidebar-width-collapsed) - 15px);
        }
        
        .navbar-mobile {
            background: white;
            border-radius: 10px;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
        }
        
        @media (max-width: 1199.98px) {
            .stats-icon {
                width: 50px;
                height: 50px;
                font-size: 1.5rem;
            }
            
            .stats-card h3 {
                font-size: calc(1.3rem + 0.6vw);
            }
            
            .stats-card h5 {
                font-size: 0.85rem;
            }
            
            .action-buttons .btn-sm {
                padding: 0.2rem 0.4rem;
                font-size: 0.7rem;
            }
            
            .action-buttons .btn-sm i {
                margin-right: 0;
            }
        }
        
        @media (max-width: 991.98px) {
            .action-buttons .btn-sm span {
                display: none;
            }
            
            .table thead th,
            .table tbody td {
                padding: 8px;
            }
            
            .welcome-banner h2 {
                font-size: calc(1.1rem + 0.5vw);
            }
            
            .welcome-banner p {
                font-size: 0.85rem;
            }
        }
        
        @media (max-width: 767.98px) {
            .sidebar {
                margin-left: calc(-1 * var(--sidebar-width));
                position: fixed;
                height: 100%;
                width: var(--sidebar-width);
                z-index: 999;
            }
            
            .sidebar.show {
                margin-left: 0;
            }
            
            .content-area {
                margin-left: 0;
                padding: 12px;
            }
            
            .welcome-banner {
                padding: 16px;
            }
            
            .toggle-sidebar {
                display: none;
            }
        }
        
        @media (max-width: 575.98px) {
            .card-header h5 {
                font-size: 0.9rem;
            }
            
            .welcome-banner {
                padding: 12px;
            }
            
            .welcome-banner h2 {
                font-size: 1.1rem;
            }
            
            .welcome-banner p {
                font-size: 0.8rem;
            }
            
            .table {
                font-size: 0.75rem;
            }
            
            .table thead th {
                font-size: 0.7rem;
                padding: 6px;
            }
            
            .table tbody td {
                padding: 6px;
            }
            
            .patient-image {
                width: 35px;
                height: 35px;
            }
            
            .btn-sm {
                padding: 0.15rem 0.3rem;
                font-size: 0.7rem;
            }
            
            .badge {
                font-size: 0.65rem;
                padding: 0.3em 0.5em;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block sidebar" id="sidebar">
                <div class="sidebar-header mb-3">
                    <i class="fas fa-hospital-user text-light fa-2x mb-2"></i>
                    <h5 class="text-light">Patient Management</h5>
                </div>
                <ul class="nav flex-column">
                    <li class="nav-item">
                        <a class="sidebar-link active" href="${pageContext.request.contextPath}/nurse/dashboard">
                            <i class="fas fa-tachometer-alt"></i>
                            <span>Dashboard</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="sidebar-link" href="${pageContext.request.contextPath}/nurse/patient-registration">
                            <i class="fas fa-user-plus"></i>
                            <span>Register Patient</span>
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="sidebar-link" href="${pageContext.request.contextPath}/nurse/patients">
                            <i class="fas fa-procedures"></i>
                            <span>My Patients</span>
                        </a>
                    </li>
                    <li class="nav-item mt-3">
                        <a class="sidebar-link" href="${pageContext.request.contextPath}/logout">
                            <i class="fas fa-sign-out-alt"></i>
                            <span>Logout</span>
                        </a>
                    </li>
                </ul>
            </div>

            <!-- Toggle sidebar button -->
            <button class="toggle-sidebar" id="toggleSidebar">
                <i class="fas fa-chevron-left" id="toggleIcon"></i>
            </button>

            <!-- Main content -->
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-area" id="mainContent">
                <!-- Top Navbar for mobile -->
                <nav class="navbar navbar-expand-lg navbar-light mb-3 shadow-sm rounded d-md-none navbar-mobile">
                    <div class="container-fluid">
                        <button class="navbar-toggler border-0" type="button" id="sidebarToggle">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <span class="navbar-brand">PMS</span>
                        <div class="d-flex align-items-center ms-auto">
                            <div class="user-info small">
                                <i class="fas fa-user-nurse me-1"></i>${nurse.firstName} ${nurse.lastName}
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
                    <h2><i class="fas fa-user-nurse me-2"></i>Welcome, ${nurse.firstName} ${nurse.lastName}!</h2>
                    <p class="mb-0">You are logged in as a nurse from ${nurse.healthCenter} health center.</p>
                </div>

                <!-- Statistics Cards -->
                <div class="row mb-3">
                    <div class="col-md-4">
                        <div class="card stats-card">
                            <div class="card-body">
                                <div class="stats-icon patients patients-bg">
                                    <i class="fas fa-users"></i>
                                </div>
                                <h3>${patientCount}</h3>
                                <h5>Total Patients</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stats-card">
                            <div class="card-body">
                                <div class="stats-icon referrable referrable-bg">
                                    <i class="fas fa-hospital-user"></i>
                                </div>
                                <h3>${referrableCount}</h3>
                                <h5>Referrable Cases</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card stats-card">
                            <div class="card-body">
                                <div class="stats-icon non-referrable non-referrable-bg">
                                    <i class="fas fa-user-check"></i>
                                </div>
                                <h3>${nonReferrableCount}</h3>
                                <h5>Non-Referrable Cases</h5>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Patient List -->
                <div class="card mb-3">
                    <div class="card-header">
                        <div class="d-flex justify-content-between align-items-center">
                            <h5 class="mb-0">
                                <i class="fas fa-users me-2"></i>
                                <c:choose>
                                    <c:when test="${pageContext.request.servletPath == '/nurse/patients'}">
                                        All Patients in System
                                    </c:when>
                                    <c:otherwise>
                                        Patients You've Registered
                                    </c:otherwise>
                                </c:choose>
                            </h5>
                            <a href="${pageContext.request.contextPath}/nurse/patient-registration" class="btn btn-light btn-sm">
                                <i class="fas fa-plus me-1"></i>Register Patient
                            </a>
                        </div>
                    </div>
                    <div class="card-body">
                        <c:choose>
                            <c:when test="${empty registeredPatients}">
                                <div class="text-center py-4">
                                    <i class="fas fa-clipboard-list text-muted fa-3x mb-3"></i>
                                    <p class="text-muted">No patients registered yet</p>
                                    <a href="${pageContext.request.contextPath}/nurse/patient-registration" class="btn btn-primary mt-2">
                                        <i class="fas fa-plus me-1"></i>Register Your First Patient
                                    </a>
                                </div>
                                <!-- Debug information (will be removed in production) -->
                                <p class="text-center text-muted small">Debug: Empty patients list</p>
                            </c:when>
                            <c:otherwise>
                                <!-- Debug information (will be removed in production) -->
                                <p class="text-center text-muted small">Debug: Found ${registeredPatients.size()} patients</p>
                                
                                <div class="table-responsive">
                                    <table class="table table-hover">
                                        <thead>
                                            <tr>
                                                <th>Photo</th>
                                                <th>ID</th>
                                                <th>Patient Name</th>
                                                <th>Gender</th>
                                                <th>Contact</th>
                                                <th>Status</th>
                                                <th>Actions</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${registeredPatients}" var="patient" varStatus="loop">
                                                <tr class="${patient.getCreatedBy() == nurse.getNurseID() ? 'registered-by-you' : ''}">
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${not empty patient.profileImage}">
                                                                <img src="${pageContext.request.contextPath}/${patient.profileImage}" class="patient-image" alt="Patient Photo">
                                                            </c:when>
                                                            <c:otherwise>
                                                                <img src="${pageContext.request.contextPath}/images/default-avatar.png" class="patient-image" alt="Default Photo">
                                                            </c:otherwise>
                                                        </c:choose>
                                                    </td>
                                                    <td>${patient.patientID}</td>
                                                    <td>${patient.firstName} ${patient.lastName}</td>
                                                    <td>${patient.gender}</td>
                                                    <td>${patient.contactNumber}</td>
                                                    <td>
                                                        <c:choose>
                                                            <c:when test="${patient.isReferrable()}">
                                                                <span class="badge bg-danger">Referrable</span>
                                                            </c:when>
                                                            <c:otherwise>
                                                                <span class="badge bg-success">Non-Referrable</span>
                                                            </c:otherwise>
                                                        </c:choose>
                                                        <c:if test="${patient.getCreatedBy() == nurse.getNurseID()}">
                                                            <span class="badge bg-primary">Registered by you</span>
                                                        </c:if>
                                                    </td>
                                                    <td>
                                                        <div class="action-buttons">
                                                            <a href="${pageContext.request.contextPath}/nurse/edit-patient?id=${patient.patientID}" class="btn btn-sm btn-primary">
                                                                <i class="fas fa-edit"></i> <span>Edit</span>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/nurse/view-patient?id=${patient.patientID}" class="btn btn-sm btn-info">
                                                                <i class="fas fa-eye"></i> <span>View</span>
                                                            </a>
                                                            <a href="${pageContext.request.contextPath}/nurse/create-diagnosis?patientId=${patient.patientID}" class="btn btn-sm btn-success">
                                                                <i class="fas fa-stethoscope"></i> <span>Diagnose</span>
                                                            </a>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </div>
                                <c:if test="${patientCount > 10}">
                                    <div class="text-center mt-3">
                                        <a href="${pageContext.request.contextPath}/nurse/patients" class="btn btn-outline-primary">
                                            <i class="fas fa-list me-1"></i>View All Patients
                                        </a>
                                    </div>
                                </c:if>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle sidebar on mobile
        document.getElementById('sidebarToggle').addEventListener('click', function() {
            document.getElementById('sidebar').classList.toggle('show');
        });
        
        // Toggle sidebar collapse for desktop
        const toggleBtn = document.getElementById('toggleSidebar');
        const sidebar = document.getElementById('sidebar');
        const mainContent = document.getElementById('mainContent');
        const toggleIcon = document.getElementById('toggleIcon');
        
        toggleBtn.addEventListener('click', function() {
            sidebar.classList.toggle('collapsed');
            mainContent.classList.toggle('expanded');
            toggleBtn.classList.toggle('collapsed');
            
            if (sidebar.classList.contains('collapsed')) {
                toggleIcon.classList.remove('fa-chevron-left');
                toggleIcon.classList.add('fa-chevron-right');
            } else {
                toggleIcon.classList.remove('fa-chevron-right');
                toggleIcon.classList.add('fa-chevron-left');
            }
        });
        
        // Check screen size on load and resize
        function checkScreenSize() {
            if (window.innerWidth < 1400 && window.innerWidth >= 768) {
                sidebar.classList.add('collapsed');
                mainContent.classList.add('expanded');
                toggleBtn.classList.add('collapsed');
                toggleIcon.classList.remove('fa-chevron-left');
                toggleIcon.classList.add('fa-chevron-right');
            } else if (window.innerWidth >= 1400) {
                sidebar.classList.remove('collapsed');
                mainContent.classList.remove('expanded');
                toggleBtn.classList.remove('collapsed');
                toggleIcon.classList.remove('fa-chevron-right');
                toggleIcon.classList.add('fa-chevron-left');
            }
        }
        
        // Run on page load
        checkScreenSize();
        
        // Run when window resizes
        window.addEventListener('resize', checkScreenSize);
    </script>
</body>
</html> 