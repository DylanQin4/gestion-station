<%@page import="entite.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    Maison a = new Maison();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    Liste[] liste = new Liste[1];
    Arrondissement arrondissement = new Arrondissement();
    arrondissement.setNomTable("arrondissement");

    liste[0] = new Liste("arrondissement_id", arrondissement, "nom", "id");
    
    pi.getFormu().getChamp("nb_etage").setLibelle("nombre etage");
    
    String lat = request.getParameter("lat");
    String lng = request.getParameter("lng");
    if (lat != null && lng != null) {
        
        // Convertir les latitudes et longitudes en double
        double latitude = Double.parseDouble(lat);
        double longitude = Double.parseDouble(lng);
                
        String arrondissement_id = arrondissement.getArrondissementByCoordinates(latitude, longitude);

        pi.getFormu().getChamp("longeur").setLibelle("Longeur");
        pi.getFormu().getChamp("largeur").setLibelle("Largeur");
        pi.getFormu().getChamp("latitude").setLibelle("Latitude");
        pi.getFormu().getChamp("latitude").setDefaut(lat);
        pi.getFormu().getChamp("longitude").setLibelle("Longitude");
        pi.getFormu().getChamp("longitude").setDefaut(lng);
        pi.getFormu().getChamp("arrondissement_id").setLibelle("Arrondissement");
        pi.getFormu().getChamp("arrondissement_id").setDefaut(arrondissement_id);
        //pi.getFormu().changerEnChamp(liste);   
        System.out.println("arrondissement_id"+arrondissement_id);
              
    }else{
        pi.getFormu().getChamp("longeur").setLibelle("Longeur");
        pi.getFormu().getChamp("largeur").setLibelle("Largeur");
        pi.getFormu().getChamp("latitude").setLibelle("Latitude");
        pi.getFormu().getChamp("longitude").setLibelle("Longitude");
        pi.getFormu().getChamp("arrondissement_id").setLibelle("Arrondissement");
        pi.getFormu().changerEnChamp(liste);
            
    }
        
    String classe = "entite.Maison";

    String butApresPost = "maison/coordonnee-maison-liste.jsp";
    String nomTable = "maison";
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Saisie Coordonnee Maison</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post"  data-parsley-validate>
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
        
    </form>
</div>
<%
} catch (Exception e) {
    e.printStackTrace();
} %>
