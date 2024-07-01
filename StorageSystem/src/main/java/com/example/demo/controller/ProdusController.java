package com.example.demo.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.example.demo.model.Produs;
import com.example.demo.model.Storage;
import com.example.demo.service.ProdusService;
import com.example.demo.service.StorageService;

@Controller
public class ProdusController {
    private final ProdusService produsService;
    private final StorageService storageService;

    @Autowired
    public ProdusController(ProdusService produsService, StorageService storageService) {
        this.produsService = produsService;
        this.storageService = storageService;
    }

    @PostMapping("/addProduct")
    public String addProduct(@RequestParam("productName") String name,
                             @RequestParam("productPrice") double price,
                             @RequestParam("productWeight") int weight,
                             @RequestParam("productCategory") String category,
                             @RequestParam("storageId") Long storageId) {
        // Retrieve the storage object by its ID
        Storage storage = storageService.findById(storageId);

        // Create a Produs object
        Produs produs = new Produs(name, category, storage, weight, price);

        // Save the Produs object
        produsService.addProdus(produs);
        return "redirect:/success.html"; // Redirect to a success page
    }
    
    @GetMapping("/getAllProdusByStorageId")
    @ResponseBody
    public List<Produs> getAllProdusByStorageId(@RequestParam("storageId") Long storageId) {
        return produsService.getAllProdusByStorageId(storageId);
    }
    
    @DeleteMapping("/deleteProduct/{id}")
    @ResponseBody
    public ResponseEntity<String> deleteProduct(@PathVariable("id") Long id) {
        produsService.deleteProdusById(id);
        return ResponseEntity.ok().body("Product deleted successfully");
    }
    
    @PutMapping("/editProduct/{id}")
    @ResponseBody
    public ResponseEntity<String> editProduct(@PathVariable("id") Long id,
                                              @RequestParam("productName") String name,
                                              @RequestParam("productPrice") double price,
                                              @RequestParam("productWeight") int weight,
                                              @RequestParam("productCategory") String category) {
        // Retrieve the existing product
        Produs existingProdus = produsService.findById(id);
        if (existingProdus == null) {
            return ResponseEntity.notFound().build();
        }
        
        // Update the product details
        existingProdus.setName(name);
        existingProdus.setPrice(price);
        existingProdus.setWeight(weight);
        existingProdus.setCategory(category);
        
        // Save the updated product
        produsService.addProdus(existingProdus);
        
        return ResponseEntity.ok().body("Product updated successfully");
    }
    @PutMapping("/updateProductAmount/{id}")
    @ResponseBody
    public ResponseEntity<String> updateProductAmount(@PathVariable("id") Long id,
                                                      @RequestParam("amount") int amount) {
        Produs existingProdus = produsService.findById(id);
        if (existingProdus == null) {
            return ResponseEntity.notFound().build();
        }
        
        existingProdus.setAmount(amount);
        produsService.addProdus(existingProdus);
        
        return ResponseEntity.ok().body("Product amount updated successfully");
    }
    
}
