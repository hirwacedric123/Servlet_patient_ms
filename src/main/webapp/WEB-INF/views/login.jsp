<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login - Patient Management System</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card {
            border-radius: 8px;
            overflow: hidden;
            max-width: 600px;
            margin: 0 auto;
            box-shadow: 0 4px 12px rgba(0,0,0,0.15);
        }
        .card-header {
            background-color: #2c3e50;
            padding: 25px 20px;
        }
        .btn-primary {
            background-color: #2c3e50;
            border-color: #2c3e50;
        }
        .btn-primary:hover, .btn-primary:focus {
            background-color: #1a252f;
            border-color: #1a252f;
        }
        .input-group-text {
            background-color: #f8f9fa;
        }
        .register-section {
            margin-top: 30px;
            text-align: center;
            padding: 15px;
            background-color: #f1f8ff;
            border-radius: 8px;
            border: 1px solid #d1e9ff;
        }
        .register-buttons {
            margin-top: 15px;
        }
        .or-divider {
            margin: 30px 0;
            text-align: center;
            position: relative;
        }
        .or-divider:before {
            content: '';
            position: absolute;
            top: 50%;
            left: 0;
            right: 0;
            border-top: 1px solid #ccc;
            z-index: 1;
        }
        .or-divider span {
            background-color: #fff;
            padding: 0 15px;
            position: relative;
            z-index: 2;
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="row justify-content-center mt-5">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header text-white text-center">
                        <h3><i class="fas fa-hospital-user me-2"></i>Patient Management System</h3>
                        <p class="mb-0">Login to your account</p>
                    </div>
                    <div class="card-body py-4">
                        <% if(request.getAttribute("errorMessage") != null) { %>
                            <div class="alert alert-danger" role="alert">
                                <%= request.getAttribute("errorMessage") %>
                            </div>
                        <% } %>
                        
                        <% if(session.getAttribute("message") != null) { %>
                            <div class="alert alert-success" role="alert">
                                <%= session.getAttribute("message") %>
                                <% session.removeAttribute("message"); %>
                            </div>
                        <% } %>
                        
                        <form action="${pageContext.request.contextPath}/login" method="post">
                            <div class="mb-3">
                                <label for="username" class="form-label">Username</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-user"></i></span>
                                    <input type="text" class="form-control" id="username" name="username" required>
                                </div>
                            </div>
                            <div class="mb-3">
                                <label for="password" class="form-label">Password</label>
                                <div class="input-group">
                                    <span class="input-group-text"><i class="fas fa-lock"></i></span>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                            </div>
                            <div class="d-grid">
                                <button type="submit" class="btn btn-primary btn-lg">
                                    <i class="fas fa-sign-in-alt me-2"></i>Login
                                </button>
                            </div>
                        </form>
                        
                        <div class="or-divider">
                            <span>OR</span>
                        </div>
                        
                        <div class="register-section">
                            <h5><i class="fas fa-user-plus me-2"></i>Don't have an account?</h5>
                            <p>Create a new account to access our services</p>
                            <div class="register-buttons">
                                <a href="${pageContext.request.contextPath}/register?type=patient" class="btn btn-success me-2">
                                    <i class="fas fa-user me-1"></i>Register as Patient
                                </a>
                                <a href="${pageContext.request.contextPath}/register?type=doctor" class="btn btn-info">
                                    <i class="fas fa-user-md me-1"></i>Register as Doctor
                                </a>
                            </div>
                        </div>
                    </div>
                    <div class="card-footer text-center py-3">
                        <small class="text-muted">&copy; 2025 Patient Management System</small>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 5