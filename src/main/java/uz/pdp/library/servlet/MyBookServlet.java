package uz.pdp.library.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.library.model.Book;
import uz.pdp.library.model.User;
import uz.pdp.library.repo.BookRepo;

import java.io.IOException;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "MyBookServlet", urlPatterns = "/my-books")
public class MyBookServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        if (currentUser == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }
        List<Book> myBooks = BookRepo.getInstance().findAll().stream()
                .filter(b -> b.getUserId() == currentUser.getId())
                .collect(Collectors.toList());

        req.setAttribute("myBooks", myBooks);
        req.getRequestDispatcher("/my_books.jsp").forward(req, resp);
    }
}
