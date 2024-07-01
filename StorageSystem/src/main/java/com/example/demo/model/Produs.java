package com.example.demo.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

@Entity
public class Produs {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    private String name;
    private String category;
    @ManyToOne
    @JoinColumn(name = "storage_id")
    private Storage storage;
    private double weight;
    private double price;
    private int amount;

    // Constructor
    public Produs(String name, String category, Storage storage, int weight, double price) {
        this.name = name;
        this.category = category;
        this.storage = storage;
        this.weight = weight;
        this.price = price;
        amount = 1;
    }

    // Default constructor
    public Produs() {}

    // Getters and Setters
    public long getId() {
        return id;
    }
    
    public int getAmount() {
    	return amount;
    }
    
    public void setAmount(int amount) {
    	this.amount = amount;
    }

    public void setId(long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public Storage getStorage() {
        return storage;
    }

    public void setStorage(Storage storage) {
        this.storage = storage;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double d) {
        this.weight = d;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

}

