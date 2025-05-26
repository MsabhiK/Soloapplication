package com.codingFst.com.cathodicProtection.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingFst.com.cathodicProtection.models.Parametre;
import com.codingFst.com.cathodicProtection.models.Soutirage;

@Repository
public interface ParametreRepository extends CrudRepository<Parametre, Long> {
	
	List<Parametre> findAllBySoutirage(Soutirage soutirage);
	List<Parametre> findBySoutirageId(Long id);
}
