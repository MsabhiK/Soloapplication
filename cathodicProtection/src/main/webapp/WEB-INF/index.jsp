<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix = "c" uri = "http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
	<title>Login</title>
</head>
<body>
	<div class="card-body p-4">
    	<h1 class="card-title text-uppercase text-primary font-monospace text-decoration-underline">Cathodic Protection Department</h1>
  	</div>    
    <div class="d-flex align-items-center justify-content-center">
        <form:form action="/login" method="post" modelAttribute="newLogin" class="col-4 bg-light p-4 my-3 text-dark">
            <h2 class="text-dark">Log In</h2>
            <div class="py-3">
            	<div class="row mb-3">
            		<form:label path="email" class="col-sm-2 col-form-label">Email:</form:label>
            		<div class="col-sm-10">
						<form:errors path="email" class="text-danger"/>
			  			<form:input type="text" path="email" class="form-control"/>
		  			</div>
		  		</div>
	  			
            	<div class="row mb-3">
					<form:label path="password" class="col-sm-2 col-form-label">Password:</form:label>
					<div class="col-sm-10">
						<form:errors path="password" class="text-danger"/>
			  			<form:input type="password" path="password" class="form-control"/>
	  				</div>	
	  			</div>
	  			<button type="submit" class="btn btn-success float-end">Log In</button>
	  		</div>
	  		<div class="py-3 my-4 mb-3">
	  			<a href="/newuser" class="text-primary font-monospace float-end">I don't have an account</a>
	  		</div>
        </form:form>
    </div>

</body>
</html>