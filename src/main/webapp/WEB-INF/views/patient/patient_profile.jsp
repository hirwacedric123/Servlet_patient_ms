<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>My Profile - Patient Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <style>
        .profile-header {
            background-color: #f8f9fa;
            padding: 20px;
            border-radius: 10px;
            margin-bottom: 20px;
        }
        .profile-pic {
            width: 150px;
            height: 150px;
            object-fit: cover;
            border-radius: 50%;
            border: 5px solid #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .profile-placeholder {
            width: 150px;
            height: 150px;
            display: flex;
            align-items: center;
            justify-content: center;
            border-radius: 50%;
            background-color: #e9ecef;
            color: #6c757d;
            font-size: 4rem;
        }
        .form-label {
            font-weight: 600;
            color: #495057;
        }
        .required-field::after {
            content: " *";
            color: #dc3545;
        }
        .animated-card {
            animation: fadeIn 0.5s ease-out;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }
        /* Fixed Sidebar Styles */
        .sidebar {
            position: fixed;
            top: 0;
            bottom: 0;
            left: 0;
            z-index: 100;
            padding: 48px 0 0;
            box-shadow: inset -1px 0 0 rgba(0, 0, 0, .1);
            background-color: #343a40;
        }
        .sidebar-link {
            display: block;
            padding: 0.5rem 1rem;
            color: #fff;
            text-decoration: none;
            transition: all 0.3s;
        }
        .sidebar-link:hover {
            background-color: rgba(255, 255, 255, 0.1);
            color: #fff;
        }
        .sidebar-link.active {
            background-color: rgba(255, 255, 255, 0.2);
            color: #fff;
        }
        .content-area {
            margin-left: 250px;
        }
        @media (max-width: 767.98px) {
            .sidebar {
                position: static;
                padding-top: 0;
            }
            .content-area {
                margin-left: 0;
            }
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block bg-dark sidebar collapse">
                <div class="position-sticky">
                    <div class="text-center mb-4 mt-3">
                        <i class="fas fa-hospital text-light fa-3x mb-3"></i>
                        <h5 class="text-light">Patient Management System</h5>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/patient/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link" href="${pageContext.request.contextPath}/patient/diagnoses">
                                <i class="fas fa-stethoscope me-2"></i>My Diagnoses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="sidebar-link active" href="${pageContext.request.contextPath}/patient/profile">
                                <i class="fas fa-user-circle me-2"></i>My Profile
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
                            <div class="user-info">
                                <i class="fas fa-user-circle me-1"></i>${patient.firstName} ${patient.lastName}
                            </div>
                        </div>
                    </div>
                </nav>

                <!-- Messages -->
                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger alert-dismissible fade show animated-card mb-4" role="alert">
                        <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                </c:if>
                
                <c:if test="${not empty sessionScope.successMessage}">
                    <div class="alert alert-success alert-dismissible fade show animated-card mb-4" role="alert">
                        <i class="fas fa-check-circle me-2"></i>${sessionScope.successMessage}
                        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                    </div>
                    <c:remove var="successMessage" scope="session" />
                </c:if>

                <!-- Profile Header -->
                <div class="profile-header shadow-sm animated-card">
                    <div class="row align-items-center">
                        <div class="col-md-3 text-center">
                            <c:choose>
                                <c:when test="${not empty patient.profileImage}">
                                    <img src="${pageContext.request.contextPath}${patient.profileImage}" alt="Profile Picture" class="profile-pic">
                                </c:when>
                                <c:otherwise>
                                    <div class="profile-placeholder">
                                        <i class="fas fa-user"></i>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="col-md-9">
                            <h2 class="mb-1">${patient.firstName} ${patient.lastName}</h2>
                            <p class="text-muted mb-2">
                                <i class="fas fa-id-card me-2"></i>Patient ID: ${patient.patientID}
                            </p>
                            <p class="mb-0">Please complete your profile information below. Fields marked with * are required.</p>
                        </div>
                    </div>
                </div>

                <!-- Profile Form -->
                <div class="card shadow-sm animated-card mb-4">
                    <div class="card-header bg-white">
                        <h5 class="mb-0"><i class="fas fa-user-edit me-2"></i>Edit Profile</h5>
                    </div>
                    <div class="card-body">
                        <form action="${pageContext.request.contextPath}/patient/profile" method="POST" enctype="multipart/form-data">
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="firstName" class="form-label required-field">First Name</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" value="${patient.firstName}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="lastName" class="form-label required-field">Last Name</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" value="${patient.lastName}" required>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="gender" class="form-label">Gender</label>
                                    <select class="form-select" id="gender" name="gender">
                                        <option value="" ${empty patient.gender ? 'selected' : ''}>Select Gender</option>
                                        <option value="Male" ${patient.gender == 'Male' ? 'selected' : ''}>Male</option>
                                        <option value="Female" ${patient.gender == 'Female' ? 'selected' : ''}>Female</option>
                                        <option value="Other" ${patient.gender == 'Other' ? 'selected' : ''}>Other</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                    <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" 
                                           value="<fmt:formatDate value="${patient.dateOfBirth}" pattern="yyyy-MM-dd" />">
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="contactNumber" class="form-label required-field">Contact Number</label>
                                    <input type="tel" class="form-control" id="contactNumber" name="contactNumber" value="${patient.contactNumber}" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="email" class="form-label required-field">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" value="${patient.email}" required>
                                </div>
                            </div>
                            
                            <div class="mb-3">
                                <label for="address" class="form-label">Address</label>
                                <textarea class="form-control" id="address" name="address" rows="2">${patient.address}</textarea>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="bloodGroup" class="form-label">Blood Group</label>
                                    <select class="form-select" id="bloodGroup" name="bloodGroup">
                                        <option value="" ${empty patient.bloodGroup ? 'selected' : ''}>Select Blood Group</option>
                                        <option value="A+" ${patient.bloodGroup == 'A+' ? 'selected' : ''}>A+</option>
                                        <option value="A-" ${patient.bloodGroup == 'A-' ? 'selected' : ''}>A-</option>
                                        <option value="B+" ${patient.bloodGroup == 'B+' ? 'selected' : ''}>B+</option>
                                        <option value="B-" ${patient.bloodGroup == 'B-' ? 'selected' : ''}>B-</option>
                                        <option value="AB+" ${patient.bloodGroup == 'AB+' ? 'selected' : ''}>AB+</option>
                                        <option value="AB-" ${patient.bloodGroup == 'AB-' ? 'selected' : ''}>AB-</option>
                                        <option value="O+" ${patient.bloodGroup == 'O+' ? 'selected' : ''}>O+</option>
                                        <option value="O-" ${patient.bloodGroup == 'O-' ? 'selected' : ''}>O-</option>
                                    </select>
                                </div>
                                <div class="col-md-6">
                                    <label for="emergencyContact" class="form-label">Emergency Contact</label>
                                    <input type="tel" class="form-control" id="emergencyContact" name="emergencyContact" value="${patient.emergencyContact}">
                                </div>
                            </div>
                            
                            <div class="mb-4">
                                <label for="profileImage" class="form-label">Profile Image</label>
                                <input type="file" class="form-control" id="profileImage" name="profileImage" accept="image/*">
                                <div class="form-text">
                                    <small>Upload a profile image (optional). Maximum size: 10MB. Supported formats: JPG, PNG, GIF.</small>
                                </div>
                            </div>
                            
                            <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                                <button type="reset" class="btn btn-outline-secondary me-md-2">Reset</button>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </main>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-2">
        <p class="mb-0">&copy; 2025 Patient Management System | Patient Profile</p>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 