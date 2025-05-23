<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<title>add Prise <c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></title>
</head>
<body>
	<nav class="navbar navbar-light p-3" style="background-color: #e3f2fd;">
  		<div class="container-fluid d-flex text-align-center">
    		<a class="navbar-brand" href="https://www.steg.com.tn/fr/index.html" target="_blank" rel="noopener noreferrer">
      			<img src="${pageContext.request.contextPath}/images/Logo_steg.svg" alt="" width="80" height="50">
    		</a>
    		<span class="badge bg-primary fs-5 font-monospace fw-bold">Gazoduc: <c:out value="${gazoduc.antenne}"/> <c:out value="${gazoduc.diametre}"/> <c:out value="${gazoduc.pression}"/>bar <c:out value="${gazoduc.annee}"/> <c:out value="${gazoduc.longueur}"/>m <c:out value="${gazoduc.ep}"/>mm</span>
    		<div class="justify-content-between mx-2">
    			<span class="text-dark font-monospace"><c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></span>
		    	<a href="/home"><button class="btn btn-outline-success" type="submit">Dashboard</button></a>
		    	<a href="/logout"><button class="btn btn-outline-danger" type="submit">Log Out</button></a>
    		</div>
  		</div>
	</nav>
</body>
	<form:form action="/gazoducs/${gazoduc.id}/prises/${prise.id}/update" method="put" modelAttribute="prise" class="bg-light p-4 my-3 text-dark">
			<input type="hidden" name="_method" value="put">
			<form:hidden path="id"/>
        	
           <h2 class="text-dark text-center">Modifier les paramètres d'une prise des mesures</h2>
           <div class="form-group text-danger font-monospace">
			    <div><form:errors path="designation"/></div>
			    <div><form:errors path="type"/></div>
			    <div><form:errors path="potON"/></div>
			    <div><form:errors path="altV"/></div>
			</div>
            
            <div class="d-flex justify-content-center row g-3 mx-auto">
                <div class="col-md-3">
                    <form:label path="designation" class="form-label">Désination du P.P:</form:label>
                    
                    <form:input type="text" class="form-control" path="designation" id="validationDefault01"/>
                </div>
                <div class="col-md-1">
                    <form:label path="pk" class="form-label">P.K: (m)</form:label>
                    <form:input type="number" class="form-control" path="pk" id="validationDefault02"/>
                </div>
                <div class="col-md-1">
                    <form:label path="type" class="form-label">Type:</form:label>
                    <form:select path="type" class="form-select" id="validationDefault04">
                        <form:option value="" disabled="disabled" selected="selected">Choisir...</form:option>
                        <form:option value="A">A</form:option>
                        <form:option value="B">B</form:option>
                        <form:option value="C">C</form:option>
                        <form:option value="D">D</form:option>
                        <form:option value="E">E</form:option>
                        <form:option value="F">F</form:option>
                    </form:select>
                   
                </div>
                <div class="col-md-2">
                    <form:label path="latitude" class="form-label">Latitude(GPS)</form:label>
                    <form:input type="number" step="0.000001" class="form-control" path="latitude" id="validationDefault02"/>
                </div>
                <div class="col-md-2">
                    <form:label path="longitude" class="form-label">longitude(GPS)</form:label>
                    <form:input type="number" step="0.0000001" class="form-control" path="longitude" id="validationDefault02"/>
                </div>
                
            </div>
            <div class="d-flex justify-content-center row g-3 mx-auto">
            	<div class="col-md-2">
                    <form:label path="potON" class="form-label">Potentiel_ON</form:label>
                    <div class="input-group">
                        <span class="input-group-text" id="inputGroupPrepend2">-mV</span>
                        <form:input type="number" class="form-control" path="potON" id="validationDefaultUsername" aria-describedby="inputGroupPrepend2"/>
                    </div>
                </div>
                <div class="col-md-2">
                    <form:label path="amJI" class="form-label">Pot.Am_JI</form:label>
                    <div class="input-group">
                        <span class="input-group-text" id="inputGroupPrepend2">-mV</span>
                        <form:input type="number" class="form-control" path="amJI" id="validationDefaultUsername" aria-describedby="inputGroupPrepend2"/>
                    </div>
                </div>
                <div class="col-md-2">
                    <form:label path="avJI" class="form-label">Pot.Av_JI</form:label>
                    <div class="input-group">
                        <span class="input-group-text">-mV</span>
                        <form:input type="number" class="form-control" path="avJI" aria-describedby="inputGroupPrepend2"/>
                    </div>
                </div>
                <div class="col-md-2">
                    <form:label path="courant" class="form-label">Courant:</form:label>
                    <div class="input-group">
                        <span class="input-group-text" id="inputGroupPrepend2">mA</span>
                        <form:input type="number" class="form-control" path="courant" id="validationDefaultUsername" aria-describedby="inputGroupPrepend2"/>
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-center row g-3 mx-auto">
                <div class="col-md-2">
                    <form:label path="potGaine" class="form-label">Pot_Gaine:</form:label>
                    <div class="input-group">
                        <span class="input-group-text" id="inputGroupPrepend2">-mV</span>
                        <form:input type="number" class="form-control" path="potGaine" id="validationDefaultUsername" aria-describedby="inputGroupPrepend2"/>
                    </div>
                </div>
                <div class="col-md-2">
                    <form:label path="potRuban" class="form-label">Pot_Ruban Mg:</form:label>
                    <div class="input-group">
                        <span class="input-group-text" id="inputGroupPrepend2">-mV</span>
                        <form:input type="number" class="form-control" path="potRuban" id="validationDefaultUsername" aria-describedby="inputGroupPrepend2"/>
                    </div>
                </div>
                <div class="col-md-2">
                    <form:label path="pottierce" class="form-label">Pot_Tierce:</form:label>
                    <div class="input-group">
                        <span class="input-group-text" id="inputGroupPrepend2">-mV</span>
                        <form:input type="number" class="form-control" path="pottierce" id="validationDefaultUsername" aria-describedby="inputGroupPrepend2"/>
                    </div>
                </div>
                <div class="col-md-1">
                    <form:label path="altV" class="form-label">Tension_alt:</form:label>
                    <div class="input-group">
                        <span class="input-group-text" id="inputGroupPrepend2">V~</span>
                        <form:input type="text" class="form-control" path="altV" id="validationDefaultUsername" aria-describedby="inputGroupPrepend2"/>
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-center row g-3 mx-auto">
                <div class="col-md-3">
                    <form:label path="comment" class="form-label">Comments:</form:label>
                    <form:textarea class="form-control" path="comment" id="validationTextarea" placeholder="add your comments"></form:textarea>
                </div>
            </div>
            <div class="d-flex justify-content-center row g-3 mx-auto">
                <div class="col-md-3">
                    <button type="submit" class="btn btn-primary my-2 float-end">Valider</button>
                </div>
            </div>
        </form:form>
 
    </body>
	
</html>