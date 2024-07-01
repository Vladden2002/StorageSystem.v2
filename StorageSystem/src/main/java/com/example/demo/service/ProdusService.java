package com.example.demo.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.demo.model.Produs;
import com.example.demo.repository.ProdusRepo;

@Service
public class ProdusService {

    private final ProdusRepo produsRepository;

    @Autowired
    public ProdusService(ProdusRepo produsRepository) {
        this.produsRepository = produsRepository;
    }

    public void addProdus(Produs produs) {
        produsRepository.save(produs);
    }
    
    public List<Produs> getAllProdusByStorageId(Long storageId) {
        return (List<Produs>) produsRepository.findByStorageId(storageId);
    }

    public void deleteProdusById(Long id) {
        produsRepository.deleteById(id);
    }
    
    public Produs findById(Long id) {
        return produsRepository.findById(id).orElse(null);
    }
    
    
}
