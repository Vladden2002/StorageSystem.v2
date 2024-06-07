package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Produs;
import com.example.demo.repository.ProdusRepo;

@Service
public class ProdusService {
	@Autowired
	private final ProdusRepo produsRepository;

    @Autowired
    public ProdusService(ProdusRepo produsRepository) {
        this.produsRepository = produsRepository;
    }

    public void addProdus(Produs produs) {
        produsRepository.save(produs);
    }

    public List<Produs> findByCategory(String category) {
        return produsRepository.findByCategory(category);
    }
}
