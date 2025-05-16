package com.codingFst.com.cathodicProtection.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingFst.com.cathodicProtection.models.Gazoduc;

@Repository
public interface GazoducRepository extends CrudRepository<Gazoduc, Long> {
	List<Gazoduc> findAll();
	
	List<Gazoduc> findByUserIdIs(Long userId);
}
