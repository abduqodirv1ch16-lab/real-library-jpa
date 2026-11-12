package uz.pdp.library.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import uz.pdp.library.model.Book;
import uz.pdp.library.repo.BookRepo;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "UpdateServlet", urlPatterns = "/update/*")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, maxFileSize = 1024 * 1024 * 50, maxRequestSize = 1024 * 1024 * 100)
public class UpdateServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getPathInfo().substring(1));
        Book book = BookRepo.getInstance().findById(id).orElse(null);
        if (book == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        req.setAttribute("book", book);

        req.getRequestDispatcher("/book_update.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String title = req.getParameter("title");
        String author = req.getParameter("author");
        int pages = Integer.parseInt(req.getParameter("pages"));

        Book book = BookRepo.getInstance().findById(id).orElse(null);
        if (book == null) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }


        String uploadPath = System.getProperty("user.home") + File.separator + "library_uploads";
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) uploadDir.mkdirs();


        String newPdfPath = saveFile(req.getPart("pdfFile"), uploadPath);
        String newCoverPath = saveFile(req.getPart("coverImage"), uploadPath);

        book.setTitle(title);
        book.setAuthor(author);
        book.setPages(pages);


        if (newPdfPath != null) {
            book.setPdfPath(newPdfPath);
        }

        if (newCoverPath != null) {
            book.setCoverImagePath(newCoverPath);
        }

        BookRepo.getInstance().updateBook(book);
        resp.sendRedirect(req.getContextPath() + "/book/list");
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