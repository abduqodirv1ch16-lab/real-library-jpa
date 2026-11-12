package uz.pdp.library.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.library.model.BookReview;
import uz.pdp.library.model.User;
import uz.pdp.library.repo.ReviewRepo;

import java.io.IOException;
import java.sql.Timestamp;

@WebServlet(name = "ReviewServlet", urlPatterns = "/review")
public class ReviewServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;
        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        int bookId = Integer.parseInt(req.getParameter("bookId"));
        String ratingStr = req.getParameter("rating");
        int rating = 0;
        if (ratingStr != null && !ratingStr.isEmpty()) {
            rating = Integer.parseInt(ratingStr);
        }
        String commentText = req.getParameter("commentText");

        BookReview review = BookReview.builder()
                .userId(currentUser.getId())
                .bookId(bookId)
                .rating(rating)
                .commentText(commentText)
                .createdAt(new Timestamp(System.currentTimeMillis()))
                .build();
        ReviewRepo.getInstance().save(review);

        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/");
    }
}
