package uz.pdp.library.repo;

import lombok.Getter;
import uz.pdp.library.config.BaseDao;
import uz.pdp.library.model.Book;

import java.util.List;
import java.util.Optional;

public class BookRepo  extends BaseDao {
    @Getter
    private static final BookRepo instance =new BookRepo();
    private BookRepo(){};

    public   void save(Book book) {
        executeTranzaksion(em->em.persist(book));
    }

    public  List<Book> findAll() {
           return execute(em->em.createQuery("select b from Book b", Book.class).getResultList());
    }

    public Optional<Book> findById(int id) {
        return execute(em->Optional.ofNullable(em.find(Book.class,id)));
    }

    public void updateBook(Book book) {
           executeTranzaksion(em->em.merge(book));
    }

    public  void deleteBook(int id) {
          executeTranzaksion(em->{
              Book book = em.find(Book.class,id);
              if(book!=null){
                  em.remove(book);
              }
          } );
    }
}
