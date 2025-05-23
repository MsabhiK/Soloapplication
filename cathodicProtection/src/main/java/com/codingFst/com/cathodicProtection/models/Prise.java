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
@Table(name="prises")
public class Prise {
	@Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
	
	@NotNull
    @Size(min = 5, max = 70, message="Designation must be at least 5 and max 70 characters.")
	private String designation;
	
	private Integer pk;
	
	private Double latitude;
	
    private Double longitude;
    
    @NotNull(message = "P.P type must be obligatory")
    private Character type;
    
    @NotNull(message="Potential ON must not be blank")
    private Integer potON;
    
    @NotNull(message="Alternating Voltage must not be blank")
    private Double altV;
    
    private Integer potGaine;
    
    private Integer potRuban;
    
    private Integer pottierce;
    
    private Integer amJI;
    
    private Integer avJI;
    
    private Integer courant;
    
    private String comment;
    
 // This will not allow the createdAt column to be updated after creation
    @Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date createdAt;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updatedAt;
    
    @ManyToOne
    @JoinColumn(name = "user_id")
    private User user;
    
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="gazoduc_id")
    private Gazoduc gazoduc;
    
    public Prise() {}
    
  
	public Long getId() {
		return id;
	}


	public void setId(Long id) {
		this.id = id;
	}


	public String getDesignation() {
		return designation;
	}


	public void setDesignation(String designation) {
		this.designation = designation;
	}

	public Integer getPk() {
		return pk;
	}

	public void setPk(Integer pk) {
		this.pk = pk;
	}


	public Double getLatitude() {
		return latitude;
	}


	public void setLatitude(Double latitude) {
		this.latitude = latitude;
	}


	public Double getLongitude() {
		return longitude;
	}


	public void setLongitude(Double longitude) {
		this.longitude = longitude;
	}


	public Character getType() {
		return type;
	}

	public void setType(Character type) {
		this.type = type;
	}

	public Integer getPotON() {
		return potON;
	}


	public void setPotON(Integer potON) {
		this.potON = potON;
	}

	public Double getAltV() {
		return altV;
	}


	public void setAltV(Double altV) {
		this.altV = altV;
	}


	public Integer getPotGaine() {
		return potGaine;
	}

	public void setPotGaine(Integer potGaine) {
		this.potGaine = potGaine;
	}

	public Integer getPotRuban() {
		return potRuban;
	}

	public void setPotRuban(Integer potRuban) {
		this.potRuban = potRuban;
	}

	public Integer getPottierce() {
		return pottierce;
	}

	public void setPottierce(Integer pottierce) {
		this.pottierce = pottierce;
	}

	public Integer getAmJI() {
		return amJI;
	}


	public void setAmJI(Integer amJI) {
		this.amJI = amJI;
	}


	public Integer getAvJI() {
		return avJI;
	}

	public void setAvJI(Integer avJI) {
		this.avJI = avJI;
	}

	public Integer getCourant() {
		return courant;
	}

	public void setCourant(Integer courant) {
		this.courant = courant;
	}


	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
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
	
	

	/**
	 * @return the gazoduc
	 */
	public Gazoduc getGazoduc() {
		return gazoduc;
	}


	/**
	 * @param gazoduc the gazoduc to set
	 */
	public void setGazoduc(Gazoduc gazoduc) {
		this.gazoduc = gazoduc;
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
