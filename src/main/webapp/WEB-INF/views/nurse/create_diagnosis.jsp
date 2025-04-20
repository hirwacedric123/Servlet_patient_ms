<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Create Diagnosis</title>
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
        .welcome-banner {
            background-color: #3498db;
            color: white;
            padding: 20px;
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .patient-info {
            background-color: #f8f9fa;
            padding: 15px;
            border-radius: 5px;
            margin-bottom: 20px;
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
                        <a class="nav-link" href="${pageContext.request.contextPath}/nurse/dashboard">
                            <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/nurse/patient-registration">
                            <i class="fas fa-user-plus me-1"></i>Register Patient
                        </a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="${pageContext.request.contextPath}/nurse/patients">
                            <i class="fas fa-procedures me-1"></i>My Patients
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
        <c:if test="${not empty errorMessage}">
            <div class="alert alert-danger">
                <i class="fas fa-exclamation-triangle me-2"></i>${errorMessage}
            </div>
        </c:if>
        
        <div class="card">
            <div class="card-header">
                <h4><i class="fas fa-stethoscope me-2"></i>Create Diagnosis</h4>
            </div>
            <div class="card-body">
                <!-- Patient Information -->
                <div class="patient-info">
                    <h5>Patient Information</h5>
                    <div class="row">
                        <div class="col-md-6">
                            <p><strong>Name:</strong> ${patient.firstName} ${patient.lastName}</p>
                            <p><strong>Gender:</strong> ${patient.gender}</p>
                            <p><strong>Age:</strong> ${patient.age}</p>
                        </div>
                        <div class="col-md-6">
                            <p><strong>Contact:</strong> ${patient.contactNumber}</p>
                            <p><strong>Email:</strong> ${patient.email}</p>
                            <p><strong>Blood Group:</strong> ${patient.bloodGroup}</p>
                        </div>
                    </div>
                </div>

                <!-- Diagnosis Form -->
                <form action="${pageContext.request.contextPath}/nurse/create-diagnosis" method="post">
                    <input type="hidden" name="patientId" value="${patient.patientID}">
                    
                    <div class="mb-3">
                        <label for="diagnosisStatus" class="form-label">Diagnosis Status <span class="text-danger">*</span></label>
                        <select class="form-select" id="diagnosisStatus" name="diagnosisStatus" required onchange="toggleDoctorField()">
                            <option value="" selected disabled>Select status</option>
                            <option value="Referrable">Referrable (requires doctor review)</option>
                            <option value="Not Referrable">Not Referrable (no further review needed)</option>
                        </select>
                        <div class="form-text">
                            <strong>Referrable:</strong> The patient's case requires a doctor's review. Result will be set to "Pending" until reviewed.<br>
                            <strong>Not Referrable:</strong> The patient's case does not require further review. Result will be set to "Negative".
                        </div>
                    </div>
                    
                    <div class="mb-3" id="doctorField" style="display: none;">
                        <label for="doctorId" class="form-label">Assign Doctor <span class="text-danger">*</span></label>
                        <select class="form-select" id="doctorId" name="doctorId">
                            <option value="" selected disabled>Select a doctor</option>
                            <c:forEach items="${doctors}" var="doctor">
                                <option value="${doctor.doctorID}">${doctor.firstName} ${doctor.lastName}</option>
                            </c:forEach>
                        </select>
                        <div class="form-text">Select a doctor to review this case.</div>
                    </div>
                    
                    <div class="mb-3">
                        <label for="symptoms" class="form-label">Symptoms / Notes</label>
                        <textarea class="form-control" id="symptoms" name="symptoms" rows="4" placeholder="Enter patient symptoms and relevant notes"></textarea>
                        <div class="form-text">Provide information about the patient's symptoms and any relevant notes.</div>
                    </div>
                    
                    <div class="d-grid gap-2 d-md-flex justify-content-md-end">
                        <a href="${pageContext.request.contextPath}/nurse/dashboard" class="btn btn-secondary me-md-2">
                            <i class="fas fa-times me-1"></i>Cancel
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save me-1"></i>Create Diagnosis
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <!-- Footer -->
    <footer class="bg-dark text-white text-center py-3 mt-5">
        <p class="mb-0">&copy; 2025 Patient Management System</p>
    </footer>

    <!-- JavaScript -->
    <script>
        function toggleDoctorField() {
            const diagnosisStatus = document.getElementById('diagnosisStatus').value;
            const doctorField = document.getElementById('doctorField');
            
            if (diagnosisStatus === 'Referrable') {
                doctorField.style.display = 'block';
                document.getElementById('doctorId').setAttribute('required', 'required');
            } else {
                doctorField.style.display = 'none';
                document.getElementById('doctorId').removeAttribute('required');
            }
        }
    </script>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 