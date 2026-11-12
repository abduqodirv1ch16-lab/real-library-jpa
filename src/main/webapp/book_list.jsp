<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page import="uz.pdp.library.repo.SavedBookRepo" %>
<!DOCTYPE html>
<html lang="uz">
<head>
    <meta charset="UTF-8">
    <title>Barcha Kitoblar | Digital Library</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        body {
            background: linear-gradient(rgba(10, 15, 29, 0.85), rgba(10, 15, 29, 0.95)),
            url('https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?auto=format&fit=crop&w=2000&q=80') center/cover fixed;
            min-height: 100vh; font-family: sans-serif; color: #fff; padding-top: 100px; position: relative;
        }
        .top-left-back {
            position: fixed; top: 25px; left: 30px; z-index: 1050;
            background: rgba(59, 130, 246, 0.25); border: 1px solid rgba(59, 130, 246, 0.5);
            color: #60a5fa; padding: 8px 18px; border-radius: 50px; font-weight: 600;
            text-decoration: none; display: flex; align-items: center; gap: 8px; transition: 0.2s;
            backdrop-filter: blur(10px);
        }
        .top-left-back:hover { background: rgba(59, 130, 246, 0.45); color: #fff; }

        .navbar-glass { background: rgba(10, 15, 29, 0.7); backdrop-filter: blur(20px); border-bottom: 1px solid rgba(255,255,255,0.1); }
        .glass-panel {
            background: rgba(15, 23, 42, 0.75); backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.15); border-radius: 20px; padding: 30px;
            box-shadow: 0 20px 40px rgba(0,0,0,0.5);
        }
        .table { color: #ffffff; vertical-align: middle; }
        .table thead th { background: rgba(0,0,0,0.4); color: #60a5fa; border-bottom: none; padding: 16px; font-weight: 600; }
        .table tbody td { background: transparent; border-bottom: 1px solid rgba(255, 255, 255, 0.08); padding: 14px 16px; }
        .table tbody tr:hover td { background: rgba(255, 255, 255, 0.04); }
        .book-title-cell { color: #ffffff !important; font-weight: 700; font-size: 1.05rem; }
        .book-author-cell { color: #cbd5e1 !important; font-weight: 500; }
        .table-book-cover {
            width: 40px; height: 55px; object-fit: cover; border-radius: 6px;
            border: 1px solid rgba(255, 255, 255, 0.2); box-shadow: 0 4px 10px rgba(0,0,0,0.3);
        }
        .actions-cell { display: flex; gap: 8px; justify-content: flex-end; align-items: center; }
        .btn-action { padding: 6px 12px; border-radius: 8px; font-size: 0.85rem; font-weight: 600; text-decoration: none; display: inline-flex; align-items: center; gap: 5px; white-space: nowrap; }
        .btn-edit { background: rgba(16, 185, 129, 0.2); color: #34d399; border: 1px solid rgba(16,185,129,0.3); }
        .btn-edit:hover { background: rgba(16,185,129,0.4); color: #fff; }
        .btn-delete { background: rgba(239, 68, 68, 0.2); color: #f87171; border: 1px solid rgba(239,68,68,0.3); }
        .btn-delete:hover { background: rgba(239, 68, 68, 0.4); color: #fff; }
        .btn-table-save { background: rgba(255,255,255,0.08); color: #94a3b8; border: 1px solid rgba(255,255,255,0.15); padding: 6px 14px; border-radius: 8px; font-size: 1rem; transition: 0.2s; }
        .btn-table-save:hover { background: rgba(255,255,255,0.15); color: white; }
        .btn-table-saved-active { background: #ffffff !important; color: #0f172a !important; border-color: #ffffff !important; }
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
                <li class="nav-item"><a class="nav-link text-white fw-bold" href="${pageContext.request.contextPath}/book/list">Ro'yxat</a></li>
                <li class="nav-item"><a class="nav-link text-white-50" href="${pageContext.request.contextPath}/my-books">Mening kitoblarim</a></li>
                <li class="nav-item"><a class="nav-link text-white-50" href="${pageContext.request.contextPath}/saved-books">Saqlanganlar</a></li>
            </ul>
        </div>
    </div>
</nav>

<div class="container pb-5">
    <div class="glass-panel">
        <h3 class="fw-bold mb-4 text-white"><i class="bi bi-list-columns-reverse text-primary me-2"></i> Barcha kitoblar ro'yxati</h3>

        <div class="table-responsive rounded-3 overflow-hidden border border-secondary border-opacity-25">
            <table class="table mb-0">
                <thead>
                <tr>
                    <th style="width: 60px;">№</th>
                    <th style="width: 80px;">Muqova</th>
                    <th>Kitob Nomi</th>
                    <th>Muallif</th>
                    <th class="text-center" style="width: 130px;">Sahifalar</th>
                    <th class="text-end" style="width: 220px;">Harakatlar</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="book" items="${bookList}" varStatus="status">
                    <tr>
                        <td class="text-white-50 fw-semibold">${status.count}</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty book.coverImagePath}">
                                    <img src="${pageContext.request.contextPath}/uploads/${book.coverImagePath}" alt="Cover" class="table-book-cover" onerror="this.src='https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=200&q=80'">
                                </c:when>
                                <c:otherwise>
                                    <img src="https://images.unsplash.com/photo-1544947950-fa07a98d237f?auto=format&fit=crop&w=200&q=80" alt="Default" class="table-book-cover">
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td class="book-title-cell">${book.title}</td>
                        <td class="book-author-cell">${book.author}</td>
                        <td class="text-center">
                            <span class="badge bg-primary bg-opacity-25 text-info border border-primary border-opacity-50 px-3 py-1 rounded-pill fw-bold">
                                ${book.pages} bet
                            </span>
                        </td>
                        <td class="text-end">
                            <c:choose>
                                <c:when test="${book.userId == sessionScope.currentUser.id}">
                                    <div class="actions-cell">
                                        <a href="${pageContext.request.contextPath}/update/${book.id}" class="btn-action btn-edit"><i class="bi bi-pencil"></i> Tahrirlash</a>
                                        <a href="${pageContext.request.contextPath}/delete/${book.id}" class="btn-action btn-delete" onclick="return confirm('Haqiqatan ham o\'chirasizmi?');"><i class="bi bi-trash"></i> O'chirish</a>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="actions-cell">
                                            <%-- TO'G'RILANDI: getInstance() qo'shildi --%>
                                        <c:set var="isSaved" value="${SavedBookRepo.getInstance().isBookSaved(sessionScope.currentUser.id, book.id)}" />
                                        <form action="${pageContext.request.contextPath}/saved-books" method="post" style="display:inline;">
                                            <input type="hidden" name="bookId" value="${book.id}">
                                            <button type="submit" class="btn btn-table-save ${isSaved ? 'btn-table-saved-active' : ''}" title="${isSaved ? 'Saqlanganlardan o\'chirish' : 'Saqlash'}">
                                                <i class="bi ${isSaved ? 'bi-bookmark-fill' : 'bi-bookmark'}"></i>
                                            </button>
                                        </form>
                                    </div>
                                </c:otherwise>
                            </c:choose>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>