package com.codingdojo.tangled.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.tangled.models.Comment;
import com.codingdojo.tangled.models.Post;

@Repository
public interface CommentRepo extends CrudRepository<Comment, Long>{
	List<Comment> findByPost(Post post);
}
