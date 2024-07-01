package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Category;
import com.example.demo.repository.CategoryRepo;

@Service
public class CategoryService {

    @Autowired
    private CategoryRepo categoryRepository; // Assuming you have a CategoryRepository

    public Category createCategory(String name) {
        Category category = new Category();
        category.setName(name);
        return categoryRepository.save(category);
    }
    
 // Method to get all categories
    public List<Category> getAllCategories() {
        return (List<Category>) categoryRepository.findAll();
    }
}
