package com.codingdojo.tangled.controllers;

import java.security.Principal;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.codingdojo.tangled.services.MainService;
import com.codingdojo.tangled.services.UserService;

@Controller
@RequestMapping("/")
public class MainController {
	private final UserService userService;
	private final MainService mainService;
	
	public MainController(UserService userService, MainService mainService) {
		this.userService = userService;
		this.mainService = mainService;
	}
	
//	display home page whether you are a logged in user or not
	@RequestMapping("")
	public String home(Principal principal, Model model) {
		if (principal != null) {
			String username = principal.getName();
			model.addAttribute("currentUser", userService.findByUsername(username));
		} else {
			model.addAttribute("currentUser", null);
		}
		model.addAttribute("allPosts", mainService.allPosts());
		model.addAttribute("popularUsers", mainService.getMostPopularUsers());
		return "mainContent.jsp";
	}
	
//	sort posts 
	@GetMapping("sort/{newsort}")
    public String sort(@PathVariable("newsort") String sort, Model model, Principal principal) {
    	if (principal != null) {
			String username = principal.getName();
			model.addAttribute("currentUser", userService.findByUsername(username));
		} else {
			model.addAttribute("currentUser", null);
		}
    	
    	model.addAttribute("allPosts", mainService.sortedPosts(sort));
    	return "allPosts.jsp";
    }
	
	
}
