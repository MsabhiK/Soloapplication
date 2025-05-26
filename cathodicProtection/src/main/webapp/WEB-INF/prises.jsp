<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page isErrorPage="true" %>

<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Système de monitoring des prises de mesures pour gazoducs STEG">
    
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
    <!-- Leaflet CSS -->
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" 
          integrity="sha256-p4NxAoJBhIIN+hmNHrzRCf9tD/miZyoHS5obTRR9BMY=" 
          crossorigin=""/>
    
    <title>Prises de mesures - <c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/></title>
    
    <style>
        :root {
            --steg-blue: #007bff;
            --steg-light-blue: #e3f2fd;
            --danger-color: #dc3545;
            --success-color: #28a745;
            --warning-color: #ffc107;
        }
        
        #map {
            width: 100%;
            height: 420px;
            border: 2px solid #dee2e6;
            border-radius: 0.375rem;
            margin: 10px 0;
        }
        
        .status-badge {
            padding: 0.25rem 0.5rem;
            border-radius: 0.25rem;
            font-weight: 500;
        }
        
        .status-not-protected {
            background-color: var(--danger-color);
            color: white;
        }
        
        .status-over-protected {
            background-color: var(--success-color);
            color: white;
        }
        
        .status-protecting {
            background-color: #f8f9fa;
            color: #495057;
            border: 1px solid #dee2e6;
        }
        
        .navbar-custom {
            background-color: var(--steg-light-blue);
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        
        .table-custom {
            font-size: 0.9rem;
        }
        
        .table-custom th {
            background-color: #f8f9fa;
            border-top: 2px solid var(--steg-blue);
            font-weight: 600;
        }
        
        .btn-sm-custom {
            font-size: 0.8rem;
            padding: 0.25rem 0.5rem;
        }
        
        .coordinates-cell {
            max-width: 120px;
            word-wrap: break-word;
        }
        
        .interpretation-frame {
            border: 2px solid #dee2e6;
            border-radius: 0.375rem;
            background-color: #f8f9fa;
        }
        
        .legend-container {
            background-color: #f8f9fa;
            border-radius: 0.375rem;
            padding: 1rem;
            margin-bottom: 1rem;
        }
        
        @media (max-width: 768px) {
            .table-responsive {
                font-size: 0.8rem;
            }
            
            .navbar-custom .container-fluid {
                flex-direction: column;
                gap: 0.5rem;
            }
            
            #map {
                height: 300px;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-light navbar-custom p-3">
        <div class="container-fluid">
            <div class="d-flex align-items-center flex-wrap w-100">
                <!-- Logo STEG -->
                <a class="navbar-brand me-3" href="https://www.steg.com.tn/fr/index.html" 
                   target="_blank" rel="noopener noreferrer" aria-label="Site officiel STEG">
                    <img src="${pageContext.request.contextPath}/images/Logo_steg.svg" 
                         alt="Logo STEG" width="80" height="50" class="img-fluid">
                </a>
                
                <!-- Informations gazoduc -->
                <div class="badge bg-primary fs-6 font-monospace fw-bold me-3 flex-grow-1">
                    Gazoduc: <c:out value="${gazoduc.antenne}"/> 
                    <c:out value="${gazoduc.diametre}"/> 
                    <c:out value="${gazoduc.pression}"/>bar 
                    <c:out value="${gazoduc.annee}"/> 
                    <c:out value="${gazoduc.longueur}"/>m 
                    <c:out value="${gazoduc.ep}"/>mm
                </div>
                
                <!-- Boutons d'action -->
                <div class="d-flex flex-wrap gap-2 align-items-center">
                    <a href="/addGazoduc" class="btn btn-outline-primary btn-sm">
                        Ajouter Gazoduc
                    </a>
                    <a href="/gazoducs/addPrise" class="btn btn-outline-secondary btn-sm">
                        Ajouter Prise
                    </a>
                    
                    <!-- Informations utilisateur -->
                    <div class="d-flex align-items-center gap-2 ms-3">
                        <span class="text-dark font-monospace">
                            <c:out value="${user.firstName}"/> <c:out value="${user.lastName}"/>
                        </span>
                        <a href="/home" class="btn btn-outline-success btn-sm">Dashboard</a>
                        <a href="/logout" class="btn btn-outline-danger btn-sm">Log Out</a>
                    </div>
                </div>
            </div>
        </div>
    </nav>

    <div class="container-fluid mt-4">
        <!-- Légende des statuts -->
        <div class="legend-container">
            <h5 class="mb-3">Liste des Prises de mesures</h5>
            <div class="d-flex flex-wrap gap-3 font-monospace fw-bold">
                <div class="d-flex align-items-center">
                    <span class="status-badge status-not-protected me-2">Non Protégée</span>
                    <small class="text-muted">(&lt; 950 mV)</small>
                </div>
                <div class="d-flex align-items-center">
                    <span class="status-badge status-over-protected me-2">Surprotection</span>
                    <small class="text-muted">(&gt; 1350 mV)</small>
                </div>
                <div class="d-flex align-items-center">
                    <span class="status-badge status-protecting me-2">Protecting</span>
                    <small class="text-muted">(950-1350 mV)</small>
                </div>
            </div>
        </div>

        <!-- Tableau des données -->
        <div class="table-responsive">
            <table class="table table-hover table-custom table-sm" id="measurementsTable">
                <thead>
                    <tr class="text-center">
                        <th scope="col">Désignation</th>
                        <th scope="col">PK (m)</th>
                        <th scope="col">Coordonnées</th>
                        <th scope="col">Type</th>
                        <th scope="col">Pot ON (-mV)</th>
                        <th scope="col">Alt (V)</th>
                        <th scope="col">Gaine/Ruban (-mV)</th>
                        <th scope="col">Tierce (-mV)</th>
                        <th scope="col">Am.JI (-mV)</th>
                        <th scope="col">Av.JI (-mV)</th>
                        <th scope="col">I (mA)</th>
                        <th scope="col">Commentaires</th>
                        <th scope="col">Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty assignedGazoduc}">
                            <c:forEach var="prise" items="${assignedGazoduc}" varStatus="status">
                                <tr class="text-center">
                                    <td class="fw-bold">
                                        <c:out value="${prise.designation}" default="-"/>
                                    </td>
                                    <td>
                                        <fmt:formatNumber value="${prise.pk}" pattern="#,##0.0" var="formattedPk"/>
                                        <c:out value="${formattedPk}" default="-"/>
                                    </td>
                                    <td class="coordinates-cell">
                                        <c:if test="${not empty prise.latitude and not empty prise.longitude}">
                                            <a href="${pageContext.request.contextPath}/gazoducs/${gazoduc.id}?latitude=${prise.latitude}&longitude=${prise.longitude}" 
                                               class="btn btn-outline-info btn-sm-custom mb-1" 
                                               title="Voir sur la carte">
                                                📍 Carte
                                            </a>
                                            <!--  
                                            <br>
                                            <small class="text-muted">
                                                <fmt:formatNumber value="${prise.latitude}" pattern="#.######"/>°N<br>
                                                <fmt:formatNumber value="${prise.longitude}" pattern="#.######"/>°E
                                            </small>
                                            -->
                                        </c:if>
                                        <c:if test="${empty prise.latitude or empty prise.longitude}">
                                            <span class="text-muted">Non disponible</span>
                                        </c:if>
                                    </td>
                                    <td><c:out value="${prise.type}" default="-"/></td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${prise.potON > 1350}">
                                                <div class="status-badge status-over-protected" data-poton="${prise.potON}">
                                                    <c:out value="${prise.potON}"/>
                                                </div>
                                            </c:when>
                                            <c:when test="${prise.potON < 950}">
                                                <div class="status-badge status-not-protected" data-poton="${prise.potON}">
                                                    <c:out value="${prise.potON}"/>
                                                </div>
                                            </c:when>
                                            <c:otherwise>
                                                <div class="status-badge status-protecting" data-poton="${prise.potON}">
                                                    <c:out value="${prise.potON}"/>
                                                </div>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><c:out value="${prise.altV}" default="-"/></td>
                                    <td>
                                        <c:out value="${prise.potGaine}" default="-"/> / 
                                        <c:out value="${prise.potRuban}" default="-"/>
                                    </td>
                                    <td><c:out value="${prise.pottierce}" default="-"/></td>
                                    <td><c:out value="${prise.amJI}" default="-"/></td>
                                    <td><c:out value="${prise.avJI}" default="-"/></td>
                                    <td><c:out value="${prise.courant}" default="-"/></td>
                                    <td class="text-center">
                                        <c:choose>
                                            <c:when test="${not empty prise.comment}">
                                                <small><c:out value="${prise.comment}"/></small>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="text-muted">-</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${user.id == gazoduc.user.id}">
                                                <a href="/gazoducs/${gazoduc.id}/prises/${prise.id}/edit" 
                                                   class="btn btn-warning btn-sm-custom" 
                                                   title="Modifier cette prise">
                                                    ✏️ Edit
                                                </a>
                                            </c:when>
                                            <c:otherwise>
                                                <button type="button" class="btn btn-secondary btn-sm-custom" disabled 
                                                        title="Modification non autorisée">
                                                    🔒 Locked
                                                </button>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="13" class="text-center text-muted py-4">
                                    <em>Aucune prise de mesure disponible pour ce gazoduc.</em>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <!-- Section carte et interprétation -->
        <div class="row mt-4">
            <!-- Carte -->
            <div class="col-lg-6">
                <c:if test="${not empty latitude and not empty longitude}">
                    <div class="card">
                        <div class="card-header">
                            <h5 class="card-title mb-0">Localisation</h5>
                        </div>
                        <div class="card-body">
                            <div class="alert alert-info mb-3">
                                <strong>Position sélectionnée:</strong><br>
                                <code><c:out value="${latitude}"/>, <c:out value="${longitude}"/></code>
                            </div>
                            <div id="map" role="img" aria-label="Carte de localisation"></div>
                        </div>
                    </div>
                </c:if>
            </div>

            <!-- Interprétation -->
            <div class="col-lg-6">
                <div class="card">
                    <div class="card-header">
                        <h5 class="card-title mb-0">Analyse des mesures</h5>
                    </div>
                    <div class="card-body">
                        <button class="btn btn-dark w-100 mb-3" 
                                onclick="afficherInterpretation()" 
                                type="button"
                                aria-controls="interpretationFrame">
                            📊 Analyser les paramètres
                        </button>
                        <!--
                        <iframe id="interpretationFrame" 
                                class="w-100 interpretation-frame" 
                                style="display:none; height: 300px;" 
                                title="Résultats de l'analyse des mesures"
                                sandbox="allow-scripts allow-same-origin"> 
                        </iframe>
                         -->
                        <iframe id="interpretationFrame"
						        class="w-100 interpretation-frame"
						        style="display:none; height: 400px;"
						        src=""
						        title="Analyse">
						</iframe>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
    	
    function afficherInterpretation() {
        // Analyse des lignes
        const interpretations = [];
        const rows = document.querySelectorAll("#measurementsTable tbody tr");

        rows.forEach(function(row) {
            if (row.cells.length < 13) return;

            const designation = row.cells[0].textContent.trim();
            let potONText = row.cells[4].textContent.trim().replace(/[^\d.-]/g, '');
            const potON = parseFloat(potONText);

            if (isNaN(potON) || designation === "") return;

            let status, icon, color;
            if (potON < 950) {
                status = "Non protégée - Risque de corrosion élevé";
                icon = "❌"; color = "danger";
            } else if (potON > 1350) {
                status = "Surprotection - Risque de fragilisation";
                icon = "⚠️"; color = "warning";
            } else {
                status = "Protection correcte";
                icon = "✅"; color = "success";
            }

            interpretations.push({ designation, potON, status, icon, color });
        });

        if (interpretations.length === 0) {
            alert("Aucune donnée valide trouvée pour l'analyse.");
            return;
        }

        // Enregistrer dans localStorage
        localStorage.setItem("interpretationData", JSON.stringify(interpretations));

        // Charger la page dans l'iframe
        let iframe = document.getElementById("interpretationFrame"); // ✅ seule déclaration
        iframe.src = "/interpretation.html";
        iframe.style.display = "block";
    }
	 
   // Initialisation de la carte - Version corrigée
    document.addEventListener("DOMContentLoaded", function() {
    // Debug: vérifier les valeurs reçues
     console.log("Latitude reçue: '<c:out value='${latitude}'/>'");
      console.log("Longitude reçue: '<c:out value='${longitude}'/>'");
            
            <c:if test="${not empty latitude and not empty longitude}">
            	const lat = parseFloat("<c:out value='${latitude}'/>");
            	const lon = parseFloat("<c:out value='${longitude}'/>");
                
                console.log("Latitude parsée:", lat);
                console.log("Longitude parsée:", lon);
                
                if (!isNaN(lat) && !isNaN(lon) && lat !== 0 && lon !== 0) {
                    try {
                        // Vérifier que l'élément map existe
                        const mapElement = document.getElementById('map');
                        if (!mapElement) {
                            console.error("Élément map non trouvé");
                            return;
                        }
                        
                        console.log("Initialisation de la carte...");
                        const map = L.map('map').setView([lat, lon], 15);
                        
                        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
                            maxZoom: 19,
                            attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors'
                        }).addTo(map);
                        
                        const marker = L.marker([lat, lon]).addTo(map);
                        marker.bindPopup(`
                            <div style="text-align: center;">
                                <strong>Position sélectionnée</strong><br>
                                <code>${lat.toFixed(6)}°N<br>${lon.toFixed(6)}°E</code>
                            </div>
                        `).openPopup();
                        
                        // Ajouter un cercle pour indiquer la précision
                        L.circle([lat, lon], {
                            color: 'blue',
                            fillColor: '#add8e6',
                            fillOpacity: 0.2,
                            radius: 50
                        }).addTo(map);
                        
                        console.log("Carte initialisée avec succès");
                        
                    } catch (error) {
                        console.error("Erreur lors de l'initialisation de la carte:", error);
                        document.getElementById('map').innerHTML = 
                            '<div class="alert alert-warning">Erreur lors du chargement de la carte: ' + error.message + '</div>';
                    }
                } else {
                    console.log("Coordonnées invalides - lat:", lat, "lon:", lon);
                    document.getElementById('map').innerHTML = 
                        '<div class="alert alert-info">Coordonnées non valides pour afficher la carte</div>';
                }
            </c:if>
        });
        
        // Amélioration de l'accessibilité
        document.addEventListener("DOMContentLoaded", function() {
            // Ajouter des tooltips Bootstrap
            const tooltipTriggerList = [].slice.call(document.querySelectorAll('[title]'));
            tooltipTriggerList.map(function(tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
        });
    </script>
    
    <!-- Scripts -->
    <!-- Leaflet JS -->
    <script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js" 
    		integrity="sha256-20nQCchB9co0qIjJZRGuk2/Z9VM+kNiyxNV1lvTlZBo=" 
            crossorigin=""></script>
    
    <!-- Bootstrap JS -->
    <script src="/webjars/bootstrap/js/bootstrap.bundle.min.js"></script>
    
</body>
</html>