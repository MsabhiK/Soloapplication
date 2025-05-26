<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<title>Show Soutirage <c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></title>
    
</head>
<body>
	<nav class="navbar navbar-light p-3" style="background-color: #e3f2fd;">
  		<div class="container-fluid d-flex text-align-center">
    		<a class="navbar-brand" href="https://www.steg.com.tn/fr/index.html" target="_blank" rel="noopener noreferrer">
      			<img src="${pageContext.request.contextPath}/images/Logo_steg.svg" alt="" width="80" height="50">
    		</a>
    		<span class="badge bg-info fs-5 font-monospace fw-bold"><span class="text-dark">Poste de soutirage:</span> <c:out value="${soutirage.emplacement}"/> <c:out value="${soutirage.vsmax}"/>V/<c:out value="${soutirage.ismax}"/>A <c:out value="${soutirage.annee}"/> <span class="text-secondary">Manufacture:</span> <c:out value="${soutirage.marque}"/></span>
    		
    		<div class="justify-content-between mx-2">
    			<span class="text-dark font-monospace"><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></span>
		    	<a href="/home"><button class="btn btn-outline-success" type="submit">Dashboard</button></a>
		    	<a href="/logout"><button class="btn btn-outline-danger" type="submit">Log Out</button></a>
    		</div>
  		</div>
	</nav>
	<c:if test="${user==soutirage.user}">
	<div class="card border-primary text-primary mx-auto my-3 " style="width: 60%">
		
		<div class="card-header border-primary">Lier un Gazoduc à la protection Cathodique de poste de soutirage : <span class="text-danger font-monospace"><c:out value="${soutirage.emplacement}"/></span></div>
		<div class="card-body">
			<form action="/soutirages/${soutirage.id}/addgazoducTOsoutirage" method="post">
				<table class="table table-bordered">
					<tbody>
						<tr>
							<td colspan="1">
								<label for="gazoducId">Tous les Gazoducs:</label>
								<select name="gazoducId" class="input form-select" aria-label="Default select">
						    		<c:forEach var="gazoduc" items="${availableGazoducs}">
						    			<option value="${gazoduc.id}">${gazoduc.antenne}</option>
						    		</c:forEach>
								</select>
							</td>
							<td colspan="1">
								<input value="Add" type="submit" class="btn btn-success font-monospace fw-bold py-3" style="width: 100%"/>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<hr>
			<table class="col-3 mx-auto table table-striped table-bordered text-center">
				<thead>
					<tr class="bg-info">
						<th>Gazoduc Name</th>
						<th>Longueur(m)</th>
						<th>Diametre(")</th>
						<th>Annee</th>
						<th>Action</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="gazoduc" items="${assignedGazoducs}">
						<tr>
							<td><a href="/gazoducs/${gazoduc.id}"><c:out value="${gazoduc.antenne}"/></a></td>
							<td><c:out value="${gazoduc.longueur}"/></td>
							<td><c:out value="${gazoduc.diametre}"/></td>
							<td><c:out value="${gazoduc.annee}"/></td>		
							<td><a href="/soutirages/${soutirage.id}/gazoducs/${gazoduc.id}/drop"><c:out value="Drop"/></a></td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>
	<div class="card border-info text-primary mx-auto my-3 " style="width: 60%">
		
			<div class="card-header border-info">List des enregistrements des mesures : <span class="text-danger font-monospace"><c:out value="${soutirage.emplacement}"/></span>
				<a href="/soutirages/${soutirage.id}/addParametre"><button class="btn btn-dark mx-5" type="submit">Add a new</button></a>
			
			</div>
		<div class="card-body">
			
			<table class="col-3 mx-auto table table-striped table-bordered text-center">
				<thead>
					<tr class="bg-primary">
						<th>Date</th>
						<th>Vsortie (V)</th>
						<th>Isortie(A)</th>
						<th>Potentiel ON (-mV)</th>
						<th>Actions</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="parametre" items="${assignedSoutirage}">
						<tr>
							<td><fmt:formatDate value="${parametre.listedOn}" pattern="yyyy-MM-dd" /></td>
							<td><c:out value="${parametre.vsmesur}"/></td>
							<td><c:out value="${parametre.ismesur}"/></td>
							<td><c:out value="${parametre.potON}"/></td>		
							<td>
								<a href="/soutirages/${soutirage.id}/parametres/${parametre.id}/edit"><input type="hidden" name="_method" value="edit"><button type="button" class="btn btn-warning btn-sm">Edit</button></a>
							</td>	
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>
	</c:if>
	<c:if test="${user!=soutirage.user}">
	<div class="card border-primary text-primary mx-auto my-3 " style="width: 60%">
		
		<div class="card-header border-primary">List des Gazoducs liés à la protection Cathodique de poste de soutirage : <span class="text-danger font-monospace"><c:out value="${soutirage.emplacement}"/></span></div>
		<div class="card-body">
			
			<table class="col-3 mx-auto table table-striped table-bordered text-center">
				<thead>
					<tr class="bg-info">
						<th>Gazoduc Name</th>
						<th>Longueur(m)</th>
						<th>Diametre(")</th>
						<th>Annee</th>
						
					</tr>
				</thead>
				<tbody>
					<c:forEach var="gazoduc" items="${assignedGazoducs}">
						<tr>
							<td><a href="/gazoducs/${gazoduc.id}"><c:out value="${gazoduc.antenne}"/></a></td>
							<td><c:out value="${gazoduc.longueur}"/></td>
							<td><c:out value="${gazoduc.diametre}"/></td>
							<td><c:out value="${gazoduc.annee}"/></td>		
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>
	<div class="card border-info text-primary mx-auto my-3 " style="width: 60%">
		
		<div class="card-header border-info">List des enregistrements des mesures : <span class="text-danger font-monospace"><c:out value="${soutirage.emplacement}"/></span></div>
		<div class="card-body">
			
			<table class="col-3 mx-auto table table-striped table-bordered text-center">
				<thead>
					<tr class="bg-primary">
						<th>Date</th>
						<th>Vsortie (V)</th>
						<th>Isortie(A)</th>
						<th>Potentiel ON (-mV)</th>
						
					</tr>
				</thead>
				<tbody>
					<c:forEach var="parametre" items="${assignedSoutirage}">
						<tr>
							<td><fmt:formatDate value="${parametre.listedOn}" pattern="yyyy-MM-dd" /></td>
							<td><c:out value="${parametre.vsmesur}"/></td>
							<td><c:out value="${parametre.ismesur}"/></td>
							<td><c:out value="${parametre.potON}"/></td>		
							
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		
	</div>
	</c:if>
</body>
</html>