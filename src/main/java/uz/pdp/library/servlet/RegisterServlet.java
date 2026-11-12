package uz.pdp.library.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import uz.pdp.library.model.Role;
import uz.pdp.library.model.User;
import uz.pdp.library.repo.UserRepo;

import java.io.IOException;

@WebServlet(name = "RegisterServlet", urlPatterns = "/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String fullname = req.getParameter("fullname");
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (fullname == null || username == null || password == null ||
                fullname.isBlank() || username.isBlank() || password.isBlank()) {

            req.setAttribute("errorMessage", "Barcha maydonlarni toldiring!");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }
        if (UserRepo.getInstanse().findByUsername(username).isPresent()) {
            req.setAttribute("errorMessage", "Bu user allaqachon mavjud, boshqa tanlang!");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
            return;
        }
        User newUser = User.builder()
                .fullname(fullname.trim())
                .username(username.trim())
                .password(password)
                .role(Role.USER)
                .build();
        UserRepo.getInstanse().save(newUser);
        User registeredUser = UserRepo.getInstanse().findByUsername(username.trim()).orElse(newUser);
        HttpSession session = req.getSession();
        session.setAttribute("currentUser", registeredUser);

        resp.sendRedirect(req.getContextPath() + "/");
    }
}
