package com.example.demo.repository;

import org.springframework.data.repository.CrudRepository;
import com.example.demo.model.Storage;

public interface StorageRepo extends CrudRepository<Storage, Long> {
}