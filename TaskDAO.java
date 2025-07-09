package com.dao;

import com.model.Task;
import org.hibernate.Session;
import org.hibernate.Transaction;

import java.util.List;

public class TaskDAO {
    
    public void addTask(Task task) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // start a transaction
            transaction = session.beginTransaction();
            
            // save the task object
            session.save(task);
            
            // commit transaction
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw e;
        }
    }
     public void saveTask(Task task) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            // start a transaction
            transaction = session.beginTransaction();
            
            // save the task object
            session.save(task);
            
            // commit transaction
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw e;
        }
    }

    public List<Task> getTasksByUserId(int userId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.createQuery("FROM Task WHERE userId = :userId", Task.class)
                    .setParameter("userId", userId)
                    .list();
        }
    }

    public void deleteTask(int taskId) {
        Transaction transaction = null;
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            transaction = session.beginTransaction();
            Task task = session.get(Task.class, taskId);
            if (task != null) {
                session.delete(task);
            }
            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
            throw e;
        }
    }

    public Task getTaskById(int taskId) {
        try (Session session = HibernateUtil.getSessionFactory().openSession()) {
            return session.get(Task.class, taskId);
        }
    }
}