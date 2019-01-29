package com.codingdojo.tangled.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.tangled.models.Dislike;
import com.codingdojo.tangled.models.User;

@Repository
public interface DislikeRepo extends CrudRepository<Dislike, Long>{
	List<Dislike> findByUser(User user);
}
