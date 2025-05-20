package com.codingFst.com.cathodicProtection.services;

import java.util.List;

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
}


