<%@page import="entite.*"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try {
        UserEJB u = null;
        u = (UserEJB) session.getValue("u");
        
        Coordonnee_arrondissement mere = new Coordonnee_arrondissement();
        Coordonnee_arrondissement fille = new Coordonnee_arrondissement();
        int nombreLigne = 10;
        PageInsertMultiple pi = new PageInsertMultiple(mere, fille, request, nombreLigne, u);
        pi.setLien((String) session.getValue("lien"));
        
        Liste[] liste = new Liste[1];
        Arrondissement arrondissement = new Arrondissement();
        arrondissement.setNomTable("arrondissement");

        
        liste[0] = new Liste("arrondissement_id", arrondissement, "nom", "id");
        pi.getFormufle().changerEnChamp(liste);

        pi.getFormu().getChamp("longitude").setLibelle("Longitude");
        pi.getFormu().getChamp("longitude").setDefaut("");
        
        pi.getFormu().getChamp("latitude").setLibelle("Latitude");
        pi.getFormu().getChamp("longitude").setDefaut("");
        
        pi.getFormu().getChamp("arrondissement_id").setLibelle("Arrondissement");
        pi.getFormu().changerEnChamp(liste);
        


        String[] latitudes = request.getParameterValues("latitude[]");
        String[] longitudes = request.getParameterValues("longitude[]");

        // Vérification si les paramètres sont null ou vides
        if (latitudes != null && longitudes != null && latitudes.length == longitudes.length) {
            // Pour accéder aux valeurs
            for (int i = 0; i < latitudes.length; i++) {
                String lat = latitudes[i];
                String lng = longitudes[i];
                
                affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
                pi.getFormufle().getChamp("longitude_" + i).setLibelle("Longitude");
                pi.getFormufle().getChamp("longitude_" + i).setDefaut(lng);
                pi.getFormufle().getChamp("latitude_" + i).setLibelle("Latitude");
                pi.getFormufle().getChamp("latitude_" + i).setDefaut(lat);
                pi.getFormufle().getChamp("arrondissement_id_0").setLibelle("Arrondissement");
            }
        } else {
                affichage.Champ.setVisible(pi.getFormufle().getChampFille("id"), false);
                pi.getFormufle().getChamp("longitude_0").setLibelle("Longitude");
                pi.getFormufle().getChamp("latitude_0").setLibelle("Latitude");
                pi.getFormufle().getChamp("arrondissement_id_0").setLibelle("Arrondissement");
        }

        String classeMere = "entite.Coordonnee_arrondissement";
        String classeFille = "entite.Coordonnee_arrondissement";
        String tab="coordonnee_arrondissement";
        String butApresPost = "coordonnee/coordonnee-arrondissement-liste.jsp";
        String colonneMere = "id";
    
        pi.preparerDataFormu();
        
        pi.getFormu().makeHtmlInsertTabIndex();
        pi.getFormufle().makeHtmlInsertTableauIndex();

%>
<div class="content-wrapper">
    <div class="row">
        <div class="col-md-12">
            <div class="box-fiche">
                <div class="box">
                    <div class="box-title with-border">
                        <h1>Saisie Coordonnées Arrondissement</h1>
                    </div>
                    <div class="box-body">
                        <form class="container" action="<%=pi.getLien()%>?but=apresMultiple.jsp" method="post" data-parsley-validate>
                            <%    
                                out.println(pi.getFormu().getHtmlInsert());
                                out.println(pi.getFormufle().getHtmlTableauInsert());
                            %>
                            
                            <input name="acte" type="hidden" id="nature" value="insert">
                            <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
                            <input name="classe" type="hidden" id="classe" value="<%= classeMere %>">
                            <input name="classefille" type="hidden" id="classefille" value="<%= classeFille %>">
                            <input name="nombreLigne" type="hidden" id="nombreLigne" value="<%= nombreLigne %>">
                            <input name="colonneMere" type="hidden" id="colonneMere" value="<%= colonneMere %>">
                            
                        </form> 
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
%>
    <script language="JavaScript">
        alert('<%=e.getMessage()%>');
        history.back();
    </script>
<% }%>