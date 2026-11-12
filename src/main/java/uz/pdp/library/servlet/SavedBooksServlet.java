package uz.pdp.library.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.library.model.Book;
import uz.pdp.library.model.SavedBook;
import uz.pdp.library.model.User;
import uz.pdp.library.repo.BookRepo;
import uz.pdp.library.repo.SavedBookRepo;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet(name = "SavedBooksServlet", urlPatterns = "/saved-books")
public class SavedBooksServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        List<SavedBook> savedList = SavedBookRepo.getInstance().findAllByUserId(currentUser.getId());
        List<Book> savedBooks = new ArrayList<>();
        for (SavedBook savedBook : savedList) {
            BookRepo.getInstance().findById(savedBook.getBookId()).ifPresent(savedBooks::add);
        }
        req.setAttribute("savedBooks", savedBooks);
        req.getRequestDispatcher("/saved_books.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int bookId = Integer.parseInt(req.getParameter("bookId"));
        int userId = currentUser.getId();
        if (SavedBookRepo.getInstance().isBookSaved(userId, bookId)) {
            SavedBookRepo.getInstance().delete(userId, bookId);
        } else {
            SavedBookRepo.getInstance().save(SavedBook.builder()
                    .userId(userId)
                    .bookId(bookId)
                    .build());
        }
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/");
    }
}
