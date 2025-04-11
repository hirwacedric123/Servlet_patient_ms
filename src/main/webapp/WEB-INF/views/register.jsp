<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register - Patient Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body class="bg-light">
    <div class="container">
        <div class="row justify-content-center mt-4">
            <div class="col-md-8">
                <div class="card shadow">
                    <div class="card-header bg-primary text-white text-center">
                        <h3><i class="fas fa-user-plus me-2"></i>Register New Account</h3>
                        <p class="mb-0">
                            <c:choose>
                                <c:when test="${userType eq 'doctor'}">Doctor Registration</c:when>
                                <c:when test="${userType eq 'patient'}">Patient Registration</c:when>
                                <c:otherwise>User Registration</c:otherwise>
                            </c:choose>
                        </p>
                    </div>
                    <div class="card-body">
                        <c:if test="${not empty errorMessage}">
                            <div class="alert alert-danger" role="alert">
                                ${errorMessage}
                            </div>
                        </c:if>
                        
                        <form action="${pageContext.request.contextPath}/register" method="post" class="needs-validation" novalidate>
                            <input type="hidden" name="userType" value="${userType eq 'doctor' ? 'Doctor' : 'Patient'}" />
                            
                            <!-- Common fields for all users -->
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="username" class="form-label">Username*</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-user"></i></span>
                                        <input type="text" class="form-control" id="username" name="username" required>
                                        <div class="invalid-feedback">Username is required</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="password" class="form-label">Password*</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                        <input type="password" class="form-control" id="password" name="password" required
                                               pattern="^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).{8,}$">
                                        <div class="invalid-feedback">
                                            Password must be at least 8 characters and include uppercase, lowercase, and numbers
                                        </div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Common fields for all users -->
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="firstName" class="form-label">First Name*</label>
                                    <input type="text" class="form-control" id="firstName" name="firstName" required>
                                    <div class="invalid-feedback">First name is required</div>
                                </div>
                                <div class="col-md-6">
                                    <label for="lastName" class="form-label">Last Name*</label>
                                    <input type="text" class="form-control" id="lastName" name="lastName" required>
                                    <div class="invalid-feedback">Last name is required</div>
                                </div>
                            </div>
                            
                            <div class="row mb-3">
                                <div class="col-md-6">
                                    <label for="email" class="form-label">Email*</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-envelope"></i></span>
                                        <input type="email" class="form-control" id="email" name="email" required>
                                        <div class="invalid-feedback">Valid email is required</div>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <label for="contactNumber" class="form-label">Contact Number*</label>
                                    <div class="input-group">
                                        <span class="input-group-text"><i class="fas fa-phone"></i></span>
                                        <input type="tel" class="form-control" id="contactNumber" name="contactNumber" required>
                                        <div class="invalid-feedback">Contact number is required</div>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- Doctor-specific fields -->
                            <c:if test="${userType eq 'doctor'}">
                                <div class="row mb-3">
                                    <div class="col-md-12">
                                        <label for="specialization" class="form-label">Specialization*</label>
                                        <select class="form-select" id="specialization" name="specialization" required>
                                            <option value="">Select Specialization</option>
                                            <option value="Cardiology">Cardiology</option>
                                            <option value="Dermatology">Dermatology</option>
                                            <option value="Neurology">Neurology</option>
                                            <option value="Orthopedics">Orthopedics</option>
                                            <option value="Pediatrics">Pediatrics</option>
                                            <option value="Psychiatry">Psychiatry</option>
                                            <option value="General Medicine">General Medicine</option>
                                        </select>
                                        <div class="invalid-feedback">Please select a specialization</div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="address" class="form-label">Address*</label>
                                    <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                                    <div class="invalid-feedback">Address is required</div>
                                </div>
                            </c:if>
                            
                            <!-- Patient-specific fields -->
                            <c:if test="${userType eq 'patient'}">
                                <div class="row mb-3">
                                    <div class="col-md-6">
                                        <label for="dateOfBirth" class="form-label">Date of Birth*</label>
                                        <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" required>
                                        <div class="invalid-feedback">Date of birth is required</div>
                                    </div>
                                    <div class="col-md-6">
                                        <label for="gender" class="form-label">Gender*</label>
                                        <select class="form-select" id="gender" name="gender" required>
                                            <option value="">Select Gender</option>
                                            <option value="Male">Male</option>
                                            <option value="Female">Female</option>
                                            <option value="Other">Other</option>
                                        </select>
                                        <div class="invalid-feedback">Please select a gender</div>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="address" class="form-label">Address*</label>
                                    <textarea class="form-control" id="address" name="address" rows="3" required></textarea>
                                    <div class="invalid-feedback">Address is required</div>
                                </div>
                            </c:if>
                            
                            <div class="d-grid gap-2">
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-user-plus me-2"></i>Register
                                </button>
                                <a href="${pageContext.request.contextPath}/login" class="btn btn-secondary">
                                    <i class="fas fa-arrow-left me-2"></i>Back to Login
                                </a>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Bootstrap form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html> 