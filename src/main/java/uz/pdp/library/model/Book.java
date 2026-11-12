package uz.pdp.library.model;

import jakarta.persistence.*;
import lombok.*;

import java.sql.Timestamp;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
@ToString
@Entity
@Table(name = "books")
public class Book {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private String title;
    private String author;
    private Integer pages;

    @Column(name = "pdf_path")
    private String pdfPath;
    @Column(name = "cover_image_path")
    private String coverImagePath;
    @Column(name = "user_id")
    private Integer userId;
    @Column(name = "created_at")
    private Timestamp createdAt;
}
