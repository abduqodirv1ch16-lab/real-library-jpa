package uz.pdp.library.config;

import jakarta.persistence.*;

import java.util.function.Consumer;
import java.util.function.Function;

public abstract class BaseDao {
    private final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("my_library_id");

    public EntityManager em(){
        return entityManagerFactory.createEntityManager();
    }


   protected <T> T execute(Function<EntityManager,T> action){
        EntityManager entityManager = em();
        try {
            return action.apply(entityManager);
        }finally {
            entityManager.close();
        }
   }


   protected void executeTranzaksion(Consumer<EntityManager> action){
        EntityManager entityManager = em();
        EntityTransaction entx  = entityManager.getTransaction();
        try {
            entx.begin();
            action.accept(entityManager);
            entx.commit();
        }catch (Exception ex){
            if(entx.isActive()){
                entx.rollback();
            }
            throw new RuntimeException("Tranzaksiyada xatolik yuz berdi"+ex.getMessage(),ex);
        }finally {
            entityManager.close();
        }
   }



}
