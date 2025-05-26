package com.codingFst.com.cathodicProtection.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.codingFst.com.cathodicProtection.models.Parametre;
import com.codingFst.com.cathodicProtection.models.Soutirage;
import com.codingFst.com.cathodicProtection.repositories.ParametreRepository;

@Service
public class ParametreService {
	
	 @Autowired
	 private ParametreRepository parametreRepo;
	

	  public List<Parametre> getAssignedParametres(Soutirage soutirage){
			return parametreRepo.findAllBySoutirage(soutirage);
		}
	  
	  
	  
	  public Parametre createParametre(Parametre para) {
	      return parametreRepo.save(para);
	  }
	  
	  	// retrieves a Parametre
	    public Parametre findParametre(Long id) {
	        Optional<Parametre> optionalParametre = parametreRepo.findById(id);
	        if(optionalParametre.isPresent()) {
	            return optionalParametre.get();
	        } else {
	            return null;
	        }
	    }
	    
	    public Parametre updateParametre(Parametre parametre) {
			return parametreRepo.save(parametre);
		}
	    
	    public void removeFromUser(Parametre parametre) {
	    	parametreRepo.delete(parametre);
		}

}
