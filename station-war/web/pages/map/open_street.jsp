<%@page contentType="text/html" pageEncoding="UTF-8"%>
<link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css" />
<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<style>
    #map { 
        height: 800px; 
        width: 100%;
    }
    #coordinates {
        position: fixed;
        top: 30px;
        right: 10px;
        z-index: 1000;
        background: white;
        padding: 10px;
        border-radius: 5px;
        box-shadow: 0 0 10px rgba(0,0,0,0.2);
    }
    .error-message {
        color: red;
        margin-top: 10px;
    }
</style>

<%@page import="entite.*"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="java.util.*"%>
<%
    Coordonnee_arrondissement coordArr = new Coordonnee_arrondissement();
    Coordonnee_arrondissement[] coordonnees = null;
    ArrondissementFiche arrondissement = new ArrondissementFiche();
    ArrondissementFiche arrondissement_data = null;

    Maison maisonArr = new Maison();
    Maison[] maison_coord = null;
    

    
    try {
        coordonnees = coordArr.getAllCoordonnee_arrondissements();
        maison_coord = maisonArr.getAllMaison();
        arrondissement_data = arrondissement.getMaxDette();
    } catch (Exception e) {
        e.printStackTrace();
    }

    Gson gson = new Gson();
    String coordonneesJson = gson.toJson(coordonnees != null ? Arrays.asList(coordonnees) : new ArrayList<>());
    String maison_coordJson = gson.toJson(maison_coord != null ? Arrays.asList(maison_coord) : new ArrayList<>());
    String arrondissementdDetteJson = gson.toJson(arrondissement_data != null ? Arrays.asList(arrondissement_data) : new ArrayList<>());
    
%>

