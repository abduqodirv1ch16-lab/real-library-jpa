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
@Entity(name = "users")
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    @Column(name = "full_name")
    private String fullname;
    @Column(name = "user_name")
    private String username;
    private String password;
    private Role role;
    @Column(name = "created_at")
    private Timestamp createdAt;
}
