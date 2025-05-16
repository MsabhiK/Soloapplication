package com.codingFst.com.cathodicProtection.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingFst.com.cathodicProtection.models.Gazoduc;
import com.codingFst.com.cathodicProtection.repositories.GazoducRepository;

@Service
public class GazoducService {
	
	@Autowired
	private final GazoducRepository gazoducRepo;
	
	public GazoducService(GazoducRepository gazoducRepo) {
		this.gazoducRepo=gazoducRepo;
	}
	
	// returns all the houses
    public List<Gazoduc> allGazoducs() {
        return gazoducRepo.findAll();
    }
    // creates a posted House
    public Gazoduc createHouse(Gazoduc g) {
        return gazoducRepo.save(g);
    }
    // retrieves a house
    public Gazoduc findGazoduc(Long id) {
        Optional<Gazoduc> optionalGazoduc = gazoducRepo.findById(id);
        if(optionalGazoduc.isPresent()) {
            return optionalGazoduc.get();
        } else {
            return null;
        }
    }
}
