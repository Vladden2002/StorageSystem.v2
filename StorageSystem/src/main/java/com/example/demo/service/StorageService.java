package com.example.demo.service;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.demo.model.Storage;
import com.example.demo.repository.StorageRepo;

@Service
public class StorageService {
	
	@Autowired
	private StorageRepo storageRepository;

	
	public List<Storage> getAllStorages() {
        return (List<Storage>) storageRepository.findAll();
    }
	
	public Storage findById(Long id) {
        Optional<Storage> storageOptional = storageRepository.findById(id);
        return storageOptional.orElse(null);
    }
	
	
}
