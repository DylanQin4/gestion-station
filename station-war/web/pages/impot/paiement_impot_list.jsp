<%@page import="affichage.*"%>
<%@page import="entite.*"%>
<%@page import="user.*"%>

<%
    try {
        Paiement_impot paiement_impot = new Paiement_impot();
        paiement_impot.setNomTable("paiement_impot");
        String[] intervalles = {"daty"};
        String[] criteres = {"id", "date_paiement", "montant_payer", "maison_id", "impot_id"};
        String[] libEntete = {"id", "date_paiement", "montant_payer", "maison_id", "impot_id"};
        String[] libEnteteAffiche = {"ID", "Date Payement", "Montant", "Maison", "Impot"};

        PageRecherche pr = new PageRecherche(paiement_impot, request, criteres, intervalles, 3, libEntete, libEntete.length);

        pr.setTitre("Liste des Impot");
        pr.setUtilisateur((UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("impot/paiement_impot_list.jsp");
        String[] colSomme = {"montant_payer"};
        pr.creerObjetPage(libEntete, colSomme);

        pr.getFormu().getChamp("date_paiement").setLibelle("Date Payement");
        pr.getFormu().getChamp("montant_payer").setLibelle("Montant Payer");
        pr.getFormu().getChamp("maison_id").setLibelle("Maison");
        pr.getFormu().getChamp("impot_id").setLibelle("Impot");
        

        // Definition des lienTableau et des colonnes de lien
        String lienTableau[] = {pr.getLien() + "?but=impot/paiement_impot_list.jsp"};
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
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="paiement_impot" id="paiement_impot">
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
    </section>
</div>

<% 
    } catch (Exception e) {
        e.printStackTrace();
    }
%>
