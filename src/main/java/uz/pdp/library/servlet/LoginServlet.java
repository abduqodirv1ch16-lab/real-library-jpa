package uz.pdp.library.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.library.model.User;
import uz.pdp.library.repo.UserRepo;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "Login Servlet", urlPatterns = "/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/login.jsp").forward(req, resp);

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || password == null || username.isBlank() || password.isBlank()) {
            req.setAttribute("errorMessage", "Login va paroni toldiring!");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
            return;
        }
        Optional<User> userOptional = UserRepo.getInstanse().findByUsername(username.trim());

        if (userOptional.isPresent()) {
            User user = userOptional.get();
            if (user.getPassword().equals(password)) {
                HttpSession session = req.getSession();
                session.setAttribute("currentUser", user);
                resp.sendRedirect(req.getContextPath() + "/");
                return;
            }
        }
        req.setAttribute("errorMessage", "Login yoki parol hato!");
        req.getRequestDispatcher("/login.jsp").forward(req, resp);

    }
}
