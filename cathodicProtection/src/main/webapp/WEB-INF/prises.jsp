<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>
<!--<%@ page isELIgnored="false" %>-->
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
  		<div class="container-fluid d-flex text-align-center">
    		<a class="navbar-brand" href="https://www.steg.com.tn/fr/index.html" target="_blank" rel="noopener noreferrer">
      			<img src="${pageContext.request.contextPath}/images/Logo_steg.svg" alt="" width="80" height="50">
    		</a>
    		<span class="badge bg-primary fs-4 font-monospace fw-bold">Gazoduc: <c:out value="${gazoduc.antenne}"/> <c:out value="${gazoduc.diametre}"/> <c:out value="${gazoduc.pression}"/>bar <c:out value="${gazoduc.annee}"/></span>
    		<a href="/addGazoduc"><button class="btn btn-outline-primary" type="button">Ajout Gazoduc</button></a>
    		<a href="/gazoducs/addPrise"><button class="btn btn-sm btn-outline-secondary" type="button">Ajout Prise des mesures</button></a>
    		<div class="justify-content-between mx-2">
    			<span class="text-dark font-monospace"><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></span>
		    	<a href="/home"><button class="btn btn-outline-success" type="submit">Dashboard</button></a>
		    	<a href="/logout"><button class="btn btn-outline-danger" type="submit">Log Out</button></a>
    		</div>
  		</div>
	</nav>
	<table class="table caption-top">
  			<caption class="font-monospace fw-bold text-warning">List des Prises des mesures:</caption>
  			<thead>
				<tr class="table-secondary text-center align-content-center">
					<th class="col-2">Désignation</th>
					<th class="col-1">PK (m)</th>
					<th class="col-1">Latitude / Longitude</th>

					<th>Type</th>
					<th class="col-1">potON (-mV)</th>
					<th>Alt(V)</th>
					<th class="col-1">Gaine/Ruban (-mV)</th>
					<th>Tierce (-mV)</th>
					<th class="col-1">Am.JI (-mV)</th>
					<th class="col-1">Av.JI (-mV)</th>
					<th class="col-1">I (mA)</th>
					<th class="col-2">Comment</th>
					<th class="col-1">Actions</th>
				</tr>
			</thead>
			<c:forEach var="prise" items="${assignedGazoduc}">
					<tr class="text-center">
						<td><c:out value="${prise.designation}"/></td>
						<td><c:out value="${prise.pk}"/></td>
						<td><c:out value="${prise.latitude}"/> / <c:out value="${prise.longitude}"/> </td>
						<td><c:out value="${prise.type}"/></td>
						<td><c:out value="${prise.potON}"/></td>
						<td><c:out value="${prise.altV}"/></td>
						<td><c:out value="${prise.potGaine}"/> / <c:out value="${prise.potRuban}"/> </td>
						<td><c:out value="${prise.pottierce}"/></td>
						<td><c:out value="${prise.amJI}"/></td>	
						<td><c:out value="${prise.avJI}"/></td>
						<td><c:out value="${prise.courant}"/></td>	
						<td><c:out value="${prise.comment}"/></td>
						<td>
							<c:if test="${user==gazoduc.user}">
								<a href="/gazoducs/edit/${gazoduc.id}"><input type="hidden" name="_method" value="edit"><button type="button" class="btn btn-warning">Edit</button></a> 
							</c:if> 
							<c:if test="${user!=gazoduc.user}">
								<button type="button" class="btn btn-primary">Disabled</button>
							</c:if> 
						</td>
						
					</tr>
				</c:forEach>
		</table>
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