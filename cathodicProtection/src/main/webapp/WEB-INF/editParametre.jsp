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
	<title>Edit Enregistrement <c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></title>
    
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
	<div class="d-flex align-items-center justify-content-center">
        <form:form action="/soutirages/${soutirage.id}/parametres/${parametre.id}/update" method="put" modelAttribute="parametre" class="col-6 bg-light p-4 my-3 text-dark">
        	<form:hidden path="id"/> <!-- 🔧 LIGNE IMPORTANTE -->
        	<input type="hidden" name="_method" value="put">
        	<div class="form-row">
				<form:errors path="user" class="error"/>
				<form:input type="hidden" path="user" value="${user.id}" class="form-control"/>
			</div>
            <h2 class="text-dark text-center">Nouvelle enregistrement au poste de Soutirage</h2>
            <div class="py-3">
            	<div class="row mb-3">
            		<form:label path="listedOn" class="col-sm-3 col-form-label">Date:</form:label>
            		<div class="col-sm-8">
						<form:errors path="listedOn" class="text-danger"/>
			  			<form:input type="date" path="listedOn" class="form-control"/>
		  			</div>
		  		</div>
		  		
		  		<div class="row mb-3">
            		<form:label path="vsmesur" class="col-sm-3 col-form-label">Output Voltage(V):</form:label>
            		<div class="col-sm-8">
						<form:errors path="vsmesur" class="text-danger"/>
			  			<form:input type="number" path="vsmesur" step="0.01" class="form-control"/>
		  			</div>
		  		</div>
            	
            	<div class="row mb-3">
            		<form:label path="ismesur" class="col-sm-3 col-form-label">Output Current(A):</form:label>
            		<div class="col-sm-8">
						<form:errors path="ismesur" class="text-danger"/>
			  			<form:input type="number" path="ismesur" step="0.01" class="form-control"/>
		  			</div>
		  		</div>
	  			
	  			<div class="row mb-3">
					<form:label path="potON" class="col-sm-3 col-form-label">Potential ON(-mV):</form:label>
					<div class="col-sm-8">
						<form:errors path="potON" class="text-danger"/>
			  			<form:input type="number" path="potON" class="form-control"/>
	  				</div>	
	  			</div>
	  			<div class="d-flex justify-content-center row g-3 mx-auto">
		 			<div class="col-md-5 d-flex justify-content-end mt-4">
		 				<a href="/soutirage/${soutirage.id}/parametres/${parametre.id}/delete" class="btn btn-danger me-2 my-2">Delete</a>
		  				<a href="/soutirages/${soutirage.id}" class="btn btn-secondary me-2 my-2">Annuler</a>
		  				<button type="submit" class="btn btn-primary float-end my-2">Valid Add</button>
		  			</div>
		  		</div>
	  		</div>
	  	</form:form>
    </div>

</body>
</html>