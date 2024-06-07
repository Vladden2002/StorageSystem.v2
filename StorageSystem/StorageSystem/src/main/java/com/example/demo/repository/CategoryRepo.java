package com.example.demo.repository;

import org.springframework.data.repository.CrudRepository;

import com.example.demo.model.Category;


public interface CategoryRepo extends CrudRepository<Category, Long>{

}
