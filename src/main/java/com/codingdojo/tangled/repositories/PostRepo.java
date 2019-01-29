package com.codingdojo.tangled.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.tangled.models.Post;
import com.codingdojo.tangled.models.User;

@Repository
public interface PostRepo extends CrudRepository<Post, Long>{
	List<Post> findAll();
	List<Post> findByOrderByCreatedAtDesc();
	List<Post> findByOrderByCreatedAt();
	List<Post> findByOrderByNumLikes();
	List<Post> findByOrderByNumLikesDesc();
	List<Post> findByCreator(User user);
}