<div class="content-wrapper">
    <section class="content">
        <form id="coordinatesForm" method="POST" action="http://localhost:9093/station/pages/module.jsp?but=coordonnee/coordonnee-arrondissement-saisie.jsp">
            <div id="coordinates">
                <h3>Points cliqués :</h3>
                <ul id="clicked-points"></ul>
                <div id="status-message"></div>
                <div id="coordinate-inputs"></div>
                <button type="submit" class="btn btn-primary mt-3">Envoyer les coordonnées</button>
                <button type="button" id="newPolylineButton" class="btn btn-secondary mt-3">Nouvelle Polyligne</button>
                <button type="button" id="addHouseButton" class="btn btn-success mt-3">Ajouter une Maison</button>
            </div>
        </form>

        <div id="map"></div>

        <script>
            let points = [];
            let polylinesById = {};
            let currentPolylineId = null;

            function initializeMap() {
                const map = L.map('map').setView([-18.8792, 47.5079], 6);

                L.tileLayer('https://api.maptiler.com/maps/openstreetmap/{z}/{x}/{y}.jpg?key=AKxuA1GHwAOCnz21gjbx', {
                    tileSize: 512,
                    zoomOffset: -1,
                    minZoom: 1,
                    attribution: '© MapTiler © OpenStreetMap contributors'
                }).addTo(map);

                return map;
            }

            function addMarkersFromCoordinates(map, coordonnees) {
                var pointStyle = {
                    radius: 5,
                    fillColor: "#ff0000",
                    color: "#ff0000",
                    weight: 2,
                    opacity: 1,
                    fillOpacity: 0.8
                };

                // Parse the arrondissement with max debt
                var arrondissementMaxDette = <%= arrondissementdDetteJson %>;
                var maxDetteArrondissementId = arrondissementMaxDette.length > 0 ? arrondissementMaxDette[0].id : null;

                // Regrouper les coordonnées par id
                var groupedById = coordonnees.reduce(function(acc, point) {
                    if (!acc[point.arrondissement_id]) {
                        acc[point.arrondissement_id] = [];
                    }
                    acc[point.arrondissement_id].push([point.latitude, point.longitude]);
                    return acc;
                }, {});

                // Gérer les polylignes et les marqueurs pour chaque groupe
                Object.entries(groupedById).forEach(function(entry) {
                    var arrondissement_id = entry[0];
                    var polylinePoints = entry[1];

                    if (polylinePoints.length > 0) {
                        // Définir le style de la polyligne
                        var polylineStyle = {
                            color: 'blue',
                            weight: 2,
                            fillColor: arrondissement_id === maxDetteArrondissementId ? 'red' : 'transparent',
                            fillOpacity: 0.3
                        };

                        // Ajouter une polyligne
                        var polyline = L.polyline(polylinePoints, polylineStyle).addTo(map);

                        // Calculer le centre de la polyligne et ajouter un marqueur avec l'id
                        var bounds = polyline.getBounds();
                        var center = bounds.getCenter();

                        var marker = L.marker(center).addTo(map);
                        
                        // Ajouter un texte indiquant si c'est l'arrondissement avec la dette maximale
                        var popupContent = arrondissement_id === maxDetteArrondissementId 
                            ? '<span style="font-size: 20px; font-weight: bold; color: red;">' + arrondissement_id + ' (Max Dette)</span>'
                            : '<span style="font-size: 20px; font-weight: bold;">' + arrondissement_id + '</span>';
                        
                        marker.bindPopup(popupContent).openPopup();

                        // Ajouter un événement de clic sur le marqueur pour rediriger vers le lien
                        marker.on('click', function () {
                            var url = 'http://localhost:9093/station/pages/module.jsp?but=coordonnee/coordonnee-arrondissement-fiche.jsp&id=' + arrondissement_id;
                            window.location.href = url;
                        });
                    }
                });

                // Ajouter les points comme des cercles
                coordonnees.forEach(function(point) {
                    L.circleMarker([point.latitude, point.longitude], pointStyle).addTo(map);
                });

                // Ajuster la vue
                if (coordonnees.length > 0) {
                    var bounds = coordonnees.map(function(point) {
                        return [point.latitude, point.longitude];
                    });
                    map.fitBounds(L.latLngBounds(bounds));
                }
            }

            function updateFormInputs() {
                const container = document.getElementById('coordinate-inputs');
                container.innerHTML = '';
                points.forEach((point, index) => {
                    const latInput = document.createElement('input');
                    latInput.type = 'hidden';
                    latInput.name = `latitude[${index}]`;
                    latInput.value = point.lat;
                    
                    const lngInput = document.createElement('input');
                    lngInput.type = 'hidden';
                    lngInput.name = `longitude[${index}]`;
                    lngInput.value = point.lng;
                    
                    container.appendChild(latInput);
                    container.appendChild(lngInput);
                });
            }

            function handleMapClick(map) {
                map.on('click', function(e) {
                    const lat = e.latlng.lat.toFixed(6);
                    const lng = e.latlng.lng.toFixed(6);

                    points.push({ lat, lng });

                    // Ajouter le point
                    L.circleMarker([lat, lng], {
                        radius: 5,
                        fillColor: "#ff0000",
                        color: "#ff0000",
                        weight: 2,
                        opacity: 1,
                        fillOpacity: 0.8
                    }).addTo(map);

                    // Mettre à jour la polyligne actuelle
                    if (currentPolylineId) {
                        if (!polylinesById[currentPolylineId]) {
                            polylinesById[currentPolylineId] = L.polyline([], {
                                color: 'green',
                                weight: 2
                            }).addTo(map);
                        }
                        polylinesById[currentPolylineId].addLatLng([lat, lng]);
                    }

                    updateFormInputs();
                });
            }

            function handleNewPolyline() {
                document.getElementById('newPolylineButton').addEventListener('click', function() {
                    currentPolylineId = prompt("Entrez l'ID de la nouvelle polyligne :");
                    if (currentPolylineId) {
                        points = [];
                        showMessage(`Nouvelle polyligne créée avec l'ID ${currentPolylineId}.`, 'success');
                    } else {
                        showMessage('Aucun ID fourni pour la nouvelle polyligne.', 'error');
                    }
                });
            }

            function handleFormSubmission() {
                document.getElementById('coordinatesForm').addEventListener('submit', function(e) {
                    if (points.length === 0) {
                        e.preventDefault();
                        showMessage('Veuillez sélectionner au moins un point sur la carte.', 'error');
                    }
                });
            }

            function showMessage(message, type) {
                const statusDiv = document.getElementById('status-message');
                statusDiv.textContent = message;
                statusDiv.className = type === 'error' ? 'error-message' : 'success-message';
            }

            function handleAddHouse(map) {
                document.getElementById('addHouseButton').addEventListener('click', function () {
                    map.once('click', function (e) {
                        const lat = e.latlng.lat.toFixed(6);
                        const lng = e.latlng.lng.toFixed(6);

                        // Ajouter un marqueur rouge pour la maison
                        const customIcon = L.divIcon({
                            className: 'custom-marker',
                            html: '<div style="background-color: green; width: 20px; height: 20px; border-radius: 50%; border: 2px solid white;"></div>',
                            iconSize: [20, 20],
                            iconAnchor: [10, 10], // Centrer le point
                        });

                        L.marker([lat, lng], { icon: customIcon })
                            .addTo(map)
                            .bindPopup('Maison ajoutée ici !')
                            .openPopup();

                        // Message de confirmation
                        alert('Maison ajoutée aux coordonnées : Latitude ' + lat + ', Longitude ' + lng);

                        // Envoyer les coordonnées à l'URL
                        var url = "http://localhost:9093/station/pages/module.jsp?but=maison/coordonnee-maison-saisie.jsp&lat=" + lat + "&lng=" + lng;
                        window.location.href = url;
                    });
                });
            }

            function addHouseMarkers(map, maisons) {
                if (!map || !maisons || maisons.length === 0) return; // Vérifier que la carte et les données sont valides

                maisons.forEach(function (house, index) {
                    const lat = house.latitude;
                    const lng = house.longitude;

                    if (!lat || !lng) {
                        console.warn('Maison avec coordonnées invalides :', house);
                        return; // Ignorer les maisons sans coordonnées valides
                    }

                    // Personnalisation du marqueur pour une maison
                    const customIcon = L.divIcon({
                        className: 'custom-marker',
                        html: '<div style="background-color: green; width: 20px; height: 20px; border-radius: 50%; border: 2px solid white;"></div>',
                        iconSize: [20, 20],
                        iconAnchor: [10, 10] // Centrer l'icône
                    });

                    // Ajouter le marqueur sur la carte
                    const marker = L.marker([lat, lng], { icon: customIcon })
                        .addTo(map)
                        .bindPopup('<span style="font-size: 16px; font-weight: bold;">Maison ID: ' + house.id + '</span>');

                    // Rediriger vers l'URL de la maison au clic
                    marker.on('click', function () {
                        const url = 'http://localhost:9093/station/pages/module.jsp?but=maison/coordonnee-maison-fiche.jsp&id=' + house.id;
                        window.location.href = url;
                    });

                    // Centrer la carte uniquement sur la première maison ajoutée
                    if (index === 0) {
                        map.flyTo([lat, lng], 14);
                    }
                });
            }



            // Initialisation au chargement de la page
            document.addEventListener('DOMContentLoaded', function() {
                const map = initializeMap();
                const coordonnees = <%= coordonneesJson %>;
                const maisons = <%= maison_coordJson %>;


                addMarkersFromCoordinates(map, coordonnees);
                addHouseMarkers(map, maisons);

                handleMapClick(map);
                handleNewPolyline();
                handleFormSubmission();
                handleAddHouse(map);
            });
        </script>
    </section>
</div>
