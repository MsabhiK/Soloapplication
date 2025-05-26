package com.codingFst.com.cathodicProtection.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingFst.com.cathodicProtection.models.Gazoduc;
import com.codingFst.com.cathodicProtection.models.Prise;

@Repository
public interface PriseRepository extends CrudRepository<Prise, Long> {
	
	List<Prise> findAllByGazoduc(Gazoduc gazoduc);

}
