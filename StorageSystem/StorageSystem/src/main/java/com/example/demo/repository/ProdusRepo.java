package com.example.demo.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.example.demo.model.Produs;

public interface ProdusRepo extends CrudRepository<Produs, Long>{
	List<Produs> findByCategory(String category);
}
