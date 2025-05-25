<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<title>Update Poste de soutirage <c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></title>
    
</head>
<body>
	<nav class="navbar navbar-light p-3" style="background-color: #e3f2fd;">
  		<div class="container-fluid d-flex align-text-center">
    		<a class="navbar-brand" href="https://www.steg.com.tn/fr/index.html" target="_blank" rel="noopener noreferrer">
      			<img src="${pageContext.request.contextPath}/images/Logo_steg.svg" alt="" width="80" height="50">
    		</a>
    		<div class="justify-content-between mx-2">
    			<span class="text-dark font-monospace"><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></span>
		    	<a href="/home"><button class="btn btn-outline-success" type="submit">Dashboard</button></a>
		    	<a href="/logout"><button class="btn btn-outline-danger" type="submit">Log Out</button></a>
    		</div>
		    
  		</div>
	</nav>
	<div class="d-flex align-items-center justify-content-center">
        <form:form action="/soutirages/${soutirage.id}/edit" method="put" modelAttribute="soutirage" class="col-4 bg-light p-4 my-3 text-dark">
        	<input type="hidden" name="_method" value="put">
    		<form:hidden path="id"/> <!-- 🔧 LIGNE IMPORTANTE -->
    		<div class="form-row">
        		<form:errors path="user" class="error"/>
				<form:input type="hidden" path="user" value="${user.id}" class="form-control"/>
			</div>
			<h2 class="text-dark text-center">Update Soutirage Station</h2>
            <div class="py-3">
            	<div class="row mb-3">
            		<form:label path="emplacement" class="col-sm-3 col-form-label">Location:</form:label>
            		<div class="col-sm-8">
						<form:errors path="emplacement" class="text-danger"/>
			  			<form:input type="text" path="emplacement" class="form-control"/>
		  			</div>
		  		</div>
		  		
		  		<div class="row mb-3">
            		<form:label path="vsmax" class="col-sm-3 col-form-label">OutPut VoltageMax(V):</form:label>
            		<div class="col-sm-8">
						<form:errors path="vsmax" class="text-danger"/>
			  			<form:input type="number" path="vsmax" class="form-control"/>
		  			</div>
		  		</div>
            	
            	<div class="row mb-3">
            		<form:label path="ismax" class="col-sm-3 col-form-label">OutPut Current(A):</form:label>
            		<div class="col-sm-8">
						<form:errors path="ismax" class="text-danger"/>
			  			<form:input type="number" path="ismax" class="form-control"/>
		  			</div>
		  		</div>
	  			
	  			<div class="row mb-3">
					<form:label path="annee" class="col-sm-3 col-form-label">Année (m.a.s):</form:label>
					<div class="col-sm-8">
						<form:errors path="annee" class="text-danger"/>
			  			<form:input type="number" path="annee" class="form-control"/>
	  				</div>	
	  			</div>
	  			
	  			<div class="row mb-3">
					<form:label path="marque" class="col-sm-3 col-form-label">Marque:</form:label>
					<div class="col-sm-8">
						<form:errors path="marque" class="text-danger"/>
			  			<form:input type="text" step="0.01" min="3"  path="marque" class="form-control"/>
	  				</div>	
	  			</div>
	  			<div class="d-flex justify-content-end mt-4">
	  				<a href="/soutirages/${soutirage.id}" class="btn btn-secondary me-2">Annuler</a>
	  				<button type="submit" class="btn btn-warning float-end mx-5">Valid Update</button>
	  			</div>
	  		</div>
	  	</form:form>
    </div>
			

</body>
</html>