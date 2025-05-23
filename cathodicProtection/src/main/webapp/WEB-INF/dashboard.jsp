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
	<title>Dashboard <c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></title>
    
</head>
<body>
	<nav class="navbar navbar-light p-3" style="background-color: #e3f2fd;">
  		<div class="container-fluid d-flex align-text-center">
    		<a class="navbar-brand" href="https://www.steg.com.tn/fr/index.html" target="_blank" rel="noopener noreferrer">
      			<img src="${pageContext.request.contextPath}/images/Logo_steg.svg" alt="" width="80" height="50">
    		</a>
    		<span class="card-title text-success font-monospace text-decoration-underline fw-bolder me-6">Bienvenue dans le plate-forme de service Protection Cathodique</span>
    		<a href="/addSoutirage"><button class="btn btn-sm btn-outline-dark" type="button">Ajout Poste Soutirage</button></a>
    		<a href="/addGazoduc"><button class="btn btn-lg btn-outline-primary" type="button">Ajout Gazoduc</button></a>
    		<a href="gazoducs/addPrise"><button class="btn btn-sm btn-outline-secondary" type="button">Ajout Prise des mesures</button></a>
		    <span class="text-dark font-monospace"><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></span>
		    <a href="/logout"><button class="btn btn-outline-danger" type="submit">Log Out</button></a>
  		</div>
	</nav>
	
	<table class="table caption-top">
  			<caption class="h4 font-monospace fw-bold text-warning text-uppercase text-decoration-underline">List des Gazoducs Transport Gaz Tunis Nord:</caption>
  			<thead>
				<tr class="table-secondary text-center">
					<th>Gazoduc Name</th>
					<th>Diameter (")</th>
					<th>Pression(bar)</th>
					<th>Long (m)</th>
					<th>Année</th>
					<th>Ep (mm)</th>
					<th>Added By</th>
					<th>Actions</th>
				</tr>
			</thead>
				<c:forEach var="gazoduc" items="${gazoducs}">
					<tr class="text-center">
						<td><a href="gazoducs/${gazoduc.id}"><c:out value="${gazoduc.antenne}"/></a></td>
						<td><c:out value="${gazoduc.diametre}"/></td>
						<td><c:out value="${gazoduc.pression}"/></td>
						<td><c:out value="${gazoduc.longueur}"/></td>
						<td><c:out value="${gazoduc.annee}"/></td>
						<td><c:out value="${gazoduc.ep}"/></td>	
						<td><c:out value="${gazoduc.user.firstName}"/> <c:out value="${gazoduc.user.lastName}"/></td>
						<td>
							<c:if test="${user==gazoduc.user}">
								<a href="gazoducs/${gazoduc.id}"><button type="button" class="btn btn-primary">Show</button></a> |
								<a href="/gazoducs/${gazoduc.id}/edit"><input type="hidden" name="_method" value="edit"><button type="button" class="btn btn-warning">Edit</button></a> 
							</c:if> 
							<c:if test="${user!=gazoduc.user}">
								<a href="gazoducs/${gazoduc.id}"><button type="button" class="btn btn-primary">Show</button></a> 
							</c:if> 
						</td>
						
					</tr>
				</c:forEach>
		</table>
		
		<table class="table caption-top">
  			<caption class="h4 font-monospace fw-bold text-success text-uppercase text-decoration-underline">List des Postes de Soutirage au Transport Gaz Tunis Nord:</caption>
  			<thead>
				<tr class="table-dark text-center">
					<th>Emplacement</th>
					<th>Vs max (V)</th>
					<th>Is max(A)</th>
					<th>Année m.a.s</th>
					<th>Fabricant</th>
					<th>Added By</th>
					<th>Actions</th>
				</tr>
			</thead>
				<c:forEach var="soutirage" items="${soutirages}">
					<tr class="text-center">
						<td><c:out value="${soutirage.emplacement}"/></td>
						<td><c:out value="${soutirage.vsmax}"/></td>
						<td><c:out value="${soutirage.ismax}"/></td>
						<td><c:out value="${soutirage.annee}"/></td>
						<td><c:out value="${soutirage.marque}"/></td>
					
						<td><c:out value="${soutirage.user.firstName}"/> <c:out value="${soutirage.user.lastName}"/></td>
						<td>
							<c:if test="${user==soutirage.user}">
								<a href="soutirages/${soutirage.id}"><button type="button" class="btn btn-primary">Show</button></a> |
								<a href="/soutirages/edit/${soutirage.id}"><input type="hidden" name="_method" value="edit"><button type="button" class="btn btn-warning">Edit</button></a> 
							</c:if> 
							<c:if test="${user!=soutirage.user}">
								<a href="soutirages/${soutirage.id}"><button type="button" class="btn btn-primary">Show</button></a> 
							</c:if> 
						</td>
						
					</tr>
				</c:forEach>
		</table>
	
	
</body>
</html>