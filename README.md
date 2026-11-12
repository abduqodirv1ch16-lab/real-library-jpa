# 📚 Real Library JPA

### Library Management System | Java · Jakarta EE · Hibernate · PostgreSQL

Real Library JPA is a database-driven Library Management System developed using Java and Jakarta EE technologies. The application provides functionality for managing library books through a structured backend architecture and persistent database storage.

The project demonstrates practical knowledge of Java backend development, ORM, relational databases, and server-side web development.

---

## 🚀 Tech Stack

| Technology | Purpose |
|---|---|
| Java 17 | Core programming language |
| Jakarta Servlet 6.1 | HTTP request handling |
| JSP | Server-side presentation |
| JSTL | Dynamic web content |
| Hibernate ORM 7.4 | Object-Relational Mapping |
| JPA | Persistence management |
| PostgreSQL | Relational database |
| HikariCP | Database connection pooling |
| Maven | Dependency management and build |
| JUnit 5 | Unit testing |

---

## ✨ Core Features

- **Book Management** — Create, view, update, and delete books.
- **Database Integration** — Persistent data storage using PostgreSQL.
- **ORM** — Entity mapping and database operations with Hibernate and JPA.
- **Connection Pooling** — Efficient database connection management with HikariCP.
- **Server-side Web Application** — HTTP request processing using Jakarta Servlets and JSP.

---

## 🏗️ Project Architecture

The application follows a layered backend structure to separate business logic, data access, and presentation responsibilities.

```text
Real_Library_JPA/
│
├── src/
│   ├── main/
│   │   ├── java/
│   │   │   └── ...
│   │   ├── resources/
│   │   └── webapp/
│   │
│   └── test/
│
├── pom.xml
└── README.md
```

---

## ⚙️ Getting Started

### Prerequisites

Make sure you have installed:

- JDK 17 or later
- Maven
- PostgreSQL
- A compatible Jakarta EE Servlet container

### 1. Clone the repository

```bash
git clone https://github.com/abduqodirv1ch16-lab/Real_Librar_jpa.git
```

### 2. Configure PostgreSQL

Create a database:

```sql
CREATE DATABASE real_library;
```

Configure your database connection according to the project's Hibernate and HikariCP configuration.

Update the database URL, username, and password in the appropriate configuration file.

**Security note:** Never commit real database passwords or credentials to GitHub.

### 3. Build the project

```bash
mvn clean package
```

### 4. Run the application

Deploy the generated WAR artifact to a compatible Jakarta EE servlet container and access the application through your local server.

---

## 🧪 Testing

The project uses JUnit 5 for testing.

Run tests using:

```bash
mvn test
```

---

## 🎯 Learning Objectives

This project demonstrates practical experience with:

- Java backend development
- Jakarta Servlet API
- Java Persistence API (JPA)
- Hibernate ORM
- PostgreSQL database integration
- Connection pooling
- Maven project management
- Unit testing

---

## 👨‍💻 Author

**Abdurauf Boribekov**

Java Backend Developer

- GitHub: [@abduqodirv1ch16-lab](https://github.com/abduqodirv1ch16-lab)
- LinkedIn: [Abdurauf Boribekov](https://www.linkedin.com/in/abdurauf-boribekov-552011443)
- Telegram: [@abukuii](https://t.me/abukuii)

---

⭐ If you find this project interesting, feel free to explore the repository and its implementation.
