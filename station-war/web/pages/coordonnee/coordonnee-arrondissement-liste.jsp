<%@page import="affichage.*"%>
<%@page import="entite.*"%>
<%@page import="user.*"%>

<%
    try {
        Coordonnee_arrondissement coordonnee_arrondissement = new Coordonnee_arrondissement();
        coordonnee_arrondissement.setNomTable("coordonnee_arrondissement");

        String[] intervalles = {"daty"};
        String[] criteres = {"id", "longitude", "latitude", "arrondissement_id"};
        String[] libEntete = {"id", "longitude", "latitude", "arrondissement_id"};
        String[] libEnteteAffiche = {"ID", "Longitude", "Latitude", "Arrondissement"};

        PageRecherche pr = new PageRecherche(coordonnee_arrondissement, request, criteres, intervalles, 3, libEntete, libEntete.length);

        pr.setTitre("Liste des Coordonnee");
        pr.setUtilisateur((UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("coordonnee/coordonnee-arrondissement-liste.jsp");
        String[] colSomme = {"longitude", "latitude"};
        pr.creerObjetPage(libEntete, colSomme);

        pr.getFormu().getChamp("longitude").setLibelle("Longitude");
        pr.getFormu().getChamp("latitude").setLibelle("Latitude");
        pr.getFormu().getChamp("arrondissement_id").setLibelle("Arrondissement");
        
        // Definition des lienTableau et des colonnes de lien
        String lienTableau[] = {pr.getLien() + "?but=coordonnee/coordonnee-arrondissement-liste.jsp"};
        String colonneLien[] = {"id"};
        pr.getTableau().setLien(lienTableau);
        pr.getTableau().setColonneLien(colonneLien);
        pr.getTableau().setLibelleAffiche(libEnteteAffiche);
%>  

<div class="content-wrapper">
    <section class="content-header">
        <h1><%= pr.getTitre() %></h1>
    </section>
    <section class="content">
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="coordonnee_arrondissement" id="coordonnee_arrondissement">
            <%
                out.println(pr.getFormu().getHtmlEnsemble());
            %>
        </form>
        
        <br>
        <%
            out.println(pr.getTableau().getHtml());
            out.println(pr.getBasPage());
        %>
    </section>
</div>

<% 
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
