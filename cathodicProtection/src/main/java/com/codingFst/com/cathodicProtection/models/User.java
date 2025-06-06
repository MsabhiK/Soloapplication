package com.codingFst.com.cathodicProtection.models;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import jakarta.validation.constraints.Email;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="users")
public class User {
    
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    
    @NotEmpty(message="First name is required!")
    @Size(min=3, max=20, message="First name must be between 3 and 20 characters")
    private String firstName;
    
    @NotEmpty(message="Last name is required!")
    @Size(min=3, max=20, message="Last name must be between 3 and 20 characters")
    private String lastName;
    
    @NotEmpty(message="Email is required!")
    @Email(message="Please enter a valid email!")
    private String email;
    
    @NotEmpty(message="Password is required!")
    @Size(min=8, max=128, message="Password must be between 8 and 128 characters")
    private String password;
    
    @Transient
    @NotEmpty(message="Confirm Password is required!")
    @Size(min=8, max=128, message="Confirm Password must be between 8 and 128 characters")
    private String confirm;
    
 // This will not allow the createdAt column to be updated after creation
    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    @OneToMany(mappedBy="user", fetch = FetchType.LAZY)
    private List<Gazoduc> gazoducs;
    
    @OneToMany(mappedBy="user", fetch = FetchType.LAZY)
    private List<Soutirage> soutirages;
    
    @OneToMany(mappedBy="user", fetch = FetchType.LAZY)
    private List<Prise> prises;
    
    @OneToMany(mappedBy="user", fetch = FetchType.LAZY)
    private List<Parametre> parametres;
    
  //Constructors
    public User() {}
    
    public User(Long id, String firstName, String lastName, String email, String password, String confirm, Date createdAt) {
    	this.id=id;
    	this.firstName=firstName;
    	this.lastName=lastName;
    	this.email=email;
    	this.password=password;
    	this.confirm=confirm;
    	this.createdAt=createdAt;
    }

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	
	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getConfirm() {
		return confirm;
	}

	public void setConfirm(String confirm) {
		this.confirm = confirm;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}
	
	
	public List<Gazoduc> getGazoducs() {
		return gazoducs;
	}

	public void setGazoducs(List<Gazoduc> gazoducs) {
		this.gazoducs = gazoducs;
	}
	
	

	/**
	 * @return the soutirages
	 */
	public List<Soutirage> getSoutirages() {
		return soutirages;
	}

	/**
	 * @param soutirages the soutirages to set
	 */
	public void setSoutirages(List<Soutirage> soutirages) {
		this.soutirages = soutirages;
	}

		
	/**
	 * @return the prises
	 */
	public List<Prise> getPrises() {
		return prises;
	}

	/**
	 * @param prises the prises to set
	 */
	public void setPrises(List<Prise> prises) {
		this.prises = prises;
	}
	
	

	/**
	 * @return the parametres
	 */
	public List<Parametre> getParametres() {
		return parametres;
	}

	/**
	 * @param parametres the parametres to set
	 */
	public void setParametres(List<Parametre> parametres) {
		this.parametres = parametres;
	}

	// other getters and setters removed for brevity
    @PrePersist
    protected void onCreate(){
        this.createdAt = new Date();
    }
    @PreUpdate
    protected void onUpdate(){
        this.updatedAt = new Date();
    }

}
