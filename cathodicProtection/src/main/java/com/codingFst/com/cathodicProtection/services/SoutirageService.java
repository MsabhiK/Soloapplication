package com.codingFst.com.cathodicProtection.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingFst.com.cathodicProtection.models.Soutirage;
import com.codingFst.com.cathodicProtection.models.User;
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
    // creates a posted Soutirage
    public Soutirage createSoutirage(Soutirage s) {
        return soutirageRepo.save(s);
    }
    
 // retrieves a soutirage
    public Soutirage findSoutirage(Long id) {
        Optional<Soutirage> optionalSoutirage = soutirageRepo.findById(id);
        if(optionalSoutirage.isPresent()) {
            return optionalSoutirage.get();
        } else {
            return null;
        }
    }
    
  //list all of soutirages by one user
    public List<Soutirage> findByUser(User user) {
        return soutirageRepo.findByUser(user);
    }
    
    public Soutirage updateSoutirage(Soutirage soutirage) {
		return soutirageRepo.save(soutirage);
	}
	
	public void removeFromUser(Soutirage soutirage) {
		soutirageRepo.delete(soutirage);
	}
    
}
