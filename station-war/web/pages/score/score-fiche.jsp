<%@page import="affichage.*"%>
<%@page import="score.*"%>
<%@page import="user.*"%>

<%
    try {
        Score score = new Score();
        score.setNomTable("score");
        String[] intervalles = {"daty"};
        String[] criteres = {"id", "score_equipe_blue", "score_equipe_rouge", "arret_gardient_blue", "arret_gardient_rouge"};
        String[] libEntete = {"id", "score_equipe_blue", "score_equipe_rouge", "arret_gardient_blue", "arret_gardient_rouge"};
        String[] libEnteteAffiche = {"ID", "Score Équipe Bleue", "Score Équipe Rouge", "Arrêt Gardien Bleu", "Arrêt Gardien Rouge"};

        PageRecherche pr = new PageRecherche(score, request, criteres, intervalles, 3, libEntete, libEntete.length);

        pr.setTitre("Liste des Scores");
        pr.setUtilisateur((UserEJB) session.getValue("u"));
        pr.setLien((String) session.getValue("lien"));

        pr.setApres("score/score-fiche.jsp");
        String[] colSomme = {"score_equipe_blue", "score_equipe_rouge"};
        pr.creerObjetPage(libEntete, colSomme);

        pr.getFormu().getChamp("score_equipe_blue").setLibelle("Score Équipe Bleue");
        pr.getFormu().getChamp("score_equipe_rouge").setLibelle("Score Équipe Rouge");

        // Definition des lienTableau et des colonnes de lien
        String lienTableau[] = {pr.getLien() + "?but=score/score-fiche.jsp"};
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
        <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="score" id="score">
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
