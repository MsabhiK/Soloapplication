package com.codingFst.com.cathodicProtection.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingFst.com.cathodicProtection.models.Soutirage;
import com.codingFst.com.cathodicProtection.models.User;

@Repository
public interface SoutirageRepository extends CrudRepository<Soutirage, Long> {
	@SuppressWarnings("null")
	List<Soutirage> findAll();
	List<Soutirage> findByUser(User user);

}
