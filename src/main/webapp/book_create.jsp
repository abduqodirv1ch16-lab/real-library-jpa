<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Yangi kitob qo'shish | Digital Library</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background: linear-gradient(rgba(10, 15, 29, 0.85), rgba(10, 15, 29, 0.95)),
            url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=2000&q=80') center/cover fixed;
            min-height: 100vh; font-family: 'Inter', sans-serif; color: #fff;
            display: flex; align-items: center; justify-content: center; position: relative; padding: 40px 0;
        }
        .top-left-back {
            position: absolute; top: 25px; left: 30px;
            background: rgba(59, 130, 246, 0.25); border: 1px solid rgba(59, 130, 246, 0.5);
            color: #60a5fa; padding: 8px 18px; border-radius: 50px; font-weight: 600;
            text-decoration: none; display: flex; align-items: center; gap: 8px; transition: 0.2s;
            backdrop-filter: blur(10px);
        }
        .top-left-back:hover { background: rgba(59, 130, 246, 0.45); color: #fff; }

        .glass-panel {
            background: rgba(15, 23, 42, 0.75); backdrop-filter: blur(25px);
            border: 1px solid rgba(255, 255, 255, 0.15); border-radius: 24px;
            box-shadow: 0 30px 60px rgba(0, 0, 0, 0.6); padding: 40px; width: 100%; max-width: 550px;
        }
        .form-control {
            background: rgba(255, 255, 255, 0.05); border: 1px solid rgba(255, 255, 255, 0.15);
            color: #fff; border-radius: 12px; padding: 12px 16px;
        }
        .form-control::placeholder { color: rgba(255, 255, 255, 0.25) !important; font-weight: 300; }
        .form-control:focus { background: rgba(255, 255, 255, 0.1); border-color: #3b82f6; box-shadow: none; color: #fff; }
        .form-label { color: #cbd5e1; font-weight: 500; font-size: 0.9rem; }
    </style>
</head>
<body>

<a href="javascript:history.back()" class="top-left-back">
    <i class="bi bi-arrow-left"></i> Ortga
</a>

<div class="container d-flex justify-content-center">
    <div class="glass-panel">
        <div class="text-center mb-4">
            <span style="font-size: 3rem;">📖</span>
            <h2 class="fw-bold mt-2 text-white">Yangi Kitob</h2>
            <p class="text-white-50">Kutubxona fondiga yangi asar qo'shish</p>
        </div>

        <form action="${pageContext.request.contextPath}/book/create" method="POST" enctype="multipart/form-data">
            <div class="row">
                <div class="col-md-6 mb-3">
                    <label class="form-label">Kitob nomi *</label>
                    <input type="text" name="title" class="form-control" placeholder="Masalan: Ufq" required>
                </div>
                <div class="col-md-6 mb-3">
                    <label class="form-label">Muallifi *</label>
                    <input type="text" name="author" class="form-control" placeholder="O'tkir Hoshimov" required>
                </div>
            </div>

            <div class="mb-3">
                <label class="form-label">Sahifalar soni *</label>
                <input type="number" name="pages" class="form-control" placeholder="Masalan: 450" required>
            </div>

            <div class="mb-3">
                <label class="form-label text-info">Elektron nusxasi (PDF) * majburiy</label>
                <input type="file" name="pdfFile" class="form-control" accept="application/pdf" required>
            </div>

            <div class="mb-4">
                <label class="form-label text-warning">Muqova rasmi (Ixtiyoriy)</label>
                <input type="file" name="coverImage" class="form-control" accept="image/*">
            </div>

            <button type="submit" class="btn btn-primary w-100 py-3 rounded-3 fw-bold fs-5 shadow">Tizimga Saqlash</button>
        </form>
    </div>
</div>

</body>
</html>