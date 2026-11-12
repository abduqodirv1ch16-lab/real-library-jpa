package uz.pdp.library.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;

@WebServlet(name = "FileServlet", urlPatterns = "/uploads/*")
public class FileServlet extends HttpServlet {
    // Fayllar kompyuteringizdagi doimiy papkaga saqlanadi
    private final String UPLOAD_DIR = System.getProperty("user.home") + File.separator + "library_uploads";

    @Override
    public void init() throws ServletException {
        File uploadDir = new File(UPLOAD_DIR);
        if (!uploadDir.exists()) {
            uploadDir.mkdirs(); // Papka yo'q bo'lsa yaratadi
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String filename = req.getPathInfo();
        if (filename == null || filename.equals("/")) {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
            return;
        }
        
        File file = new File(UPLOAD_DIR, filename.substring(1));
        if (file.exists()) {
            String mimeType = getServletContext().getMimeType(file.getName());
            resp.setContentType(mimeType != null ? mimeType : "application/octet-stream");
            Files.copy(file.toPath(), resp.getOutputStream());
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }
}