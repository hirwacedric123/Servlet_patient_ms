<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Manage Doctors - Patient Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        .sidebar {
            min-height: 100vh;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .sidebar .nav-link {
            color: #f8f9fa;
            padding: 0.8rem 1rem;
            border-radius: 0.25rem;
            margin: 0.2rem 0;
        }
        .sidebar .nav-link:hover {
            background-color: rgba(255,255,255,0.1);
        }
        .sidebar .nav-link.active {
            background-color: #0d6efd;
        }
        .content-header {
            background: linear-gradient(135deg, #2c3e50 0%, #3498db 100%);
            color: white;
            padding: 2rem;
            border-radius: 10px;
            margin-bottom: 2rem;
        }
        .doctor-card {
            transition: transform 0.3s;
        }
        .doctor-card:hover {
            transform: translateY(-5px);
        }
    </style>
</head>
<body>
    <div class="container-fluid">
        <div class="row">
            <!-- Sidebar -->
            <div class="col-md-3 col-lg-2 d-md-block bg-dark sidebar">
                <div class="position-sticky pt-3">
                    <div class="text-center mb-4">
                        <i class="fas fa-hospital text-light fa-3x mb-2"></i>
                        <h6 class="text-light">Patient Management System</h6>
                    </div>
                    <ul class="nav flex-column">
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/dashboard">
                                <i class="fas fa-tachometer-alt me-2"></i>Dashboard
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link active" href="${pageContext.request.contextPath}/admin/doctors">
                                <i class="fas fa-user-md me-2"></i>Manage Doctors
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/nurses">
                                <i class="fas fa-user-nurse me-2"></i>Manage Nurses
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/patients">
                                <i class="fas fa-procedures me-2"></i>Manage Patients
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/appointments">
                                <i class="fas fa-calendar-check me-2"></i>Appointments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/departments">
                                <i class="fas fa-hospital-alt me-2"></i>Departments
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/users">
                                <i class="fas fa-users-cog me-2"></i>User Management
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/admin/profile">
                                <i class="fas fa-user-circle me-2"></i>Profile
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="${pageContext.request.contextPath}/logout">
                                <i class="fas fa-sign-out-alt me-2"></i>Logout
                            </a>
                        </li>
                    </ul>
                </div>
            </div>

            <!-- Main content -->
            <div class="col-md-9 col-lg-10 ms-sm-auto px-md-4 py-4">
                <!-- Content Header -->
                <div class="content-header">
                    <div class="d-flex justify-content-between align-items-center">
                        <div>
                            <h2><i class="fas fa-user-md me-2"></i>Manage Doctors</h2>
                            <p class="mb-0">View, add, edit, and manage doctor records.</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/admin/doctors/add" class="btn btn-light">
                            <i class="fas fa-plus me-2"></i>Add New Doctor
                        </a>
                    </div>
                </div>

                <!-- Search and Filter -->
                <div class="card shadow-sm mb-4">
                    <div class="card-body">
                        <form class="row g-3">
                            <div class="col-md-4">
                                <input type="text" class="form-control" placeholder="Search by name...">
                            </div>
                            <div class="col-md-3">
                                <select class="form-select">
                                    <option value="">All Specializations</option>
                                    <option value="Cardiology">Cardiology</option>
                                    <option value="Neurology">Neurology</option>
                                    <option value="Pediatrics">Pediatrics</option>
                                    <option value="Orthopedics">Orthopedics</option>
                                </select>
                            </div>
                            <div class="col-md-3">
                                <select class="form-select">
                                    <option value="">All Status</option>
                                    <option value="active">Active</option>
                                    <option value="inactive">Inactive</option>
                                </select>
                            </div>
                            <div class="col-md-2">
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="fas fa-search me-2"></i>Search
                                </button>
                            </div>
                        </form>
                    </div>
                </div>

                <!-- Doctors List -->
                <div class="row g-4">
                    <c:forEach items="${doctors}" var="doctor">
                        <div class="col-md-6 col-lg-4">
                            <div class="card doctor-card shadow-sm h-100">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center mb-3">
                                        <h5 class="card-title mb-0">${doctor.name}</h5>
                                        <span class="badge bg-${doctor.active ? 'success' : 'danger'}">
                                            ${doctor.active ? 'Active' : 'Inactive'}
                                        </span>
                                    </div>
                                    <p class="text-muted mb-2">
                                        <i class="fas fa-stethoscope me-2"></i>${doctor.specialization}
                                    </p>
                                    <p class="mb-2">
                                        <i class="fas fa-envelope me-2"></i>${doctor.email}
                                    </p>
                                    <p class="mb-2">
                                        <i class="fas fa-phone me-2"></i>${doctor.phone}
                                    </p>
                                    <p class="mb-3">
                                        <i class="fas fa-map-marker-alt me-2"></i>${doctor.address}
                                    </p>
                                    <div class="d-flex justify-content-end gap-2">
                                        <a href="${pageContext.request.contextPath}/admin/doctors/edit?id=${doctor.id}" 
                                           class="btn btn-sm btn-primary">
                                            <i class="fas fa-edit me-1"></i>Edit
                                        </a>
                                        <button type="button" class="btn btn-sm btn-danger" 
                                                onclick="confirmDelete(${doctor.id})">
                                            <i class="fas fa-trash-alt me-1"></i>Delete
                                        </button>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div class="modal fade" id="deleteModal" tabindex="-1">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Confirm Delete</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    Are you sure you want to delete this doctor? This action cannot be undone.
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <form id="deleteForm" method="POST" style="display: inline;">
                        <input type="hidden" name="_method" value="DELETE">
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>
                </div>
            </div>
        </div>
    </div>

    <!-- Scripts -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        function confirmDelete(doctorId) {
            const modal = new bootstrap.Modal(document.getElementById('deleteModal'));
            const form = document.getElementById('deleteForm');
            form.action = '${pageContext.request.contextPath}/admin/doctors/delete?id=' + doctorId;
            modal.show();
        }
    </script>
</body>
</html> 