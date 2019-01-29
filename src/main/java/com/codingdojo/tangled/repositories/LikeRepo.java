package com.codingdojo.tangled.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.tangled.models.Like;
import com.codingdojo.tangled.models.User;

@Repository
public interface LikeRepo extends CrudRepository<Like, Long>{
	List<Like> findByUser(User user);
}
