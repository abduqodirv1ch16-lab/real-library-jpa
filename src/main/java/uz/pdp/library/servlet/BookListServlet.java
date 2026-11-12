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

@WebServlet(name = "BookList", urlPatterns = "/book/list")
public class BookListServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Book> bookList = BookRepo.getInstance().findAll();
        req.setAttribute("bookList", bookList);
        req.getRequestDispatcher("/book_list.jsp").forward(req, resp);

    }
}
