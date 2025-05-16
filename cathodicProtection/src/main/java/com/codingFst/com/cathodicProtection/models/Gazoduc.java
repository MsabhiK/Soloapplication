package com.codingFst.com.cathodicProtection.models;

import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;


import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="gazoducs")
public class Gazoduc {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@NotNull
    @Size(min = 5, max = 60, message="Antenne must be at least 5 and max 60 characters.")
	private String antenne;
	
	@NotNull
    @Size(min = 2, max = 10, message="Diamètre en pouce must be at least 2 and max 10 characters.")
	private String diametre;
	
	@NotNull
    @Size(min = 1, max = 2, message="Pression in bar must be at least 1 and max 2 characters.")
	private int pression;
	
	@NotNull
	@Size(min = 100, message="Longueur in meter must be minimum 100 m")
	private long longueur;
	
	@NotNull
	@Size(min = 1962, message="Annee must be at least 1962")
	private int annee;
	
	@NotNull
	@Size(min = 3, message="Epaisseur must be at least 3 mm")
	private double ep;
	
	// This will not allow the createdAt column to be updated after creation
    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;
    
    public Gazoduc() {}
    
 
	public Long getId() {
		return id;
	}



	public void setId(Long id) {
		this.id = id;
	}


	public String getAntenne() {
		return antenne;
	}

	public void setAntenne(String antenne) {
		this.antenne = antenne;
	}

	public String getDiametre() {
		return diametre;
	}

	public void setDiametre(String diametre) {
		this.diametre = diametre;
	}

	public int getPression() {
		return pression;
	}

	public void setPression(int pression) {
		this.pression = pression;
	}

	public long getLongueur() {
		return longueur;
	}

	public void setLongueur(long longueur) {
		this.longueur = longueur;
	}

	public int getAnnee() {
		return annee;
	}


	public void setAnnee(int annee) {
		this.annee = annee;
	}

	public double getEp() {
		return ep;
	}

	public void setEp(double ep) {
		this.ep = ep;
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

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
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
