<%@page import="score.Score"%>
<%@ page import="user.*" %>
<%@ page import="bean.*" %>
<%@ page import="utilitaire.*" %>
<%@ page import="affichage.*" %>

<%
    try{
    Score a = new Score();
    PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
    pi.setLien((String) session.getValue("lien"));
    
    pi.getFormu().getChamp("score_equipe_blue").setLibelle("SCORE BLUE");
    pi.getFormu().getChamp("score_equipe_blue").setDefaut("12");
    
    pi.getFormu().getChamp("score_equipe_rouge").setLibelle("SCORE RED");
    pi.getFormu().getChamp("arret_gardient_blue").setLibelle("ARRET BLUE");
    pi.getFormu().getChamp("arret_gardient_rouge").setLibelle("ARRET RED");
    
    String classe = "score.Score";

    String butApresPost = "score/score-fiche.jsp";
    String nomTable = "score";
    pi.preparerDataFormu();
    pi.getFormu().makeHtmlInsertTabIndex();
%>
<div class="content-wrapper">
    <h1 align="center">Saisie Score</h1>
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
