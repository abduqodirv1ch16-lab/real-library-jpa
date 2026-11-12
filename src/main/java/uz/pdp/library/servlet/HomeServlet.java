package uz.pdp.library.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.library.model.Book;
import uz.pdp.library.repo.BookRepo;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "Home", urlPatterns = "/")
public class HomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Book> books = BookRepo.getInstance().findAll();
        req.setAttribute("books", books);
        req.getRequestDispatcher("/home.jsp").forward(req, resp);
    }
}
