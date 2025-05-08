<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register Patient - Patient Management System</title>
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
        
        .section-title {
            color: var(--primary-color);
            font-weight: 600;
            margin-bottom: 1.5rem;
            padding-bottom: 0.8rem;
            position: relative;
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }
        
        .section-title::after {
            content: '';
            position: absolute;
            bottom: -1px;
            left: 0;
            width: 80px;
            height: 3px;
            background: linear-gradient(to right, var(--primary-color), var(--secondary-color));
            border-radius: 3px;
        }
        
        .form-label {
            font-weight: 500;
            color: var(--primary-color);
            margin-bottom: 0.5rem;
        }
        
        .form-control, .form-select {
            border-radius: 10px;
            padding: 0.6rem 1rem;
            border: 1px solid rgba(0,0,0,0.1);
            box-shadow: none;
            transition: all 0.3s ease;
        }
        
        .form-control:focus, .form-select:focus {
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
        
        .alert-success {
            background-color: rgba(26, 188, 156, 0.15);
            color: #1abc9c;
        }
        
        .alert-warning {
            background-color: rgba(231, 76, 60, 0.15);
            color: #e74c3c;
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
        
        .breadcrumb {
            background-color: rgba(255, 255, 255, 0.7);
            border-radius: 10px;
            padding: 0.8rem 1.2rem;
            margin-bottom: 1.5rem;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
        }
        
        .breadcrumb-item a {
            color: var(--secondary-color);
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .breadcrumb-item a:hover {
            color: var(--primary-color);
        }
        
        .breadcrumb-item.active {
            color: var(--primary-color);
            font-weight: 500;
        }
        
        .breadcrumb-item + .breadcrumb-item::before {
            color: var(--secondary-color);
        }
        
        .img-thumbnail {
            border-radius: 10px;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }
        
        .img-thumbnail:hover {
            transform: scale(1.03);
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1);
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
        
        .form-container {
            max-width: 800px;
            margin: 0 auto;
            transition: all 0.3s ease;
            animation: fadeIn 0.5s ease;
        }
        
        .form-container .card {
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 25px rgba(0, 0, 0, 0.08);
        }
        
        .form-container .card-header {
            padding: 1.5rem;
        }
        
        .form-container .card-body {
            padding: 2rem;
        }
        
        /* Enhance input fields at smaller width */
        .form-container .form-control,
        .form-container .form-select {
            padding: 0.7rem 1rem;
            font-size: 0.9rem;
        }
        
        .form-container .form-label {
            font-size: 0.95rem;
        }
        
        .form-container .form-text {
            margin-top: 0.4rem;
        }
        
        .form-container .section-title {
            font-size: 1.2rem;
            margin-top: 0.5rem;
        }
        
        /* Responsive adjustments for form container */
        @media (max-width: 991.98px) {
            .form-container {
                max-width: 100%;
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
                    <div class="text-center mb-4 mt-3">
                        <div class="sidebar-header">
                            <i class="fas fa-user-nurse fa-3x mb-3"></i>
                            <h5>Patient Management System</h5>
                        </div>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/nurse/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link active" href="${pageContext.request.contextPath}/nurse/patient-registration">
                                <i class="fas fa-user-plus me-2"></i>Register Patient
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
                                <i class="fas fa-user-nurse me-1"></i>${nurse.firstName} ${nurse.lastName}
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Breadcrumb -->
                <nav aria-label="breadcrumb" class="fadeIn">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/nurse/dashboard">Dashboard</a></li>
                        <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/nurse/patients">Patients</a></li>
                        <li class="breadcrumb-item active" aria-current="page">Register Patient</li>
                    </ol>
                </nav>
                
                <!-- Error message if present -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-warning fadeIn">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                    </div>
                </c:if>
                
                <!-- Success message if present -->
                <c:if test="${not empty successMessage}">
                    <div class="alert alert-success fadeIn">
                        <i class="fas fa-check-circle me-2"></i>${successMessage}
                    </div>
                </c:if>
                
                <!-- Form Container - Added to constrain width -->
                <div class="form-container mx-auto">
                    <!-- Registration Form Card -->
                    <div class="card mb-5">
                        <div class="card-header d-flex align-items-center">
                            <i class="fas fa-user-plus fa-lg me-3"></i>
                            <h5 class="mb-0">Register New Patient</h5>
                        </div>
                        <div class="card-body">
                            <form action="${pageContext.request.contextPath}/nurse/patient-registration" method="post" enctype="multipart/form-data">
                                <h5 class="section-title"><i class="fas fa-id-card me-2"></i>Personal Information</h5>
                                
                                <div class="row g-3 mb-4">
                                    <div class="col-md-6">
                                        <label for="firstName" class="form-label">First Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="firstName" name="firstName" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="lastName" class="form-label">Last Name <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="lastName" name="lastName" required>
                                    </div>
                                </div>
                                
                                <div class="row g-3 mb-4">
                                    <div class="col-md-6">
                                        <label for="gender" class="form-label">Gender <span class="text-danger">*</span></label>
                                        <select class="form-select" id="gender" name="gender" required>
                                            <option value="" selected disabled>Select Gender</option>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                            <option value="Other">Other</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                        <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth">
                                    </div>
                                </div>
                                
                                <div class="row g-3 mb-4">
                                    <div class="col-md-6">
                                        <label for="contactNumber" class="form-label">Contact Number <span class="text-danger">*</span></label>
                                        <input type="tel" class="form-control" id="contactNumber" name="contactNumber" required>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="email" class="form-label">Email</label>
                                        <input type="email" class="form-control" id="email" name="email">
                                    </div>
                                </div>
                                
                                <div class="row g-3 mb-4">
                                    <div class="col-md-6">
                                        <label for="emergencyContact" class="form-label">Emergency Contact</label>
                                        <input type="tel" class="form-control" id="emergencyContact" name="emergencyContact">
                                    </div>
                                    <div class="col-md-6">
                                        <label for="bloodGroup" class="form-label">Blood Group</label>
                                        <select class="form-select" id="bloodGroup" name="bloodGroup">
                                            <option value="" selected disabled>Select Blood Group</option>
                                            <option value="A+">A+</option>
                                            <option value="A-">A-</option>
                                            <option value="B+">B+</option>
                                            <option value="B-">B-</option>
                                            <option value="AB+">AB+</option>
                                            <option value="AB-">AB-</option>
                                            <option value="O+">O+</option>
                                            <option value="O-">O-</option>
                                            <option value="Unknown">Unknown</option>
                                        </select>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="address" class="form-label">Address</label>
                                    <textarea class="form-control" id="address" name="address" rows="2"></textarea>
                                </div>
                                
                                <h5 class="section-title"><i class="fas fa-user-lock me-2"></i>Account Information</h5>
                                
                                <div class="row g-3 mb-4">
                                    <div class="col-md-6">
                                        <label for="username" class="form-label">Username <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="username" name="username" required>
                                        <div class="form-text">
                                            <i class="fas fa-info-circle me-1"></i>
                                            Auto-generated from name
                                        </div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="initialPassword" class="form-label">Initial Password <span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" id="initialPassword" name="initialPassword" 
                                               value="Patient123" required>
                                        <div class="form-text">
                                            <i class="fas fa-info-circle me-1"></i>
                                            Can be changed after login
                                        </div>
                                    </div>
                                </div>
                                
                                <h5 class="section-title"><i class="fas fa-notes-medical me-2"></i>Medical Information</h5>
                                
                                <div class="row g-3 mb-4">
                                    <div class="col-md-6">
                                        <label for="diagnoStatus" class="form-label">Diagnosis Status <span class="text-danger">*</span></label>
                                        <select class="form-select" id="diagnoStatus" name="diagnoStatus" required>
                                            <option value="" selected disabled>Select Diagnosis Status</option>
                                            <option value="Normal">Normal</option>
                                            <option value="Critical">Critical</option>
                                            <option value="Serious">Serious</option>
                                            <option value="Observation">Under Observation</option>
                                        </select>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="patientImage" class="form-label">Patient Image</label>
                                        <input type="file" class="form-control" id="patientImage" name="patientImage" accept="image/*">
                                        <div class="form-text">
                                            <i class="fas fa-info-circle me-1"></i>
                                            Optional photo
                                        </div>
                                    </div>
                                </div>
                                
                                <div class="mb-4">
                                    <label for="symptoms" class="form-label">Symptoms</label>
                                    <textarea class="form-control" id="symptoms" name="symptoms" rows="2"></textarea>
                                </div>
                                
                                <div class="row mb-4">
                                    <div class="col-md-6 mx-auto text-center">
                                        <div id="imagePreviewContainer" class="mt-2 mb-3"></div>
                                    </div>
                                </div>
                                
                                <div class="d-flex justify-content-between mt-4">
                                    <button type="button" class="btn btn-secondary" onclick="window.history.back();">
                                        <i class="fas fa-arrow-left me-2"></i>Cancel
                                    </button>
                                    <button type="submit" class="btn btn-primary">
                                        <i class="fas fa-save me-2"></i>Register Patient
                                    </button>
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Preview image before upload
        document.getElementById('patientImage').addEventListener('change', function(e) {
            const file = e.target.files[0];
            if (file) {
                const reader = new FileReader();
                
                // Create image preview container
                const previewContainer = document.getElementById('imagePreviewContainer');
                previewContainer.innerHTML = ''; // Clear any existing previews
                
                // Create image element
                const imagePreview = document.createElement('img');
                imagePreview.id = 'imagePreview';
                imagePreview.className = 'img-thumbnail mt-2';
                imagePreview.style.maxHeight = '200px';
                
                reader.onload = function(event) {
                    imagePreview.src = event.target.result;
                    previewContainer.appendChild(imagePreview);
                }
                
                reader.readAsDataURL(file);
            }
        });
        
        // Generate username suggestion based on first and last name
        document.getElementById('firstName').addEventListener('input', updateUsernameSuggestion);
        document.getElementById('lastName').addEventListener('input', updateUsernameSuggestion);
        
        function updateUsernameSuggestion() {
            const firstName = document.getElementById('firstName').value.trim();
            const lastName = document.getElementById('lastName').value.trim();
            
            if (firstName && lastName) {
                // Generate username suggestion (first letter of first name + last name in lowercase)
                const suggestion = (firstName.charAt(0) + lastName).toLowerCase().replace(/\s+/g, '');
                
                // Only update if the field is empty or contains a previously generated suggestion
                const usernameField = document.getElementById('username');
                if (!usernameField.value || usernameField.value.match(/^[a-z][a-z]*$/)) {
                    usernameField.value = suggestion;
                }
            }
        }
        
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