package uz.pdp.library.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import uz.pdp.library.model.Book;
import uz.pdp.library.model.User;
import uz.pdp.library.repo.BookRepo;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "BookCreate",  urlPatterns = "/book/create")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 100)
public class BookCreateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/book_create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String title = req.getParameter("title");
        String author = req.getParameter("author");
        int pages = Integer.parseInt(req.getParameter("pages"));

        User currentUser = (User) req.getSession().getAttribute("currentUser");
        int userId = (currentUser != null) ? currentUser.getId() : 0;

        // Doimiy papkaga saqlash yoli
        String uploadPath = System.getProperty("user.home") + File.separator + "library_uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();

        String coverPath = saveFile(req.getPart("coverImage"), uploadPath);
        String pdfPath = saveFile(req.getPart("pdfFile"), uploadPath);

        Book book = Book.builder()
                .title(title)
                .author(author)
                .pages(pages)
                .coverImagePath(coverPath) // Faqat fayl nomini saqlaymiz
                .pdfPath(pdfPath)
                .userId(userId)
                .build();

        BookRepo.getInstance().save(book);
        resp.sendRedirect(req.getContextPath() + "/");
    }

    private String saveFile(Part part, String uploadPath) throws IOException {
        if (part == null || part.getSize() == 0 || part.getSubmittedFileName().trim().isEmpty()) {
            return null;
        }
        String originalFileName = part.getSubmittedFileName();
        String uniqueFileName = UUID.randomUUID().toString() + "_" + originalFileName;
        part.write(uploadPath + File.separator + uniqueFileName);
        return uniqueFileName;
    }
}