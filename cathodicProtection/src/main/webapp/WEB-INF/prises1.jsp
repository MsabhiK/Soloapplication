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
	<!-- Feuille de style Leaflet -->
   	<link rel="stylesheet" href="https://unpkg.com/leaflet/dist/leaflet.css" />
   	
   	<style>
        #map {
            width: 500px;
            height: 420px;
            border: 3px solid #333;
            margin: 10px;
        }
    </style>
    
</head>
<body>
	<nav class="navbar navbar-light p-3" style="background-color: #e3f2fd;">
  		<div class="container-fluid d-flex text-align-center">
    		<a class="navbar-brand" href="https://www.steg.com.tn/fr/index.html" target="_blank" rel="noopener noreferrer">
      			<img src="${pageContext.request.contextPath}/images/Logo_steg.svg" alt="" width="80" height="50">
    		</a>
    		<span class="badge bg-primary fs-5 font-monospace fw-bold">Gazoduc: <c:out value="${gazoduc.antenne}"/> <c:out value="${gazoduc.diametre}"/> <c:out value="${gazoduc.pression}"/>bar <c:out value="${gazoduc.annee}"/> <c:out value="${gazoduc.longueur}"/>m <c:out value="${gazoduc.ep}"/>mm</span>
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
  			<div class="d-flex justify-content-around font-monospace fw-bold">
  				<div class=" text-warning">List des Prises des mesures:</div>
  				<div class="text-dark bg-danger">Not Protected</div>
  				<div class=" text-dark bg-success">Over Protection</div>
  				<div class=" text-dark bg-light">Protected</div>
  			</div>
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
						<td>
			                <a href="${pageContext.request.contextPath}/gazoducs/${gazoduc.id}?latitude=${prise.latitude}&longitude=${prise.longitude}" class="btn btn-sm btn-outline-info">
			                    Voir carte
			                </a><br/>
			                <small><c:out value="${prise.latitude}" /> / <c:out value="${prise.longitude}" /></small>
			            </td>
						<td><c:out value="${prise.type}"/></td>
						<td>
						<c:choose>
							<c:when test="${prise.potON >1350}">
								<div class="bg-success"><c:out value="${prise.potON}"/></div>
							</c:when>
							<c:when test="${prise.potON <950}">
								<div class="bg-danger"><c:out value="${prise.potON}"/></div>
							</c:when>
							<c:otherwise>
						        <div class="bg-light"><c:out value="${prise.potON}"/></div>
						    </c:otherwise>
						</c:choose>
						</td>
						<td><c:out value="${prise.altV}"/></td>
						<td><c:out value="${prise.potGaine}"/> / <c:out value="${prise.potRuban}"/> </td>
						<td><c:out value="${prise.pottierce}"/></td>
						<td><c:out value="${prise.amJI}"/></td>	
						<td><c:out value="${prise.avJI}"/></td>
						<td><c:out value="${prise.courant}"/></td>	
						<td><c:out value="${prise.comment}"/></td>
						<td>
							<c:if test="${user==gazoduc.user}">
								<a href="/gazoducs/${gazoduc.id}/prises/${prise.id}/edit"><input type="hidden" name="_method" value="edit"><button type="button" class="btn btn-warning">Edit</button></a> 
								
							</c:if> 
							<c:if test="${user!=gazoduc.user}">
								<button type="button" class="btn btn-primary">Disabled</button>
							</c:if> 
						</td>
						
					</tr>
				</c:forEach>
		</table>
		<div class="container d-flex justify-content-around">
			<div class="col-5 justify-content-between">
				<!-- ✅ AFFICHAGE DE LA CARTE SI LAT/LON SONT FOURNIS -->
			<c:if test="${not empty latitude and not empty longitude}">
				<h3 class="mx-4">La carte est positionnée sur:</h3>
				<span class="badge bg-danger fs-6 font-monospace fw-bold mx-4"><c:out value="${latitude}" />, <c:out value="${longitude}" /></span> 
				<div id="map"></div>
				    
	 		</c:if>
	 		</div>
	 	
	 		<div class="col-6">
		    	<button class="btn btn-dark text-white font-monospace fw-bolder" onclick="afficherInterpretation()" type="submit">Interprétaion des paramètres</button>
		    	<iframe id="interpretationFrame" class="w-100 my-3" style="display:none; height: auto; min-height: 200px; border: 2px solid #333;"></iframe>
    		</div>
    	
	 </div>
	 
	<script>
		function afficherInterpretation() {
		    let interpretations = [];
		    document.querySelectorAll("table tbody tr").forEach(function(row) {
		        let emplacement = row.children[0].textContent.trim(); // désignation
		        let potON = parseFloat(row.children[4].textContent.trim()); // potON est la 5ème colonne
		        let interpretation = "";
		
		        if (potON < 950) {
		            interpretation = emplacement + " : ❌ Non protégée (potON = " + potON + ")";
		        } else if (potON > 1350) {
		            interpretation = emplacement + " : ⚠️ Surprotection (potON = " + potON + ")";
		        } else {
		            interpretation = emplacement + " : ✅ Protégée (potON = " + potON + ")";
		        }
		
		        interpretations.push(interpretation);
		    });
		
		    // Injecte dans l'iframe
		    let iframe = document.getElementById("interpretationFrame");
		    let doc = iframe.contentDocument || iframe.contentWindow.document;
		    doc.open();
		    doc.write("<html><head><style>body{font-family:monospace;padding:10px;font-size: 18px;} .ok{color:green;} .warn{color:orange;} .bad{color:red;}</style></head><body>");
		    interpretations.forEach(text => {
		        let colorClass = text.includes("❌") ? "bad" : (text.includes("⚠️") ? "warn" : "ok");
		        doc.write("<p class='" + colorClass + "'>" + text + "</p>");
		    });
		    doc.write("</body></html>");
		    doc.close();
		    iframe.style.display = "block";
		 // 🔁 Ajuster la hauteur de l'iframe dynamiquement
		    setTimeout(() => {
		        iframe.style.height = iframe.contentWindow.document.body.scrollHeight + "px";
		    }, 100);
	  	}
	
		document.addEventListener("DOMContentLoaded", function () {
				  var lat = parseFloat("<c:out value='${latitude}'/>");
				  var lon = parseFloat("<c:out value='${longitude}'/>");
				
				  var map = L.map('map').setView([lat, lon], 13);
				
				  L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
				      maxZoom: 18,
				      attribution: '© OpenStreetMap contributors'
				      }).addTo(map);
				
				     L.marker([lat, lon]).addTo(map)
				     .bindPopup("Coordonnées :<br>" + lat + ", " + lon)
				     .openPopup();
				});
	</script>
	<!--Leaflet JS -->
	<script src="https://unpkg.com/leaflet/dist/leaflet.js"></script>
			
</body>
</html>