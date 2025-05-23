package com.codingFst.com.cathodicProtection.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingFst.com.cathodicProtection.models.Gazoduc;
import com.codingFst.com.cathodicProtection.models.User;

@Repository
public interface GazoducRepository extends CrudRepository<Gazoduc, Long> {
	List<Gazoduc> findAll();
	List<Gazoduc> findByUser(User user);
	
	List<Gazoduc> findByUserIdIs(Long userId);
}
