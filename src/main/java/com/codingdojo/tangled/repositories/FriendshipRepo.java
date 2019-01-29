package com.codingdojo.tangled.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.codingdojo.tangled.models.Friendship;
import com.codingdojo.tangled.models.User;

@Repository
public interface FriendshipRepo extends CrudRepository<Friendship, Long>{
	List<Friendship> findByFriend(User user);
	List<Friendship> findByUser(User user);
}
