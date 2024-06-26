package com.example.demo.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.example.demo.model.Produs;

public interface ProdusRepo extends CrudRepository<Produs, Long> {
    Iterable<Produs> findByStorageId(Long storageId);
    void deleteById(Long id);
}
