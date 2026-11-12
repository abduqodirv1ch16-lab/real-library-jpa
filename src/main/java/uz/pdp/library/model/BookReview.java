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
@Entity()
@Table(name = "book_reviews")
public class BookReview {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    @Column(name = "user_id")
    private int userId;
    @Column(name = "book_id")
    private int bookId;
    private int rating;
    @Column(name = "comment_text")
    private String commentText;
    @Column(name = "created_at")
    private Timestamp createdAt;

    public String getFormattedDate() {
        if (createdAt == null) return "";
        return createdAt.toLocalDateTime().format(java.time.format.DateTimeFormatter.ofPattern("yyyy.MM.dd    HH:mm"));
    }
}
