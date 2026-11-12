package uz.pdp.library.repo;

import uz.pdp.library.config.BaseDao;
import uz.pdp.library.model.Book;
import uz.pdp.library.model.SavedBook;

import java.util.List;

public class SavedBookRepo extends BaseDao {
    private static final SavedBookRepo INSTANSE = new SavedBookRepo();
    private SavedBookRepo(){}
    public static SavedBookRepo getInstance(){
        return INSTANSE;
    }

    public void save(SavedBook savedBook) {
       executeTranzaksion(em->em.persist(savedBook));
     }

    public  List<SavedBook> findAllByUserId(int userId) {
          return execute(em->em.createQuery(
                  "select sb from SavedBook sb where sb.userId = : userId ", SavedBook.class)
                  .setParameter("userId",userId)
                  .getResultList());
         }

    public boolean isBookSaved(int userId, int bookId) {
          return execute(em->{
            Long count = em.createQuery(
                      "select count (sb) from SavedBook sb where sb.userId =:userId and sb.bookId=:bookId",Long.class)
                      .setParameter("userId",userId)
                      .setParameter("bookId",bookId)
                      .getSingleResult();
              return count>0;
          });
         }


    public  void delete(int userId, int bookId) {
         executeTranzaksion(em->{
             em.createQuery("delete from SavedBook sb where sb.userId=:userId and sb.bookId=:bookId")
                     .setParameter("userId",userId)
                     .setParameter("bookId",bookId)
                     .executeUpdate();
         });
    }

}
