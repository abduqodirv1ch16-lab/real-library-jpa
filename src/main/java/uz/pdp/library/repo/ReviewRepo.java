package uz.pdp.library.repo;

import uz.pdp.library.config.BaseDao;
import uz.pdp.library.model.BookReview;

import java.util.List;

public class ReviewRepo extends BaseDao {
    private static final ReviewRepo INSTANCE = new ReviewRepo();
    private ReviewRepo(){}
    public static ReviewRepo getInstance(){
        return INSTANCE;
    }

    public void save(BookReview review) {
       executeTranzaksion(em->em.persist(review));
    }

    public  List<BookReview> findAllByBookId(int bookId) {
           return execute(em->em.createQuery(
                   "select r from BookReview r where r.bookId =: bookId order by r.createdAt desc ", BookReview.class)
                   .setParameter("bookId",bookId)
                   .getResultList());
    }

    public double getAverageRating(int bookId) {
        return execute(em -> {
            Double avg = em.createQuery(
                            "select avg(r.rating) from BookReview r where r.bookId = :bookId and r.rating > 0", Double.class)
                    .setParameter("bookId", bookId)
                    .getSingleResult();
            return avg != null ? avg : 0.0;
        });
    }
}
