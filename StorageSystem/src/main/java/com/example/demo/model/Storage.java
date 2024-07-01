package com.example.demo.model;

import java.util.ArrayList;
import java.util.HashSet;

import java.util.Set;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.OneToMany;
import javax.persistence.*;
import com.example.demo.model.Category;

@Entity
public class Storage {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String name;
    private int maxCapacity;
    private int currentCapacity;
    
    @ManyToMany
    @JoinTable(
        name = "STORAGE_CATEGORIES",
        joinColumns = @JoinColumn(name = "storage_id"),
        inverseJoinColumns = @JoinColumn(name = "category_id")
    )
    private Set<Category> categories;
    
    private String location;
    private int availability;
    
    @OneToMany(mappedBy = "storage")
    private Set<Produs> produse;
    
    // Getters and Setters

    public Long getId() {
        return id;
    }
    
    public void setAvailability(int available) {
    	this.availability = available;
    }
    
    public int getAvailability() {
        return getMaxCapacity() - getCurrentCapacity();
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getMaxCapacity() {
        return maxCapacity;
    }

    public void setMaxCapacity(int maxCapacity) {
        this.maxCapacity = maxCapacity;
    }
    
    public int getCurrentCapacity() {
        if (produse != null) {
            return produse.size();
        } else {
            return 0; // If produse is null, return 0
        }
    }


    public void setCurrentCapacity(int currentCapacity) {
        this.currentCapacity = currentCapacity;
    }

    public Set<Category> getCategories() {
        return categories;
    }

    public void setCategories(Set<Category> categories) {
        this.categories = categories;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }
}