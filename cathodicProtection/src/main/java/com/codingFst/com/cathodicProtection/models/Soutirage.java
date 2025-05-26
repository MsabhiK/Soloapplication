package com.codingFst.com.cathodicProtection.models;

import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinTable;
import jakarta.persistence.ManyToMany;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.OneToMany;
import jakarta.persistence.PrePersist;
import jakarta.persistence.PreUpdate;
import jakarta.persistence.Table;
import jakarta.validation.constraints.Min;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Size;

@Entity
@Table(name="soutirages")
public class Soutirage {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@NotNull
    @Size(min = 5, max = 60, message="Emplacement must be at least 5 and max 60 characters.")
	private String emplacement;
	
	@NotNull(message = "Vs max en volt must be obligatory")
	private Integer vsmax;
	
	@NotNull(message = "Is max en amper must be obligatory")
	private Integer ismax;
	
	@NotNull
	@Min(value=1980, message="Year of Start Working must be greater than 1980")
	private Integer annee;
	
	@NotNull
    @Size(min = 3, max = 30, message="La marque must be at least 3 and max 30 characters.")
	private String marque;
	
	// This will not allow the createdAt column to be updated after creation
    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    @ManyToMany(cascade=CascadeType.ALL, fetch = FetchType.LAZY)
    @JoinTable(
    		name = "soutirages_gazoducs", 
    		joinColumns = @JoinColumn(name = "soutirage_id"),
    		inverseJoinColumns = @JoinColumn(name = "gazoduc_id")
    		)
    private List<Gazoduc> gazoducs;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="user_id")
    private User user;
    
    @OneToMany(mappedBy="soutirage", fetch = FetchType.LAZY)
    private List<Parametre> parametres;
	
	public Soutirage() {}

	/**
	 * @return the id
	 */
	public Long getId() {
		return id;
	}

	/**
	 * @param id the id to set
	 */
	public void setId(Long id) {
		this.id = id;
	}

	/**
	 * @return the emplacement
	 */
	public String getEmplacement() {
		return emplacement;
	}

	/**
	 * @param emplacement the emplacement to set
	 */
	public void setEmplacement(String emplacement) {
		this.emplacement = emplacement;
	}

	/**
	 * @return the vsmax
	 */
	public Integer getVsmax() {
		return vsmax;
	}

	/**
	 * @param vsmax the vsmax to set
	 */
	public void setVsmax(Integer vsmax) {
		this.vsmax = vsmax;
	}

	/**
	 * @return the ismax
	 */
	public Integer getIsmax() {
		return ismax;
	}

	/**
	 * @param ismax the ismax to set
	 */
	public void setIsmax(Integer ismax) {
		this.ismax = ismax;
	}

	/**
	 * @return the annee
	 */
	public Integer getAnnee() {
		return annee;
	}

	/**
	 * @param annee the annee to set
	 */
	public void setAnnee(Integer annee) {
		this.annee = annee;
	}

	/**
	 * @return the marque
	 */
	public String getMarque() {
		return marque;
	}

	/**
	 * @param marque the marque to set
	 */
	public void setMarque(String marque) {
		this.marque = marque;
	}
	
	
	/**
	 * @return the createdAt
	 */
	public Date getCreatedAt() {
		return createdAt;
	}

	/**
	 * @param createdAt the createdAt to set
	 */
	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	/**
	 * @return the updatedAt
	 */
	public Date getUpdatedAt() {
		return updatedAt;
	}

	/**
	 * @param updatedAt the updatedAt to set
	 */
	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	/**
	 * @return the gazoducs
	 */
	public List<Gazoduc> getGazoducs() {
		return gazoducs;
	}

	/**
	 * @param gazoducs the gazoducs to set
	 */
	public void setGazoducs(List<Gazoduc> gazoducs) {
		this.gazoducs = gazoducs;
	}
	
	

	/**
	 * @return the user
	 */
	public User getUser() {
		return user;
	}

	/**
	 * @param user the user to set
	 */
	public void setUser(User user) {
		this.user = user;
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
