<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Saqlangan Kitoblar | Digital Library</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background: linear-gradient(rgba(10, 15, 29, 0.85), rgba(10, 15, 29, 0.95)),
            url('https://images.unsplash.com/photo-1507842217343-583bb7270b66?auto=format&fit=crop&w=2000&q=80') center/cover fixed;
            min-height: 100vh; font-family: 'Inter', sans-serif; color: #f8fafc; padding-top: 100px;
        }
        .top-left-back {
            position: fixed; top: 25px; left: 30px; z-index: 1050;
            background: rgba(59, 130, 246, 0.25); border: 1px solid rgba(59, 130, 246, 0.5);
            color: #60a5fa; padding: 8px 18px; border-radius: 50px; font-weight: 600;
            text-decoration: none; display: flex; align-items: center; gap: 8px; transition: 0.2s;
            backdrop-filter: blur(10px);
        }
        .top-left-back:hover { background: rgba(59, 130, 246, 0.45); color: #fff; }
        .navbar-glass { background: rgba(10, 15, 29, 0.75); backdrop-filter: blur(20px); border-bottom: 1px solid rgba(255,255,255,0.1); }
        .book-card {
            background: rgba(15, 23, 42, 0.75); border: 1px solid rgba(255,255,255,0.12); border-radius: 16px;
            overflow: hidden; transition: 0.3s; display: flex; flex-direction: column; height: 100%;
        }
        .book-card:hover { transform: translateY(-6px); box-shadow: 0 15px 30px rgba(0,0,0,0.6); border-color: #3b82f6; }
        .book-cover { width: 100%; aspect-ratio: 2/3; object-fit: cover; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .book-body { padding: 20px; display: flex; flex-direction: column; flex-grow: 1; }
        .book-title { font-size: 1.2rem; font-weight: 700; margin-bottom: 5px; color: #ffffff; }
        .book-author { color: #cbd5e1; font-size: 0.95rem; margin-bottom: 12px; font-weight: 500; }
        .action-row { display: flex; gap: 10px; margin-top: auto; }
        .btn-action {
            border-radius: 10px; font-weight: 600; font-size: 0.85rem; padding: 10px;
            display: flex; align-items: center; justify-content: center; gap: 5px; text-decoration: none; transition: 0.2s; border: none;
        }
        .btn-read { background: #3b82f6; color: white; flex: 3; }
        .btn-read:hover { background: #2563eb; color: white; }
        .btn-save-active { background: #ffffff !important; color: #0f172a !important; border: 1px solid #ffffff; flex: 1; font-size: 1.1rem; }
        .btn-save-active:hover { background: #e2e8f0 !important; }
        .modal-content { background: #0f172a; color: white; border: 1px solid rgba(255,255,255,0.15); border-radius: 16px; }
    </style>
</head>
<body>

<a href="javascript:history.back()" class="top-left-back">
    <i class="bi bi-arrow-left"></i> Ortga
</a>

<nav class="navbar navbar-expand-lg navbar-dark navbar-glass fixed-top py-3">
    <div class="container">
        <a class="navbar-brand fw-bold ms-5" href="${pageContext.request.contextPath}/"><i class="bi bi-book-half text-primary"></i> Digital Library</a>
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto ms-4 gap-3">
                <li class="nav-item"><a class="nav-link text-white-50" href="${pageContext.request.contextPath}/">Asosiy</a></li>
                <li class="nav-item"><a class="nav-link text-white-50" href="${pageContext.request.contextPath}/book/create">Kitob qo'shish</a></li>
                <li class="nav-item"><a class="nav-link text-white-50" href="${pageContext.request.contextPath}/book/list">Ro'yxat</a></li>
                <li class="nav-item"><a class="nav-link text-white-50" href="${pageContext.request.contextPath}/my-books">Mening kitoblarim</a></li>
                <li class="nav-item"><a class="nav-link text-white fw-bold" href="${pageContext.request.contextPath}/saved-books">Saqlanganlar</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container pb-5">
    <div class="text-center mb-5">
        <h2 class="fw-bold text-white mb-2"><i class="bi bi-bookmark-star text-warning me-2"></i> Saqlangan Kitoblar</h2>
        <p class="text-white-50">Siz o'qish uchun saqlab qo'ygan adabiyotlar</p>
    </div>

    <div class="row g-4">
        <c:forEach var="book" items="${savedBooks}">
            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                <div class="book-card">
                    <c:choose>
                        <c:when test="${not empty book.coverImagePath}">
                            <img src="${pageContext.request.contextPath}/uploads/${book.coverImagePath}" alt="${book.title}" class="book-cover" onerror="this.src='https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80'">
                        </c:when>
                        <c:otherwise>
                            <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80" alt="No cover" class="book-cover">
                        </c:otherwise>
                    </c:choose>

                    <div class="book-body">
                        <div class="book-title">${book.title}</div>
                        <div class="book-author"><i class="bi bi-pen"></i> ${book.author}</div>
                        <div class="text-white-50 small mb-3"><i class="bi bi-file-earmark-text"></i> ${book.pages} bet</div>

                        <div class="action-row">
                            <c:choose>
                                <c:when test="${not empty book.pdfPath}">
                                    <button type="button" class="btn-action btn-read" data-bs-toggle="modal" data-bs-target="#pdfModal${book.id}">
                                        <i class="bi bi-book"></i> O'qish
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn-action btn-read" style="opacity:0.4; cursor:not-allowed;" disabled><i class="bi bi-file-x"></i> PDF yo'q</button>
                                </c:otherwise>
                            </c:choose>

                            <form action="${pageContext.request.contextPath}/saved-books" method="post" style="flex:1; display:flex;">
                                <input type="hidden" name="bookId" value="${book.id}">
                                <button type="submit" class="btn-action btn-save-active w-100" title="Saqlanganlardan o'chirish">
                                    <i class="bi bi-bookmark-fill"></i>
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>

            <!-- PDF MODAL -->
            <c:if test="${not empty book.pdfPath}">
                <div class="modal fade" id="pdfModal${book.id}" tabindex="-1">
                    <div class="modal-dialog modal-fullscreen">
                        <div class="modal-content" style="background: #0a0a0c;">
                            <div class="modal-header border-bottom border-secondary px-4 py-3" style="background: rgba(15, 23, 42, 0.9);">
                                <div class="d-flex align-items-center gap-3">
                                    <button type="button" class="btn btn-outline-light rounded-pill px-4 fw-bold d-flex align-items-center gap-2" data-bs-dismiss="modal">
                                        <i class="bi bi-arrow-left"></i> Ortga qaytish
                                    </button>
                                    <h5 class="modal-title text-white fw-bold mb-0">📖 ${book.title} — Mutolaa</h5>
                                </div>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body p-0">
                                <iframe src="${pageContext.request.contextPath}/uploads/${book.pdfPath}" width="100%" height="100%" style="border: none;"></iframe>
                            </div>
                        </div>
                    </div>
                </div>
            </c:if>
        </c:forEach>

        <c:if test="${empty savedBooks}">
            <div class="col-12 text-center py-5">
                <div class="p-5" style="background: rgba(255,255,255,0.04); border-radius: 20px; border: 1px dashed rgba(255,255,255,0.15); max-width: 500px; margin: 0 auto;">
                    <i class="bi bi-journal-x" style="font-size: 4rem; color: #64748b;"></i>
                    <h4 class="text-white mt-3 fw-bold">Saqlangan kitoblar yo'q</h4>
                    <p class="text-white-50">Bosh sahifadan o'zingizga yoqqan kitoblarni saqlab oling.</p>
                    <a href="${pageContext.request.contextPath}/" class="btn btn-primary mt-2 px-4 rounded-pill fw-bold">Katalogga o'tish</a>
                </div>
            </div>
        </c:if>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>