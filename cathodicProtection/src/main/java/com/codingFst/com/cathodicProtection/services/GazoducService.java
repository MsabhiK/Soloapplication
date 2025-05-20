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
	
	// returns all the gazoducs
    public List<Gazoduc> allGazoducs() {
        return gazoducRepo.findAll();
    }
    // creates a posted Gazoduc
    public Gazoduc createGazoduc(Gazoduc g) {
        return gazoducRepo.save(g);
    }
    // retrieves a gazoduc
    public Gazoduc findGazoduc(Long id) {
        Optional<Gazoduc> optionalGazoduc = gazoducRepo.findById(id);
        if(optionalGazoduc.isPresent()) {
            return optionalGazoduc.get();
        } else {
            return null;
        }
    }
    
  //list all of gazoducs by one user
    public List<Gazoduc> userGazoducs(Long userId) {
		return gazoducRepo.findByUserIdIs(userId);
	}
    
    public Gazoduc updateGazoduc(Gazoduc gazoduc) {
		return gazoducRepo.save(gazoduc);
	}
	
	public void removeFromUser(Gazoduc gazoduc) {
		gazoducRepo.delete(gazoduc);
	}
}
