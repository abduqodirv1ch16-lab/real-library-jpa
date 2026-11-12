package uz.pdp.library.repo;

import uz.pdp.library.config.BaseDao;
import uz.pdp.library.model.User;

import java.util.List;
import java.util.Optional;

public class UserRepo extends BaseDao {
    private static final UserRepo INSTANSE = new UserRepo();
    private UserRepo(){}
    public static UserRepo getInstanse(){
        return INSTANSE;
    }

    public  void save(User user){
       executeTranzaksion(em->em.persist(user));
      }


    public  Optional<User> findByUsername(String username) {
         return execute(em-> {
             List<User> users = em.createQuery(
                             "select u from users u where u.username =: username", User.class)
                     .setParameter("username", username)
                     .getResultList();

             if (users.isEmpty()){
                 return Optional.empty();
             }
             return Optional.of(users.get(0));
         });
     }


    public  Optional<User> findById(int id) {
         return execute(em->{
             List<User> users = em.createQuery(
                     "select u from users u where u.id=:id", User.class)
                     .setParameter("id",id)
                     .getResultList();
             if(users.isEmpty()){
                 return Optional.empty();
             }
             return Optional.of(users.get(0));
         });
    }
}
