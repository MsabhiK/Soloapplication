package com.codingFst.com.cathodicProtection.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
//import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestParam;

import com.codingFst.com.cathodicProtection.models.Gazoduc;
import com.codingFst.com.cathodicProtection.models.LoginUser;
import com.codingFst.com.cathodicProtection.models.Prise;
import com.codingFst.com.cathodicProtection.models.Soutirage;
import com.codingFst.com.cathodicProtection.models.User;
import com.codingFst.com.cathodicProtection.services.GazoducService;
import com.codingFst.com.cathodicProtection.services.PriseService;
import com.codingFst.com.cathodicProtection.services.SoutirageService;
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
		
		@Autowired
		private PriseService priseServ;
		
		@Autowired
		private SoutirageService soutirageServ;
		
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
				 model.addAttribute("soutirages", soutirageServ.allSoutirages());
				 return "dashboard.jsp";
			    }
			 
		 }
		 
		 @GetMapping("/addGazoduc")
		 public String addGazoduc(@ModelAttribute("gazoduc") Gazoduc gazoduc, Model model, HttpSession session) {
		  
		    	User user = userServ.findById((Long)session.getAttribute("userId"));
		    	model.addAttribute("user", user);
		    	
		    	return "addGazoduc.jsp";
		    }
		    
		 @PostMapping("/addGazoduc/new")
		 public String createGazoduc(@Valid @ModelAttribute("gazoduc") Gazoduc gazoduc, BindingResult result) {

		    if (result.hasErrors()) {
		    	return "addGazoduc.jsp";
		    } else {
		    	
		    gazoducServ.createGazoduc(gazoduc);
		    return "redirect:/home";
		    }
		  }
		 
		 	@GetMapping("/gazoducs/{gazoducId}")
		    public String showPrises(@ModelAttribute("prise") Prise prise,
		    		@RequestParam(value = "latitude", required = false) Double lat,
		    	    @RequestParam(value = "longitude", required = false) Double lon,
                     Model model, @PathVariable("gazoducId") Long gazoducId, HttpSession session) {
		    	if(session.getAttribute("userId") == null) {
		    		return "redirect:/home";
		    	}
		    	Gazoduc gazoduc = gazoducServ.findGazoduc(gazoducId);
		 
		    	model.addAttribute("gazoduc", gazoduc);
		    	model.addAttribute("assignedGazoduc", priseServ.getAssignedPrises(gazoduc));
		    	model.addAttribute("user", userServ.findById((Long)session.getAttribute("userId")));
		    	
		    	if (lat != null && lon != null) {
		            model.addAttribute("latitude", lat);
		            model.addAttribute("longitude", lon);
		        }
		    	
		    	return "prises.jsp";
		    }
		 	
		 	@GetMapping("/gazoducs/addPrise")
			 public String addPrise(@ModelAttribute("prise") Prise prise, @ModelAttribute("gazoduc") Gazoduc gazoduc, Model model, HttpSession session) {
			  
			    	User user = userServ.findById((Long)session.getAttribute("userId"));
			    	model.addAttribute("gazoduc", gazoduc);
			    	model.addAttribute("gazoducsByuser", gazoducServ.findByUser(user));
			    	model.addAttribute("user", user);
			    	
			    	return "addPrise.jsp";
			 }
		 	
		 	@PostMapping("/gazoducs/addPrise/new")
			 public String createGazoduc(@Valid @ModelAttribute("prise") Prise prise, BindingResult result, Model model, HttpSession session) {

			    if (result.hasErrors()) {
			    	User user = userServ.findById((Long)session.getAttribute("userId"));
			    	model.addAttribute("user", user);
			    	model.addAttribute("gazoducsByuser", gazoducServ.findByUser(user));
			    	return "addPrise.jsp";
			    } else {
			    	
			    priseServ.createPrise(prise);
			    return "redirect:/home";
			    }
			  }
		 	
		 	@GetMapping("/addSoutirage")
			 public String addSoutirage(@ModelAttribute("soutirage") Soutirage soutirage, Model model, HttpSession session) {
			  
			    	User user = userServ.findById((Long)session.getAttribute("userId"));
			    	model.addAttribute("user", user);
			    	
			    	return "addSoutirage.jsp";
			    }
			    
			 @PostMapping("/addSoutirage/new")
			 public String createSoutirage(@Valid @ModelAttribute("soutirage") Soutirage soutirage, BindingResult result) {

			    if (result.hasErrors()) {
			    	return "addSoutirage.jsp";
			    } else {
			    	
			    soutirageServ.createSoutirage(soutirage);
			    return "redirect:/home";
			    }
			  }
			 
			 @GetMapping("/gazoducs/{id}/edit")
			    public String editGazoduc(Model model, @PathVariable("id") Long id, HttpSession session) {
			    	if(session.getAttribute("userId") == null) {
			    		return "redirect:/home";
			    	}
			    	Gazoduc gazoduc = gazoducServ.findGazoduc(id);
			    	model.addAttribute("gazoduc", gazoduc);
			    	model.addAttribute("user", userServ.findById((Long)session.getAttribute("userId")));
			    	
			    	return "editGazoduc.jsp";
			    }
			    
			    @PutMapping("/gazoducs/{id}/edit")
			    public String updateGazoduc(@PathVariable("id") Long id, Model model, @Valid @ModelAttribute("gazoduc") Gazoduc gazoduc, BindingResult result, HttpSession session) {
			    	if(session.getAttribute("userId") == null) {
			    		return "redirect:/home";
			    	}
			    	
			    	if(result.hasErrors()) {
			    		return "editGazoduc.jsp";
			    	}
			    	
			    	gazoducServ.updateGazoduc(gazoduc);
			    	
			    	return "redirect:/gazoducs/"+id;
			    }
			    
			    @GetMapping("/gazoducs/{gazoduc_id}/prises/{prise_id}/edit")
			    public String editPrise(Model model, @PathVariable("prise_id") Long prise_id, @PathVariable("gazoduc_id") Long gazoduc_id, HttpSession session) {
			    	if(session.getAttribute("userId") == null) {
			    		return "redirect:/home";
			    	}
			    	Prise prise = priseServ.findPrise(prise_id);
			    	Gazoduc gazoduc = gazoducServ.findGazoduc(gazoduc_id); 
			    	
			    	model.addAttribute("prise", prise);
			    	model.addAttribute("gazoduc", gazoduc);
			    	model.addAttribute("user", userServ.findById((Long)session.getAttribute("userId")));
			    	
			    	return "editPrise.jsp";
			    }
			    
			    @PutMapping("/gazoducs/{gazoduc_id}/prises/{prise_id}/update")
			    public String updatePrise(@PathVariable("gazoduc_id") Long gazoducId,
			                              @PathVariable("prise_id") Long priseId,
			                              @Valid @ModelAttribute("prise") Prise prise,
			                              BindingResult result,
			                              Model model,
			                              HttpSession session) {
			        if (session.getAttribute("userId") == null) {
			            return "redirect:/home";
			        }

			        if (result.hasErrors()) {
			            model.addAttribute("gazoduc", gazoducServ.findGazoduc(gazoducId));
			            model.addAttribute("user", userServ.findById((Long) session.getAttribute("userId")));
			            return "editPrise.jsp";
			        }

			        // Remplissage des liens manuellement si nécessaire
			        prise.setGazoduc(gazoducServ.findGazoduc(gazoducId));
			        prise.setUser(userServ.findById((Long) session.getAttribute("userId")));

			        priseServ.updatePrise(prise);
			        return "redirect:/gazoducs/" + gazoducId;
			    }
			 
	 	
}
