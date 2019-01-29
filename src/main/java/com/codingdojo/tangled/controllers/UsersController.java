package com.codingdojo.tangled.controllers;

import java.security.Principal;

import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.codingdojo.tangled.models.User;
import com.codingdojo.tangled.services.AmazonClient;
import com.codingdojo.tangled.services.MainService;
import com.codingdojo.tangled.services.UserService;
import com.codingdojo.tangled.validator.UserValidator;

@Controller
public class UsersController {
	private final UserService userService;
	private final UserValidator us;
	private final AmazonClient amazonClient;
	private final MainService mainService;
	
	public UsersController(UserService userService, UserValidator us, AmazonClient amazonClient, MainService mainService) {
		this.userService = userService;
		this.amazonClient = amazonClient;
		this.mainService = mainService;
		this.us = us;
	}
	
//	display reg form
	@GetMapping("/registration")
	public String registerForm(@ModelAttribute("user") User user) {
		return "registrationPage.jsp";
	}
	
//	validate reg form and insert into database
	@PostMapping("/registration")
	public String registration(@Valid @ModelAttribute("user") User user, BindingResult result, Model model, RedirectAttributes ra) {
		us.validate(user, result);
		if (result.hasErrors()) {
			return "registrationPage.jsp";
		} else {
			if (userService.usernameAlreadyExists(user.getUsername())) {
				ra.addFlashAttribute("error", "That username already exists");
				return "redirect:/registration";
			} else if(userService.emailAlreadyExists(user.getEmail())) {
				ra.addFlashAttribute("error", "That email already exists");
				return "redirect:/registration";
			}
			userService.saveWithUserRole(user);
			return "redirect:/login";
		}
	}
	
//	validate login form and query database
	@GetMapping("/login")
    public String login(@RequestParam(value="error", required=false) String error, @RequestParam(value="logout", required=false) String logout, Model model) {
        if(error != null) {
            model.addAttribute("errorMessage", "Invalid Credentials, Please try again.");
        }
        if(logout != null) {
            return "redirect:/";
        }
        return "loginPage.jsp";
    }
	
//	form to retrieve password through email
	@GetMapping("/forgotPassword")
	public String forgotPasswordForm() {
		return "forgotPassword.jsp";
	}
	
//	process forgot password form and send email to that user
	@PostMapping("/forgotPassword")
	public String retrievePassword(@RequestParam("email") String email, RedirectAttributes ra) {
		return "redirect:/forgotPassword";
	}
	
//	deletes account that is signed in through delete request
	@DeleteMapping("/deleteAccount")
	public String deleteAccount(Principal principal) {
		String username = principal.getName();
		userService.deleteAccount(username);
		return "redirect:/";
	}
	
//	show change password form
	@GetMapping("/changePassword")
	public String changePassword(Principal principal, Model model) {
		String username = principal.getName();
		model.addAttribute("currentUser", userService.findByUsername(username));
		return "changePassword.jsp";
	}
	
//	change users password
	@PutMapping("/changePassword")
	public String processChangePassword(Principal principal, @RequestParam("oldPassword") String oldPassword, @RequestParam("newPassword") String newPassword, @RequestParam("newPasswordConf") String newPasswordConf, RedirectAttributes ra) {
		String username = principal.getName();
		boolean error = false;
		if (oldPassword.length() == 0 || newPassword.length() == 0 || newPasswordConf.length() == 0) {
			ra.addFlashAttribute("error", "All Fields Required");
			error = true;
		} else if (!newPassword.equals(newPasswordConf)) {
			ra.addFlashAttribute("error", "New Password and Password Confirmation must match");
			error = true;
		} else if (!userService.oldPasswordMatches(username, oldPassword)) {
			ra.addFlashAttribute("error", "Invalid Credentials");
			error = true;
		} else {
			userService.changePassword(username, newPasswordConf);
		}
		if (error == true) {
			return "redirect:/changePassword";
		} else {
			return "redirect:/";
		}
	}
	
//	change users profile pic
	@PutMapping("/changeProfilePic")
	public String processChangeProfilePic(Principal principal, @RequestParam("image") MultipartFile file) {
		if (file == null) {
			return "redirect:/";
		} else {
			String username = principal.getName();
			userService.changeProfilePic(username, amazonClient.uploadFile(file));
			return "redirect:/";
		}
	}
	
//	show profile of specific user
	@GetMapping("/profile/{userId}")
	public String profilePage(Principal principal, @PathVariable("userId") Long userId, Model model) {
		String username = principal.getName();
		model.addAttribute("currentUser", userService.findByUsername(username));
		model.addAttribute("allPosts", mainService.postsByUser(userId));
		model.addAttribute("profileUser", mainService.findUserById(userId));
		return "profilePage.jsp";
	}
	
//	process follow button
	@GetMapping("/follow/{friendId}")
	public String newFriendship(Principal principal, @PathVariable("friendId") Long friendId, Model model) {
		String username = principal.getName();
		mainService.newFriendship(username, friendId);
		return "redirect:/profile/" + friendId;
	}
	
//	show all followers for specific user
	@GetMapping("/followers/{userId}")
	public String showFollowers(@PathVariable("userId") Long userId, Model model) {
		model.addAttribute("allFriends", mainService.allFollowersForUser(userId));
		model.addAttribute("followers", true);
		return "friendships.jsp";
	}
	
//	show all users that this user is following
	@GetMapping("/following/{userId}")
	public String showFollowing(@PathVariable("userId") Long userId, Model model) {
		model.addAttribute("allFriends", mainService.allFollowingForUser(userId));
		model.addAttribute("followers", false);
		return "friendships.jsp";
	}
	
//	show all posts this user liked
	@GetMapping("/likedPosts/{userId}")
	public String showLikePosts(@PathVariable("userId") Long userId, Model model, Principal principal) {
		String username = principal.getName();
		model.addAttribute("allPosts", mainService.likedPostsByUser(userId));
		model.addAttribute("currentUser", userService.findByUsername(username));
		return "allPosts.jsp";
	}
	
//	show all posts this user disliked
	@GetMapping("/dislikedPosts/{userId}")
	public String showDislikePosts(@PathVariable("userId") Long userId, Model model, Principal principal) {
		String username = principal.getName();
		model.addAttribute("allPosts", mainService.dislikedPostsByUser(userId));
		model.addAttribute("currentUser", userService.findByUsername(username));
		return "allPosts.jsp";
	}
}
