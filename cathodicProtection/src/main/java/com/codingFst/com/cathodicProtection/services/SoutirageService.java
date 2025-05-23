package com.codingFst.com.cathodicProtection.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;


import com.codingFst.com.cathodicProtection.models.Soutirage;
import com.codingFst.com.cathodicProtection.repositories.SoutirageRepository;

@Service
public class SoutirageService {
	
	@Autowired
	private final SoutirageRepository soutirageRepo;
	public SoutirageService(SoutirageRepository soutirageRepo) {
		this.soutirageRepo=soutirageRepo;
	}
	
	// returns all the soutirages
    public List<Soutirage> allSoutirages() {
        return soutirageRepo.findAll();
    }
    // creates a posted Gazoduc
    public Soutirage createSoutirage(Soutirage s) {
        return soutirageRepo.save(s);
    }
}
