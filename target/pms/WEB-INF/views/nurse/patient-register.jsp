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
            
            <div class="card">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0"><i class="fas fa-user-plus me-2"></i>Register New Patient</h5>
                </div>
                <div class="card-body">
                    <form action="${pageContext.request.contextPath}/nurse/patients/register" method="post" enctype="multipart/form-data">
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
                                <label for="telephone" class="form-label">Telephone</label>
                                <input type="tel" class="form-control" id="telephone" name="telephone">
                            </div>
                            <div class="col-md-6 mb-3">
                                <label for="email" class="form-label">Email</label>
                                <input type="email" class="form-control" id="email" name="email">
                            </div>
                        </div>
                        
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <textarea class="form-control" id="address" name="address" rows="3"></textarea>
                        </div>
                        
                        <div class="mb-3">
                            <label for="patientImage" class="form-label">Patient Image</label>
                            <input type="file" class="form-control" id="patientImage" name="patientImage" accept="image/*">
                            <div class="form-text">Upload a photo of the patient (optional).</div>
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
            
            // Create image preview if it doesn't exist
            let imagePreview = document.getElementById('imagePreview');
            if (!imagePreview) {
                imagePreview = document.createElement('img');
                imagePreview.id = 'imagePreview';
                imagePreview.className = 'img-thumbnail mt-2 image-preview';
                e.target.parentNode.appendChild(imagePreview);
            }
            
            reader.onload = function(event) {
                imagePreview.src = event.target.result;
            }
            
            reader.readAsDataURL(file);
        }
    });
</script>

<jsp:include page="../common/footer.jsp" /> 