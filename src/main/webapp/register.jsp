<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Ro'yxatdan o'tish | Digital Library</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <style>
        body {
            background: linear-gradient(rgba(10, 15, 29, 0.8), rgba(10, 15, 29, 0.9)),
            url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=2000&q=80') center/cover no-repeat fixed;
            min-height: 100vh; display: flex; align-items: center; justify-content: center;
            font-family: 'Inter', sans-serif; color: #f8fafc;
        }
        .glass-card {
            background: rgba(15, 23, 42, 0.7); backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15); border-radius: 24px;
            box-shadow: 0 25px 50px rgba(0, 0, 0, 0.5); padding: 3rem; width: 100%; max-width: 480px;
        }
        .glass-input {
            background: rgba(255, 255, 255, 0.05) !important; border: 1px solid rgba(255, 255, 255, 0.2) !important;
            color: #ffffff !important; border-radius: 12px; padding: 12px 15px;
        }
        .glass-input:focus {
            background: rgba(255, 255, 255, 0.1) !important; border-color: #3b82f6 !important;
            box-shadow: 0 0 0 0.25rem rgba(59, 130, 246, 0.25) !important;
        }
        .btn-primary { background-color: #3b82f6; border: none; border-radius: 12px; padding: 12px; font-weight: 600; }
        .btn-primary:hover { background-color: #2563eb; }
    </style>
</head>
<body>

<div class="glass-card">
    <div class="text-center mb-4">
        <span style="font-size: 3rem;">📝</span>
        <h2 class="fw-bold mt-2">Ro'yxatdan O'tish</h2>
        <p class="text-white-50">Kutubxona fondiga qo'shilish uchun akkaunt yarating</p>
    </div>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger bg-danger bg-opacity-25 text-white border-danger border-opacity-50" role="alert">
                ${errorMessage}
        </div>
    </c:if>

    <form action="${pageContext.request.contextPath}/register" method="POST">
        <div class="mb-3">
            <label class="form-label text-white-50 small">To'liq ismingiz</label>
            <input type="text" name="fullname" id="fullname" class="form-control glass-input" autocomplete="name" required autofocus>
        </div>
        <div class="mb-3">
            <label class="form-label text-white-50 small">Foydalanuvchi nomi (Username)</label>
            <input type="text" name="username" id="username" class="form-control glass-input" autocomplete="username" required>
        </div>
        <div class="mb-4">
            <label class="form-label text-white-50 small">Parol o'rnating</label>
            <input type="password" name="password" id="password" class="form-control glass-input" autocomplete="new-password" required>
        </div>
        <button type="submit" class="btn btn-primary w-100 mb-3">Akkaunt yaratish</button>

        <div class="text-center">
            <span class="text-white-50 small">Allaqachon hisobingiz bormi?</span>
            <a href="${pageContext.request.contextPath}/login" class="text-primary text-decoration-none small fw-bold">Kirish</a>
        </div>
    </form>
</div>

</body>
</html>