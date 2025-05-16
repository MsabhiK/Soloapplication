package com.codingFst.com.cathodicProtection.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingFst.com.cathodicProtection.models.LoginUser;
import com.codingFst.com.cathodicProtection.models.User;
import com.codingFst.com.cathodicProtection.services.GazoducService;
import com.codingFst.com.cathodicProtection.services.UserService;

import jakarta.servlet.http.HttpSession;
import jakarta.validation.Valid;



@Controller
public class MainController {

	// Add once service is implemented:
		@Autowired
		private UserService userServ;
		
		@Autowired
		private GazoducService gazoducServ;
		
		@GetMapping("/")
		 public String index(Model model) {
			model.addAttribute("newLogin", new LoginUser());
		    model.addAttribute("newUser", new User());
		    return "index.jsp";
		}
		     
		@GetMapping("/newuser")
		public String newuser(Model model) {
			model.addAttribute("newLogin", new LoginUser());
			model.addAttribute("newUser", new User());
			return "newuser.jsp";
		}
		
		@PostMapping("/register")
		 public String register(@Valid @ModelAttribute("newUser") User newUser, 
		         BindingResult result, Model model, HttpSession session) {
		   
			 User user = userServ.register(newUser, result);
		     if(result.hasErrors()) {
		         
		         model.addAttribute("newLogin", new LoginUser());
		         return "newuser.jsp";
		     }else {
		    	 session.setAttribute("userId", user.getId());
		    	 return "redirect:/home";
		     }
		 }
		 
		 @PostMapping("/login")
		 public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, 
		            BindingResult result, Model model, HttpSession session) {
		        
		        User user = userServ.login(newLogin, result);
		    
		        if(result.hasErrors()) {
		            model.addAttribute("newUser", new User());
		            return "index.jsp";
		        }
		  
		        session.setAttribute("userId", user.getId());
		    
		        return "redirect:/home";
		    }
		 
		 @GetMapping("/logout")
		 public String logout(HttpSession session) {
		    	session.invalidate();
		    	return "redirect:/";
		    }
		 
		 @GetMapping("/home")
		 public String home(Model model, HttpSession session) {
			 if(session.getAttribute("userId")== null) {
				 return"redirect:/";
			 }else {
				 model.addAttribute("user", userServ.findById((Long)session.getAttribute("userId")));
				 model.addAttribute("gazoducs", gazoducServ.allGazoducs());
				 return "dashboard.jsp";
			    }
			 
		 }
		 @PostMapping("/showMap")
		 public String showMap(@RequestParam("latitude") String lat,
		                          @RequestParam("longitude") String lon,
		                          Model model) {
		        model.addAttribute("latitude", lat);
		        model.addAttribute("longitude", lon);
		        return "redirect:/home";
		    }
		 
}
