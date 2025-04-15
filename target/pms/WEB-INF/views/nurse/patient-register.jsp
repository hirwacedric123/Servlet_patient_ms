<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../common/header.jsp">
    <jsp:param name="title" value="Register Patient" />
</jsp:include>

<div class="container mt-4">
    <div class="row">
        <div class="col-md-12">
            <nav aria-label="breadcrumb">
                <ol class="breadcrumb">
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/nurse/dashboard">Dashboard</a></li>
                    <li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/nurse/patients">Patients</a></li>
                    <li class="breadcrumb-item active" aria-current="page">Register Patient</li>
                </ol>
            </nav>
            
            <c:if test="${not empty errorMessage}">
                <div class="alert alert-danger alert-dismissible fade show" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i>${errorMessage}
                    <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
                </div>
            </c:if>
            
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i>Register New Patient</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/nurse/register-patient" method="post" enctype="multipart/form-data">
                        <h5 class="border-bottom pb-2 mb-3">Personal Information</h5>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="firstName" class="form-label">First Name *</label>
                                <input type="text" class="form-control" id="firstName" name="firstName" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="lastName" class="form-label">Last Name *</label>
                                <input type="text" class="form-control" id="lastName" name="lastName" required>
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="gender" class="form-label">Gender *</label>
                                <select class="form-select" id="gender" name="gender" required>
                                    <option value="" selected disabled>Select Gender</option>
                                    <option value="Male">Male</option>
                                    <option value="Female">Female</option>
                                    <option value="Other">Other</option>
                                </select>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="contactNumber" class="form-label">Contact Number *</label>
                                <input type="tel" class="form-control" id="contactNumber" name="contactNumber" required>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email">
                            </div>
                        </div>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="emergencyContact" class="form-label">Emergency Contact</label>
                                <input type="tel" class="form-control" id="emergencyContact" name="emergencyContact">
                            </div>
                            <div class="col-md-6 mb-3">
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
                        
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <textarea class="form-control" id="address" name="address" rows="3"></textarea>
                        </div>
                        
                        <h5 class="border-bottom pb-2 mb-3 mt-4">Account Information</h5>
                        
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label for="username" class="form-label">Username *</label>
                                <input type="text" class="form-control" id="username" name="username" required>
                                <div class="form-text">Choose a unique username that the patient can remember easily.</div>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="initialPassword" class="form-label">Initial Password *</label>
                                <input type="text" class="form-control" id="initialPassword" name="initialPassword" 
                                       value="Patient123" required>
                                <div class="form-text">Patient can change this password after first login.</div>
                            </div>
                        </div>
                        
                        <h5 class="border-bottom pb-2 mb-3 mt-4">Medical Information</h5>
                        
                        <div class="mb-3">
                            <label for="diagnoStatus" class="form-label">Diagnosis Status *</label>
                            <select class="form-select" id="diagnoStatus" name="diagnoStatus" required>
                                <option value="" selected disabled>Select Diagnosis Status</option>
                                <option value="Normal">Normal</option>
                                <option value="Critical">Critical</option>
                                <option value="Serious">Serious</option>
                                <option value="Observation">Under Observation</option>
                            </select>
                        </div>
                        
                        <div class="mb-3">
                            <label for="symptoms" class="form-label">Symptoms</label>
                            <textarea class="form-control" id="symptoms" name="symptoms" rows="3"></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="patientImage" class="form-label">Patient Image</label>
                            <input type="file" class="form-control" id="patientImage" name="patientImage" accept="image/*">
                            <div class="form-text">Upload a photo of the patient (optional).</div>
                            <div id="imagePreviewContainer" class="mt-2"></div>
                        </div>
                        
                        <div class="mt-4 mb-3">
                            <div class="d-flex justify-content-between">
                                <button type="button" class="btn btn-secondary" onclick="window.history.back();">
                                    <i class="fas fa-arrow-left me-2"></i>Cancel
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <i class="fas fa-save me-2"></i>Register Patient
                                </button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

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
    document.getElementById('firstName').addEventListener('change', updateUsernameSuggestion);
    document.getElementById('lastName').addEventListener('change', updateUsernameSuggestion);
    
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
</script>

<jsp:include page="../common/footer.jsp" /> 