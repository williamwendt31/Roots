package com.codingdojo.tangled.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.codingdojo.tangled.services.AmazonClient;
import com.codingdojo.tangled.services.MainService;

@Controller
@RequestMapping("/post")
public class PostController {
	private AmazonClient amazonClient;
	private MainService mainService;
	
    public PostController(AmazonClient amazonClient, MainService mainService) {
        this.amazonClient = amazonClient;
        this.mainService = mainService;
    }
    
//    add like to post
    @GetMapping("/{postId}/like")
    @ResponseBody
    public int likePost(@PathVariable("postId") Long postId, Principal principal) {
    	String username = principal.getName();
    	
    	return mainService.likePost(username, postId);
    }

//    add dislike to post
    @GetMapping("/{postId}/dislike")
    @ResponseBody
    public int dislikePost(@PathVariable("postId") Long postId, Principal principal) {
    	String username = principal.getName();
    	
    	return mainService.dislikePost(username, postId);
    	
    }
    
//    create new post and add image to s3 bucket
    @PostMapping("/newPost")
    public String uploadFile(Principal principal, @RequestPart(value = "image") MultipartFile file, @RequestPart(value = "caption", required = false) String caption) {
    	String username = principal.getName();
        mainService.createPost(username, this.amazonClient.uploadFile(file), caption);
        return "redirect:/";
    }
    
//    delete post and remove image from s3 bucket
    @DeleteMapping("/deleteFile")
    public String deleteFile(@RequestPart(value = "url") String fileUrl) {
        return this.amazonClient.deleteFileFromS3Bucket(fileUrl);
    }
    
//    ajax request to grab all comments for post
    @GetMapping("/{postId}/allComments")
    public String showComments(@PathVariable("postId") Long postId, Model model) {
    	model.addAttribute("allComments", mainService.allCommentsForPost(postId));
    	return "comments.jsp";
    }
    
//    new comment to this post by this user
    @PostMapping("/{postId}/newComment")
    public String newComment(@PathVariable("postId") Long postId, @RequestParam("comment") String comment, Principal principal) {
    	String username = principal.getName();
    	mainService.newComment(username, postId, comment);
    	return "redirect:/";
    }
}
