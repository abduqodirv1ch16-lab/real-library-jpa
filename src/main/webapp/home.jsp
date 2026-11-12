<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="uz.pdp.library.repo.ReviewRepo" %>
<%@ page import="uz.pdp.library.repo.SavedBookRepo" %>
<%@ page import="uz.pdp.library.model.User" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Digital Library - Katalog</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background: linear-gradient(rgba(10, 15, 29, 0.85), rgba(10, 15, 29, 0.95)),
            url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=2000&q=80') center/cover fixed;
            min-height: 100vh; font-family: 'Inter', sans-serif; color: #f8fafc; padding-top: 100px;
        }
        .navbar-glass {
            background: rgba(10, 15, 29, 0.85); backdrop-filter: blur(20px);
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .top-left-back {
            background: rgba(59, 130, 246, 0.2); border: 1px solid rgba(59, 130, 246, 0.4);
            color: #60a5fa; padding: 6px 14px; border-radius: 50px; font-weight: 600; font-size: 0.9rem;
            text-decoration: none; display: flex; align-items: center; gap: 6px; transition: 0.2s;
        }
        .top-left-back:hover { background: rgba(59, 130, 246, 0.4); color: #fff; }
        .book-card {
            background: rgba(15, 23, 42, 0.75); border: 1px solid rgba(255,255,255,0.12); border-radius: 16px;
            overflow: hidden; transition: 0.3s; display: flex; flex-direction: column; height: 100%;
        }
        .book-card:hover { transform: translateY(-6px); box-shadow: 0 15px 30px rgba(0,0,0,0.6); border-color: #3b82f6; }
        .book-cover { width: 100%; aspect-ratio: 2/3; object-fit: cover; border-bottom: 1px solid rgba(255,255,255,0.1); }
        .book-body { padding: 20px; display: flex; flex-direction: column; flex-grow: 1; }
        .book-title { font-size: 1.2rem; font-weight: 700; margin-bottom: 5px; color: #ffffff; }
        .book-author { color: #cbd5e1; font-size: 0.95rem; margin-bottom: 12px; font-weight: 500; }
        .book-meta { display: flex; justify-content: space-between; align-items: center; margin-bottom: 15px; }
        .rating-stars { color: #fbbf24; font-size: 0.85rem; }
        .page-badge { background: rgba(59, 130, 246, 0.2); padding: 4px 10px; border-radius: 6px; font-size: 0.85rem; color: #93c5fd; font-weight: 600; }
        .action-row { display: flex; gap: 10px; margin-top: auto; margin-bottom: 10px; }
        .btn-action {
            border-radius: 10px; font-weight: 600; font-size: 0.85rem; padding: 10px;
            display: flex; align-items: center; justify-content: center; gap: 5px; text-decoration: none; border: none; transition: 0.2s;
        }
        .btn-read { background: #3b82f6; color: white; flex: 3; }
        .btn-read:hover { background: #2563eb; color: white; }
        .btn-save { background: rgba(255,255,255,0.08); color: #94a3b8; border: 1px solid rgba(255,255,255,0.15); flex: 1; font-size: 1.1rem; }
        .btn-save:hover { background: rgba(255,255,255,0.15); color: white; }
        .btn-saved-active { background: #ffffff !important; color: #0f172a !important; border-color: #ffffff !important; }
        .btn-review { background: rgba(16, 185, 129, 0.2); color: #34d399; width: 100%; border: 1px dashed rgba(52, 211, 153, 0.5); padding: 10px; border-radius: 10px; font-weight: 600; }
        .btn-review:hover { background: rgba(16, 185, 129, 0.35); color: #fff; }
        .form-control { background: rgba(255,255,255,0.06); border: 1px solid rgba(255,255,255,0.2); color: white; }
        .form-control:focus { background: rgba(255,255,255,0.1); border-color: #3b82f6; color: white; box-shadow: none; }
        .review-box { background: rgba(255,255,255,0.04); border-radius: 10px; padding: 10px 15px; margin-bottom: 10px; border-left: 3px solid #34d399; }

        /* Yulduzchalar uchun to'g'rilangan CSS dizayn */
        .star-rating {
            display: flex;
            flex-direction: row;
            justify-content: flex-start;
            gap: 8px;
        }
        .star-rating input {
            display: none;
        }
        .star-rating label {
            font-size: 1.5rem;
            color: #475569;
            cursor: pointer;
            transition: color 0.2s ease;
        }
    </style>
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-dark navbar-glass fixed-top py-3">
    <div class="container-fluid px-4">
        <div class="d-flex align-items-center gap-3">
            <a href="javascript:history.back()" class="top-left-back" title="Orqaga qaytish">
                <i class="bi bi-arrow-left"></i> Ortga
            </a>
            <a class="navbar-brand fw-bold ms-2" href="${pageContext.request.contextPath}/"><i class="bi bi-book-half text-primary me-2"></i>Digital Library</a>
        </div>

        <div class="collapse navbar-collapse" id="navMenu">
            <ul class="navbar-nav me-auto ms-4 gap-3">
                <li class="nav-item"><a class="nav-link text-white fw-bold" href="${pageContext.request.contextPath}/">Katalog</a></li>
                <c:if test="${not empty sessionScope.currentUser}">
                    <li class="nav-item"><a class="nav-link text-white-50" href="${pageContext.request.contextPath}/book/create">Qo'shish</a></li>
                    <li class="nav-item"><a class="nav-link text-white-50" href="${pageContext.request.contextPath}/book/list">Ro'yxat</a></li>
                    <li class="nav-item"><a class="nav-link text-white-50" href="${pageContext.request.contextPath}/my-books">Mening kitoblarim</a></li>
                    <li class="nav-item"><a class="nav-link text-white-50" href="${pageContext.request.contextPath}/saved-books">Saqlanganlar</a></li>
                </c:if>
            </ul>
            <div class="d-flex align-items-center gap-3">
                <c:choose>
                    <c:when test="${not empty sessionScope.currentUser}">
                        <span class="text-white">Salom, <strong>${sessionScope.currentUser.fullname}</strong></span>
                        <a href="${pageContext.request.contextPath}/logout" class="btn btn-outline-danger btn-sm rounded-pill px-3">Chiqish</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-light rounded-pill px-4 fw-bold">Kirish</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </div>
</nav>

<div class="container">
    <div class="row g-4 pb-5">
        <c:forEach var="book" items="${books}">
            <div class="col-12 col-sm-6 col-md-4 col-lg-3">
                <div class="book-card">
                    <c:choose>
                        <c:when test="${not empty book.coverImagePath}">
                            <img src="${pageContext.request.contextPath}/uploads/${book.coverImagePath}" alt="${book.title}" class="book-cover" onerror="this.src='https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80'">
                        </c:when>
                        <c:otherwise>
                            <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=600&q=80" alt="Muqova" class="book-cover">
                        </c:otherwise>
                    </c:choose>

                    <div class="book-body">
                        <div class="book-title">${book.title}</div>
                        <div class="book-author"><i class="bi bi-pen"></i> ${book.author}</div>

                        <!-- KITOBNING UMUMIY REYTINGI VA YULDUZCHALARI -->
                        <div class="book-meta">
                            <c:set var="avgRating" value="${ReviewRepo.getInstance().getAverageRating(book.id)}" />
                            <div class="rating-stars d-flex align-items-center gap-1">
                                <div>
                                    <c:forEach begin="1" end="5" var="i">
                                        <c:choose>
                                            <c:when test="${avgRating >= i}">
                                                <i class="bi bi-star-fill text-warning"></i>
                                            </c:when>
                                            <c:when test="${avgRating >= i - 0.5}">
                                                <i class="bi bi-star-half text-warning"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="bi bi-star text-secondary"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </div>
                                <span class="fw-bold text-white small" style="font-size: 0.8rem;">
                                    <c:choose>
                                        <c:when test="${avgRating > 0}">
                                            ${String.format("%.1fal", avgRating).replace("al", "")}
                                        </c:when>
                                        <c:otherwise>0.0</c:otherwise>
                                    </c:choose>
                                </span>
                            </div>
                            <div class="page-badge">${book.pages} bet</div>
                        </div>

                        <div class="action-row">
                            <c:choose>
                                <c:when test="${not empty book.pdfPath}">
                                    <button type="button" class="btn-action btn-read" data-bs-toggle="modal" data-bs-target="#pdfModal${book.id}">
                                        <i class="bi bi-book"></i> O'qish
                                    </button>
                                </c:when>
                                <c:otherwise>
                                    <button class="btn-action btn-read" style="opacity: 0.4; cursor: not-allowed;" disabled><i class="bi bi-file-earmark-x"></i> PDF yo'q</button>
                                </c:otherwise>
                            </c:choose>

                            <c:if test="${not empty sessionScope.currentUser}">
                                <c:set var="isSaved" value="${SavedBookRepo.getInstance().isBookSaved(sessionScope.currentUser.id, book.id)}" />
                                <form action="${pageContext.request.contextPath}/saved-books" method="post" style="flex:1; display:flex;">
                                    <input type="hidden" name="bookId" value="${book.id}">
                                    <button type="submit" class="btn-action btn-save ${isSaved ? 'btn-saved-active' : ''}" title="${isSaved ? 'Saqlanganlardan o\'chirish' : 'Saqlash'}">
                                        <i class="bi ${isSaved ? 'bi-bookmark-fill' : 'bi-bookmark'}"></i>
                                    </button>
                                </form>
                            </c:if>
                        </div>

                        <c:if test="${not empty sessionScope.currentUser}">
                            <button type="button" class="btn-action btn-review" data-bs-toggle="modal" data-bs-target="#reviewModal${book.id}">
                                <i class="bi bi-chat-text"></i> Izohlar va Fikrlar
                            </button>
                        </c:if>
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

            <!-- IZOHLAR MODALI (FLEXBOX BILAN TUZILGAN, SKROL VA STICKY FOOTER) -->
            <div class="modal fade" id="reviewModal${book.id}" tabindex="-1">
                <div class="modal-dialog modal-dialog-centered modal-lg">
                    <div class="modal-content p-3" style="background: #0f172a; color: white; border: 1px solid rgba(255,255,255,0.15); border-radius: 16px; height: 85vh; display: flex; flex-direction: column;">

                        <!-- Header (Yuqorida qotitilgan) -->
                        <div class="modal-header border-0 pb-0 flex-shrink-0">
                            <h5 class="modal-title fw-bold">"${book.title}" - Fikrlar</h5>
                            <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                        </div>

                        <!-- Modal Body (Oldingi izohlar - faqat shu qism skrol bo'ladi) -->
                        <div class="modal-body overflow-y-auto flex-grow-1 my-2" style="max-height: calc(85vh - 220px);">
                            <h6 class="text-info fw-semibold mb-3">Oldingi izohlar:</h6>
                            <c:set var="bookReviews" value="${ReviewRepo.getInstance().findAllByBookId(book.id)}" />
                            <c:forEach var="rev" items="${bookReviews}">
                                <div class="review-box">
                                    <div class="d-flex justify-content-between small text-white-50 mb-1">
                                        <span>⭐ ${rev.rating}/5 baho</span>
                                        <span>${rev.formattedDate}</span>
                                    </div>
                                    <p class="mb-0 text-white">${rev.commentText}</p>
                                </div>
                            </c:forEach>
                            <c:if test="${empty bookReviews}">
                                <p class="text-white-50 small fst-italic">Hozircha izohlar yo'q. Birinchi bo'lib fikr qoldiring!</p>
                            </c:if>
                        </div>

                        <!-- Footer Form (Pastda o'zgarmasdan turadigan panel / Sticky Footer) -->
                        <div class="modal-footer border-top border-secondary pt-3 flex-shrink-0" style="background: #0f172a;">
                            <form action="${pageContext.request.contextPath}/review" method="post" class="w-100 m-0">
                                <input type="hidden" name="bookId" value="${book.id}">

                                <!-- Yulduzchali baholash qismi -->
                                <div class="mb-2 d-flex align-items-center justify-content-between">
                                    <label class="form-label text-white-50 small mb-0">Bahongiz (Ixtiyoriy)</label>
                                    <div class="star-rating" id="ratingGroup_${book.id}">
                                        <input type="radio" id="star1_${book.id}" name="rating" value="1" />
                                        <label for="star1_${book.id}" title="1 yulduz"><i class="bi bi-star-fill"></i></label>

                                        <input type="radio" id="star2_${book.id}" name="rating" value="2" />
                                        <label for="star2_${book.id}" title="2 yulduz"><i class="bi bi-star-fill"></i></label>

                                        <input type="radio" id="star3_${book.id}" name="rating" value="3" />
                                        <label for="star3_${book.id}" title="3 yulduz"><i class="bi bi-star-fill"></i></label>

                                        <input type="radio" id="star4_${book.id}" name="rating" value="4" />
                                        <label for="star4_${book.id}" title="4 yulduz"><i class="bi bi-star-fill"></i></label>

                                        <input type="radio" id="star5_${book.id}" name="rating" value="5" />
                                        <label for="star5_${book.id}" title="5 yulduz"><i class="bi bi-star-fill"></i></label>
                                    </div>
                                </div>

                                <!-- Kitob haqida taassurotingiz (Stiker va auto-expand textarea) -->
                                <div class="mb-2">
                                    <label class="form-label fw-bold text-warning small d-flex align-items-center gap-1 mb-1">
                                        Kitob haqida taassurotingiz ✍️
                                    </label>
                                    <textarea name="commentText" class="form-control" rows="1" placeholder="Fikringizni shu yerga yozing..." required style="resize: none; overflow-y: hidden; min-height: 38px;" oninput="this.style.height = ''; this.style.height = this.scrollHeight + 'px'"></textarea>
                                </div>
                                <button type="submit" class="btn btn-primary w-100 rounded-pill fw-bold py-2">Izoh qoldirish</button>
                            </form>
                        </div>

                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        const ratingGroups = document.querySelectorAll('.star-rating');
        ratingGroups.forEach(group => {
            const stars = group.querySelectorAll('input[type="radio"]');
            stars.forEach((star, index) => {
                star.addEventListener('change', function() {
                    group.querySelectorAll('label').forEach(l => l.style.color = '#475569');
                    for(let i = 0; i <= index; i++) {
                        group.querySelectorAll('label')[i].style.color = '#fbbf24';
                    }
                });
            });

            const labels = group.querySelectorAll('label');
            labels.forEach((label, idx) => {
                label.addEventListener('mouseenter', function() {
                    labels.forEach((l, i) => {
                        if(i <= idx) {
                            l.style.color = '#fbbf24';
                        } else {
                            let inputId = l.getAttribute('for');
                            let input = document.getElementById(inputId);
                            if(!input.checked) {
                                l.style.color = '#475569';
                            }
                        }
                    });
                });
            });
            group.addEventListener('mouseleave', function() {
                let checkedIndex = -1;
                stars.forEach((s, idx) => { if(s.checked) checkedIndex = idx; });
                labels.forEach((l, i) => {
                    if(i <= checkedIndex) {
                        l.style.color = '#fbbf24';
                    } else {
                        l.style.color = '#475569';
                    }
                });
            });
        });
    });
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>