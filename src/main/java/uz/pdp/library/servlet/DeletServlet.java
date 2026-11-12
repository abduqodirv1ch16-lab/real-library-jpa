package uz.pdp.library.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import uz.pdp.library.repo.BookRepo;

import java.io.IOException;

@WebServlet(name = "Delete", urlPatterns = "/delete/*")
public class DeletServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getPathInfo().substring(1));
        BookRepo.getInstance().deleteBook(id);
        resp.sendRedirect(req.getContextPath() + "/book/list");

    }


}
