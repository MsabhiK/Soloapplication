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
import jakarta.validation.constraints.PastOrPresent;

@Entity
@Table(name="parametres")
public class Parametre {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@DateTimeFormat(pattern="yyyy-MM-dd")
    @PastOrPresent(message="Date must not be in the future")
    private Date listedOn;
	
	@NotNull(message = "Vs mesuré en volt must be obligatory")
	private Double vsmesur;
	
	@NotNull(message = "Is mesuré en ampere must be obligatory")
	private Double ismesur;
	
	@NotNull(message="Potential ON must not be blank")
    private Integer potON;
	
	// This will not allow the createdAt column to be updated after creation
    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="soutirage_id")
    private Soutirage soutirage;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private User user;

    
    public Parametre() {}
  
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}


	public Date getListedOn() {
		return listedOn;
	}

	public void setListedOn(Date listedOn) {
		this.listedOn = listedOn;
	}

	public Double getVsmesur() {
		return vsmesur;
	}

	public void setVsmesur(Double vsmesur) {
		this.vsmesur = vsmesur;
	}

	public Double getIsmesur() {
		return ismesur;
	}

	public void setIsmesur(Double ismesur) {
		this.ismesur = ismesur;
	}

	public Integer getPotON() {
		return potON;
	}

	public void setPotON(Integer potON) {
		this.potON = potON;
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
	 * @return the soutirage
	 */
	public Soutirage getSoutirage() {
		return soutirage;
	}






	/**
	 * @param soutirage the soutirage to set
	 */
	public void setSoutirage(Soutirage soutirage) {
		this.soutirage = soutirage;
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
