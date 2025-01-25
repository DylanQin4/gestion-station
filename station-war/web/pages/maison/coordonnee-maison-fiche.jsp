<%@page import="affichage.*"%>
<%@page import="entite.*"%>
<%@page import="user.*"%>

<%
    try {
        MaisonFiche maison_fiche = new MaisonFiche();
        
        String id = request.getParameter("id");
        if(id != null && !id.trim().isEmpty()) {
            maison_fiche.setId(id);
        }

        // Définition des critères de recherche avec tous les champs
        String[] intervalles = {"date_paiement"}; // Ajout de l'intervalle de date
        String[] criteres = {
            "id","date_paiement"
        };

        String[] libEntete = {
            "id", "nb_etage", "longeur", "largeur", 
            "latitude", "longitude", "arrondissement_id",
            "impot_id", "montant_total", "montant_paye",
            "reste_a_payer", "date_paiement"
        };
        
        String[] libEnteteAffiche = {
            "ID", "Nombre Étages", "Longueur", "Largeur",
            "Latitude", "Longitude", "Arrondissement",
            "Impôt", "Montant Total", "Montant Payé",
            "Reste à Payer", "Date Paiement"
        };

        // Initialisation de PageRecherche
        PageRecherche pr = new PageRecherche(maison_fiche, request, criteres, intervalles, 3, libEntete, libEntete.length);

        pr.setTitre("Recherche Maison");
        pr.setUtilisateur((UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));
        pr.setApres("maison/coordonnee-maison-fiche.jsp");

        // Configuration des colonnes pour les sommes
        String[] colSomme = {"montant_total", "montant_paye", "reste_a_payer"};
        pr.creerObjetPage(libEntete, colSomme);

        // Configuration des libellés avec les mêmes libellés que votre exemple
        pr.getFormu().getChamp("date_paiement1").setLibelle("Date Min");
        pr.getFormu().getChamp("date_paiement2").setLibelle("Date Max");
        
               // Si un ID est fourni, on pré-remplit le formulaire
        if(id != null && !id.trim().isEmpty()) {
            pr.getFormu().getChamp("id").setValeur(id);
        }

        // Configuration des liens dans le tableau
        String lienTableau[] = {pr.getLien() + "?but=maison/coordonnee-maison-fiche.jsp"};
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
        <div class="row">
            <div class="col-md-12">
                <div class="box">
                    <div class="box-body">
                        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="maison" id="maison">
                            <%
                                out.println(pr.getFormu().getHtmlEnsemble());
                            %>
                        </form>
                        <%
                            out.println(pr.getTableauRecap().getHtml());
                        %>
                        <br>
                        <%
                            out.println(pr.getTableau().getHtml());
                            out.println(pr.getBasPage());
                        %>
                    </div>
                </div>
            </div>
        </div>
    </section>
</div>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>