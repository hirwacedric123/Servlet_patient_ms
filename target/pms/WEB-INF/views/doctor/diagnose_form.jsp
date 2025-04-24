<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Patient Diagnosis - Patient Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-color: #2c3e50;
            --secondary-color: #3498db;
            --accent-color: #1abc9c;
            --light-color: #f8f9fa;
            --dark-color: #222;
            --danger-color: #e74c3c;
            --warning-color: #f39c12;
            --success-color: #2ecc71;
            --sidebar-width: 250px;
            --sidebar-width-collapsed: 60px;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: var(--light-color);
            color: #333;
            font-size: 14px;
            overflow-x: hidden;
        }
        
        .card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.05);
            border: none;
            transition: all 0.3s ease;
            margin-bottom: 20px;
            animation: fadeIn 0.5s ease;
        }
        
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.1);
        }
        
        .card-header {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            color: white;
            font-weight: 600;
            border: none;
            padding: 1.2rem 1.5rem;
            position: relative;
            overflow: hidden;
        }
        
        .card-header::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,0 C30,40 70,40 100,0 L100,100 0,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
            background-size: 100% 100%;
        }
        
        .card-body {
            padding: 1.8rem;
        }
        
        .patient-info {
            background: linear-gradient(to right, #f5f7fa, #eef2f7);
            border-radius: 15px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            padding: 1.5rem;
            margin-bottom: 1.5rem;
            border-left: 4px solid var(--secondary-color);
            transition: all 0.3s ease;
            animation: fadeIn 0.5s ease;
        }
        
        .patient-info:hover {
            box-shadow: 0 8px 25px rgba(0, 0, 0, 0.1);
        }
        
        .patient-info h5 {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
        }
        
        .patient-info h5 i {
            margin-right: 0.5rem;
            color: var(--secondary-color);
        }
        
        .form-label {
            font-weight: 500;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        
        .form-control {
            border-radius: 10px;
            padding: 0.7rem 1rem;
            border: 1px solid rgba(0,0,0,0.1);
            box-shadow: none;
            transition: all 0.3s ease;
            font-size: 0.9rem;
        }
        
        .form-control:focus {
            border-color: var(--secondary-color);
            box-shadow: 0 0 0 0.25rem rgba(52, 152, 219, 0.15);
        }
        
        .form-text {
            color: #6c757d;
            font-size: 0.8rem;
            margin-top: 0.4rem;
        }
        
        .alert {
            border-radius: 10px;
            padding: 15px 20px;
            font-weight: 500;
            border: none;
            margin-bottom: 25px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            animation: fadeIn 0.5s ease;
        }
        
        .alert-danger {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
        }
        
        .alert-warning {
            background-color: rgba(243, 156, 18, 0.15);
            color: #f39c12;
        }
        
        .alert-success {
            background-color: rgba(26, 188, 156, 0.15);
            color: #1abc9c;
        }
        
        /* Button styling */
        .btn {
            padding: 0.6rem 1.2rem;
            font-weight: 600;
            transition: all 0.3s ease;
            font-size: 0.85rem;
            border-radius: 50px;
        }
        
        .btn-primary {
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.1);
        }
        
        .btn-primary:hover, .btn-primary:focus {
            background: linear-gradient(to right, var(--secondary-color), var(--primary-color));
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.15);
        }
        
        .btn-secondary {
            background-color: #6c757d;
            border: none;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .btn-secondary:hover, .btn-secondary:focus {
            background-color: #5a6268;
            transform: translateY(-3px);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
        }
        
        /* Sidebar styles */
        .sidebar {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            padding: 48px 0 0;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.15);
            background: linear-gradient(145deg, var(--primary-color), var(--secondary-color));
            width: var(--sidebar-width);
            transition: all 0.3s ease;
            overflow-y: auto;
        }
        
        .sidebar:before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml;utf8,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100" preserveAspectRatio="none"><path d="M0,100 C20,0 50,0 100,100 Z" fill="rgba(255,255,255,0.05)"/></svg>');
            background-size: 100% 100%;
            pointer-events: none;
        }
        
        .sidebar.collapsed {
            width: var(--sidebar-width-collapsed);
        }
        
        /* Sidebar Logo */
        .sidebar-header {
            padding: 15px;
            margin-bottom: 20px;
            text-align: center;
        }
        
        .sidebar-header i {
            background: linear-gradient(135deg, #ffffff, rgba(255,255,255,0.7));
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 15px;
            filter: drop-shadow(0 3px 5px rgba(0,0,0,0.2));
            transition: all 0.3s ease;
        }
        
        .sidebar-header:hover i {
            transform: scale(1.1);
        }
        
        .sidebar-header h5 {
            color: white;
            font-weight: 600;
            font-size: 1.2rem;
            margin: 0;
            letter-spacing: 0.5px;
            text-shadow: 0 2px 4px rgba(0,0,0,0.3);
        }
        
        .sidebar-link {
            display: block;
            padding: 0.8rem 1.5rem;
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            transition: all 0.3s;
            border-left: 4px solid transparent;
            position: relative;
            z-index: 1;
            margin-bottom: 5px;
            font-weight: 500;
        }
        
        .sidebar-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: white;
            border-left: 4px solid var(--accent-color);
            transform: translateX(5px);
        }
        
        .sidebar-link.active {
            background-color: rgba(255, 255, 255, 0.15);
            color: white;
            border-left: 4px solid var(--accent-color);
            font-weight: 600;
        }
        
        .sidebar-link i {
            width: 20px;
            text-align: center;
            margin-right: 10px;
            font-size: 1rem;
        }
        
        .content-area {
            margin-left: var(--sidebar-width);
            padding: 30px;
            transition: all 0.3s ease;
        }
        
        /* Add container for content width control */
        .content-container {
            max-width: 900px;
            margin: 0 auto;
        }
        
        .badge {
            padding: 0.5rem 0.8rem;
            border-radius: 50px;
            font-weight: 500;
            font-size: 0.75rem;
            transition: all 0.3s ease;
        }
        
        .badge-referrable {
            background-color: rgba(231, 76, 60, 0.2);
            color: #e74c3c;
        }
        
        .badge-not-referrable {
            background-color: rgba(46, 204, 113, 0.2);
            color: #2ecc71;
        }
        
        /* Animations */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        
        .fadeIn {
            animation: fadeIn 0.5s ease;
        }
        
        /* Responsive Adjustments */
        @media (max-width: 767.98px) {
            .sidebar {
                position: static;
                padding-top: 0;
                height: auto;
                margin-left: calc(-1 * var(--sidebar-width));
                position: fixed;
                z-index: 999;
            }
            
            .sidebar.show {
                margin-left: 0;
            }
            
            .content-area {
                margin-left: 0;
                padding: 15px;
            }
            
            .sidebar-link:hover {
                transform: none;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block sidebar" id="sidebar">
                <div class="position-sticky">
                    <div class="sidebar-header">
                        <i class="fas fa-user-md fa-3x mb-3"></i>
                        <h5>Patient Management System</h5>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/doctor/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link active" href="#">
                                <i class="fas fa-stethoscope me-2"></i>Diagnose Patient
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/doctor/register-nurse">
                                <i class="fas fa-user-nurse me-2"></i>Register Nurse
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
            <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 content-area" id="mainContent">
                <!-- Top Navbar for mobile -->
                <nav class="navbar navbar-expand-lg navbar-light mb-4 shadow-sm rounded d-md-none">
                    <div class="container-fluid">
                        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target=".sidebar">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <span class="navbar-brand">PMS</span>
                        <div class="d-flex align-items-center ms-auto">
                            <div class="user-info">
                                <i class="fas fa-user-md me-1"></i>Dr. ${doctor.firstName} ${doctor.lastName}
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Content container to control width -->
                <div class="content-container">
                    <!-- Breadcrumb -->
                    <nav aria-label="breadcrumb" class="fadeIn">
                        <ol class="breadcrumb bg-white shadow-sm p-3 rounded">
                            <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/doctor/dashboard" class="text-decoration-none">Dashboard</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Patient Diagnosis</li>
                        </ol>
                    </nav>

                    <!-- Error Message if present -->
                    <c:if test="${not empty errorMessage}">
                        <div class="alert alert-danger fadeIn">
                            <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                        </div>
                    </c:if>
                    
                    <div class="card fadeIn">
                        <div class="card-header d-flex align-items-center">
                            <i class="fas fa-stethoscope fa-lg me-3"></i>
                            <h5 class="mb-0">Patient Diagnosis</h5>
                        </div>
                        <div class="card-body">
                            <!-- Patient Information -->
                            <div class="patient-info">
                                <h5><i class="fas fa-user-circle"></i> Patient Information</h5>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <p><span class="fw-bold text-primary">Name:</span> ${patient.firstName} ${patient.lastName}</p>
                                        <p><span class="fw-bold text-primary">Gender:</span> ${patient.gender}</p>
                                        <p><span class="fw-bold text-primary">Age:</span> ${patient.age}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><span class="fw-bold text-primary">Contact:</span> ${patient.contactNumber}</p>
                                        <p><span class="fw-bold text-primary">Email:</span> ${patient.email}</p>
                                        <p><span class="fw-bold text-primary">Blood Group:</span> ${patient.bloodGroup}</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Diagnosis Information -->
                            <div class="patient-info">
                                <h5><i class="fas fa-clipboard-list"></i> Diagnosis Information</h5>
                                <div class="row g-3">
                                    <div class="col-md-6">
                                        <p><span class="fw-bold text-primary">Diagnosis ID:</span> ${diagnosis.diagnosisID}</p>
                                        <p>
                                            <span class="fw-bold text-primary">Status:</span> 
                                            <span class="badge ${diagnosis.diagnoStatus eq 'Referrable' ? 'badge-referrable' : 'badge-not-referrable'}">
                                                ${diagnosis.diagnoStatus}
                                            </span>
                                        </p>
                                        <p><span class="fw-bold text-primary">Current Result:</span> ${diagnosis.result}</p>
                                    </div>
                                    <div class="col-md-6">
                                        <p><span class="fw-bold text-primary">Referred by Nurse:</span> ${nurseName}</p>
                                        <p><span class="fw-bold text-primary">Created Date:</span> ${diagnosis.createdDate}</p>
                                        <p><span class="fw-bold text-primary">Last Updated:</span> ${diagnosis.updatedDate}</p>
                                    </div>
                                </div>
                            </div>

                            <!-- Diagnosis Form - Only show if referrable and pending -->
                            <c:choose>
                                <c:when test="${diagnosis.diagnoStatus eq 'Referrable' && diagnosis.isPending()}">
                                    <div class="card mb-0 mt-4 border-0 shadow-sm">
                                        <div class="card-body">
                                            <h5 class="mb-4 text-primary"><i class="fas fa-edit me-2"></i>Enter Diagnosis</h5>
                                            <form action="${pageContext.request.contextPath}/doctor/diagnose" method="post">
                                                <input type="hidden" name="diagnosisId" value="${diagnosis.diagnosisID}">
                                                
                                                <div class="mb-4">
                                                    <label for="diagnosisResult" class="form-label">Diagnosis Result <span class="text-danger">*</span></label>
                                                    <textarea class="form-control" id="diagnosisResult" name="diagnosisResult" rows="5" required 
                                                        placeholder="Enter your detailed diagnosis and treatment plan for the patient"></textarea>
                                                    <div class="form-text">
                                                        <i class="fas fa-info-circle me-1"></i>
                                                        Provide a detailed diagnosis and recommended treatment plan for this patient
                                                    </div>
                                                </div>
                                                
                                                <div class="d-flex justify-content-end gap-3 mt-4">
                                                    <a href="${pageContext.request.contextPath}/doctor/dashboard" class="btn btn-secondary">
                                                        <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                                                    </a>
                                                    <button type="submit" class="btn btn-primary">
                                                        <i class="fas fa-save me-2"></i>Save Diagnosis
                                                    </button>
                                                </div>
                                            </form>
                                        </div>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="alert alert-warning fadeIn mt-4">
                                        <i class="fas fa-exclamation-triangle me-2"></i>
                                        <c:choose>
                                            <c:when test="${diagnosis.diagnoStatus ne 'Referrable'}">
                                                This case is marked as "Not Referrable" and cannot be updated.
                                            </c:when>
                                            <c:otherwise>
                                                This case has already been diagnosed and cannot be updated again.
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                    <div class="d-flex justify-content-end mt-4">
                                        <a href="${pageContext.request.contextPath}/doctor/dashboard" class="btn btn-secondary">
                                            <i class="fas fa-arrow-left me-2"></i>Back to Dashboard
                                        </a>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Toggle sidebar on mobile
        document.addEventListener('DOMContentLoaded', function() {
            const mobileToggle = document.querySelector('[data-bs-toggle="collapse"]');
            if (mobileToggle) {
                mobileToggle.addEventListener('click', function() {
                    document.getElementById('sidebar').classList.toggle('show');
                });
            }
        });
    </script>
</body>
</html> 