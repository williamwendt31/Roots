package com.codingdojo.tangled.services;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.codingdojo.tangled.models.User;
import com.codingdojo.tangled.repositories.RoleRepo;
import com.codingdojo.tangled.repositories.UserRepo;

@Service
public class UserService {
    private UserRepo userRepo;
    private RoleRepo roleRepo;
    private BCryptPasswordEncoder bCryptPasswordEncoder;
    
    public UserService(UserRepo userRepo, RoleRepo roleRepo, BCryptPasswordEncoder bCryptPasswordEncoder)     {
        this.userRepo = userRepo;
        this.roleRepo = roleRepo;
        this.bCryptPasswordEncoder = bCryptPasswordEncoder;
    }
    
    //function names speak for themselves 
    
    public void saveWithUserRole(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(roleRepo.findByName("ROLE_USER"));
        user.setProfilePicPath("/default_image/default.jpg");
        user.setBackgroundPicPath("/default_image/background.jpeg");
        userRepo.save(user);
    }
     
    public void saveUserWithAdminRole(User user) {
        user.setPassword(bCryptPasswordEncoder.encode(user.getPassword()));
        user.setRoles(roleRepo.findByName("ROLE_ADMIN"));
        userRepo.save(user);
    }    
    
   
    public User findByUsername(String username) {
        return userRepo.findByUsername(username);
    }
    
    public boolean emailAlreadyExists(String email) {
    	if(userRepo.findByEmail(email) != null) {
    		return true;
    	} else {
    		return false;
    	}
    }
    
    public boolean usernameAlreadyExists(String username) {
    	if (userRepo.findByUsername(username) != null) {
    		return true; 
    	} else {
    		return false;
    	}
    }
    
    public void deleteAccount(String username) {
    	userRepo.delete(findByUsername(username));
    }
    
    public boolean oldPasswordMatches(String username, String oldPassword) {
    	if (bCryptPasswordEncoder.matches(oldPassword, userRepo.findByUsername(username).getPassword())) {
    		return true;
    	} else {
    		return false;
    	}
    }
    
    public void changePassword(String username, String newPassword) {
    	User user = userRepo.findByUsername(username);
    	user.setPassword(bCryptPasswordEncoder.encode(newPassword));
    	user.setPasswordConf(bCryptPasswordEncoder.encode(newPassword));
    	userRepo.save(user);
    }
    
    public void changeProfilePic(String username, String filePath) {
    	User user = userRepo.findByUsername(username);
    	user.setProfilePicPath(filePath);
    	userRepo.save(user);
    }
}
