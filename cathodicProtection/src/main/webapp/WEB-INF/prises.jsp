<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<title>Prises potentiel <c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></title>
	<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
	<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
    
    <style>
        #map {
            width: 800px;
            height: 600px;
            border: 3px solid #333;
            margin-top: 20px;
        }
    </style>
</head>
<body>
	<nav class="navbar navbar-light p-3" style="background-color: #e3f2fd;">
  		<div class="container-fluid d-flex align-text-center">
    		<a class="navbar-brand" href="https://www.steg.com.tn/fr/index.html" target="_blank" rel="noopener noreferrer">
      			<img src="${pageContext.request.contextPath}/images/Logo_steg.svg" alt="" width="80" height="50">
    		</a>
    		<span class="card-title text-success font-monospace text-decoration-underline fw-bolder me-6">Bienvenue dans le plate-forme de service Protection Cathodique</span>
    		<button class="btn btn-outline-primary" type="button">Ajout Gazoduc</button>
    		<button class="btn btn-sm btn-outline-secondary" type="button">Ajout Prise des mesures</button>
		    <span class="text-dark font-monospace"><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></span>
		    <a href="/logout"><button class="btn btn-outline-success" type="submit">Log Out</button></a>
      		
  		</div>
	</nav>
	<h2>Saisir les coordonnées GPS</h2>
    <form action="showMap" method="post">
        Latitude: <input type="text" name="latitude" required><br><br>
        Longitude: <input type="text" name="longitude" required><br><br>
        <input type="submit" value="Afficher la carte">
    </form>
    <br>
    <c:if test="${latitude != null && longitude != null}">
		<h2>Carte centrée sur <c:out value="${latitude}"/>, <c:out value="${longitude}"/></h2>
	    <div id="map"></div>
	
	    <script>
		    var lat = parseFloat("${latitude}");
		    var lon = parseFloat("${longitude}");
	        var map = L.map('map').setView([${latitude}, ${longitude}], 13);
	
	        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
	            maxZoom: 18,
	            attribution: '© OpenStreetMap contributors'
	        }).addTo(map);
	
	        L.marker([${latitude}, ${longitude}]).addTo(map)
	            .bindPopup("Coordonnées:<br>${latitude}, ${longitude}")
	            .openPopup();
	    </script>
	 </c:if>
	
	
</body>
</html>