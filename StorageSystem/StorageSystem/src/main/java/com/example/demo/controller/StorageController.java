package com.example.demo.controller;


import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import com.example.demo.model.Category;
import com.example.demo.model.Storage;
import com.example.demo.repository.CategoryRepo;
import com.example.demo.repository.StorageRepo;
import com.example.demo.service.StorageService;

@RestController
public class StorageController {
	
	 private static final Logger logger = LoggerFactory.getLogger(StorageController.class);
	
    @Autowired
    StorageRepo storageRepo;
    @Autowired
    CategoryRepo categoryRepo;
    @Autowired
    private StorageService storageService;
    
    
    @GetMapping
    public ResponseEntity<List<Storage>> getStorages() {
        List<Storage> storages = storageService.getAllStorages();
        return ResponseEntity.ok(storages);
    }
    
    @RequestMapping("/AddStorage")
    public ModelAndView addStorageForm() {
        return new ModelAndView("AddStorage_Form");
    }
    
    @RequestMapping("/CreateStorage")
    public ModelAndView createStorage(Storage storage, @RequestParam("categoryIds") List<Long> categoryIds) {
        // Fetch categories from categoryIds
        Set<Category> categories = new HashSet<>();
        for (Long categoryId : categoryIds) {
            Category category = categoryRepo.findById(categoryId).orElse(null);
            if (category != null) {
                categories.add(category);
            }
        }
        // Set categories for the storage
        storage.setCategories(categories);
        
        
        // Save the storage
        Storage savedStorage = storageRepo.save(storage);
        
        ModelAndView modelAndView = new ModelAndView();
        
        if(savedStorage != null) {
            modelAndView.setViewName("view");
            modelAndView.addObject("message", "Storage created successfully");
            modelAndView.addObject("storage", savedStorage);
            modelAndView.addObject("categories", categories);
        } else {
            modelAndView.setViewName("error"); // or any error view
            modelAndView.addObject("message", "Failed to create storage");
        }
        
        return modelAndView;
    }
    
    @GetMapping("/manageStorage/{id}")
    public ModelAndView manageStorage(@PathVariable Long id) {
        ModelAndView modelAndView = new ModelAndView();
        Storage storage = storageService.findById(id);
        if (storage != null) {
            modelAndView.setViewName("manageStorage");
            modelAndView.addObject("storage", storage);
        } else {
            modelAndView.setViewName("error");
            // You can add additional error information here if needed
        }
        return modelAndView;
    }

    
}
