package com.codingFst.com.cathodicProtection.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingFst.com.cathodicProtection.models.Gazoduc;
import com.codingFst.com.cathodicProtection.models.Prise;
import com.codingFst.com.cathodicProtection.repositories.PriseRepository;

@Service
public class PriseService {
	
	@Autowired
	 private PriseRepository priseRepository;
	
 
	  public List<Prise> getAssignedPrises(Gazoduc gazoduc){
			return priseRepository.findAllByGazoduc(gazoduc);
		}
	  
	  
	  
	  public Prise createPrise(Prise p) {
	      return priseRepository.save(p);
	  }
	  
	  	// retrieves a prise
	    public Prise findPrise(Long id) {
	        Optional<Prise> optionalPrise = priseRepository.findById(id);
	        if(optionalPrise.isPresent()) {
	            return optionalPrise.get();
	        } else {
	            return null;
	        }
	    }
	    
	    public Prise updatePrise(Prise prise) {
			return priseRepository.save(prise);
		}
}


