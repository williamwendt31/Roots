package com.codingdojo.tangled.services;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.codingdojo.tangled.models.Comment;
import com.codingdojo.tangled.models.Dislike;
import com.codingdojo.tangled.models.Friendship;
import com.codingdojo.tangled.models.Like;
import com.codingdojo.tangled.models.Post;
import com.codingdojo.tangled.models.User;
import com.codingdojo.tangled.repositories.CommentRepo;
import com.codingdojo.tangled.repositories.DislikeRepo;
import com.codingdojo.tangled.repositories.FriendshipRepo;
import com.codingdojo.tangled.repositories.LikeRepo;
import com.codingdojo.tangled.repositories.PostRepo;
import com.codingdojo.tangled.repositories.UserRepo;

@Service
public class MainService {
	private final UserRepo userRepo;
	private final PostRepo postRepo;
	private final LikeRepo likeRepo;
	private final CommentRepo commentRepo;
	private final DislikeRepo dislikeRepo;
	private final FriendshipRepo friendshipRepo;
	
	
	public MainService(UserRepo userRepo, PostRepo postRepo, LikeRepo likeRepo, CommentRepo commentRepo, DislikeRepo dislikeRepo, FriendshipRepo friendshipRepo) {
		this.userRepo = userRepo;
		this.postRepo = postRepo;
		this.likeRepo = likeRepo;
		this.commentRepo = commentRepo;
		this.dislikeRepo = dislikeRepo;
		this.friendshipRepo = friendshipRepo;
	}
	
	// function names speak for themselves
	
	public List<Post> allPosts() {
		return postRepo.findAll();
	}
	
	public Post findPostById(Long id) {
		Optional<Post> post = postRepo.findById(id);
		if (post.isPresent()) {
			return post.get();
		} else {
			return null;
		}
	}
	
	public User findUserById(Long id) {
		Optional<User> user = userRepo.findById(id);
		if (user.isPresent()) {
			return user.get();
		} else {
			return null;
		}
	}
	
	public void createPost(String username, String filePath, String caption) {
		Post newPost = new Post();
		newPost.setCreator(userRepo.findByUsername(username));
		newPost.setImagePath(filePath);
		newPost.setCaption(caption);
		postRepo.save(newPost);
	}
	
	public int likePost(String username, Long postId) {
		Like like = new Like();
		Post post = findPostById(postId);
		post.setNumLikes(post.getNumLikes() + 1);
		postRepo.save(post);
		like.setPost(post);
		like.setUser(userRepo.findByUsername(username));
		likeRepo.save(like);
		return post.getNumLikes();
	}
	
	public int dislikePost(String username, Long postId) {
		Dislike dislike = new Dislike();
		Post post = findPostById(postId);
		post.setNumDislikes(post.getNumDislikes() + 1);
		postRepo.save(post);
		dislike.setPost(post);
		dislike.setUser(userRepo.findByUsername(username));
		dislikeRepo.save(dislike);
		return post.getNumDislikes();
	}
	
	public List<Post> sortedPosts(String sort) {
		if (sort.equals("popular")) {
			return postRepo.findByOrderByNumLikesDesc();
		} else if (sort.equals("recent")) {
			return postRepo.findByOrderByCreatedAtDesc();
		} else {
			return allPosts();
		}
	}
	
	public void newComment(String username, Long postId, String comment) {
		Comment newComment = new Comment();
		newComment.setComment(comment);
		newComment.setPost(findPostById(postId));
		newComment.setUser(userRepo.findByUsername(username));
		commentRepo.save(newComment);
	}
	
	public void newFriendship(String username, Long friendId) {
		Friendship friendship = new Friendship();
		friendship.setUser(userRepo.findByUsername(username));
		User friend = findUserById(friendId);
		friend.setNumberOfFollowers(friend.getNumberOfFollowers() + 1);
		friendship.setFriend(friend);
		friendshipRepo.save(friendship);
		userRepo.save(friend);
	}
	
	public List<Comment> allCommentsForPost(Long postId) {
		return commentRepo.findByPost(findPostById(postId));
	}
	
	public List<Post> postsByUser(Long userId) {
		return postRepo.findByCreator(findUserById(userId));
	}
	
	public List<Friendship> allFollowersForUser(Long userId) {
		return friendshipRepo.findByFriend(findUserById(userId));
	}
	
	public List<Friendship> allFollowingForUser(Long userId) {
		return friendshipRepo.findByUser(findUserById(userId));
	}
	
	public List<Like> allLikedPostsByUser(User user) {
		return likeRepo.findByUser(user);
	}
	
	public List<Post> likedPostsByUser(Long userId) {
		List<Post> posts = new ArrayList<>();
		for (Like like : allLikedPostsByUser(findUserById(userId))) {
			posts.add(like.getPost());
		}
		return posts;
	}
	
	public List<Dislike> allDislikedPostsByUser(User user) {
		return dislikeRepo.findByUser(user);
	}
	
	public List<Post> dislikedPostsByUser(Long userId) {
		List<Post> posts = new ArrayList<>();
		for (Dislike dislike : allDislikedPostsByUser(findUserById(userId))) {
			posts.add(dislike.getPost());
		}
		return posts;
	}
	
	public List<User> getMostPopularUsers() {
		return this.userRepo.findTop10ByOrderByNumberOfFollowersDesc();
	}
}
