<%@page import="test.Test"%>
<%@page import="affichage.PageInsert"%> 
<%@page import="user.UserEJB"%>
<%@page import="bean.TypeObjet"%>
<%@page import="affichage.Liste"%>


<%
try{
    String autreparsley = "data-parsley-range='[8, 40]' required";
    UserEJB u = (user.UserEJB) session.getValue("u");
    String  mapping = "test.Test",
            nomtable = "Test",
            apres = "test/test-fiche.jsp",
            titre = "Nouveau Test";
    Test test = new Test();
    test.setNomTable("TEST");
    PageInsert pi = new PageInsert(client, request, u);
    pi.setLien((String) session.getValue("lien"));
    pi.getFormu().getChamp("nom").setLibelle("Nom");
    pi.getFormu().getChamp("prenom").setLibelle("Prenom");
%>

<div class="content-wrapper">
    <h1> <%=titre%></h1>
    
    <form action="<%=pi.getLien()%>?but=apresTest.jsp" method="post" name="<%=nomtable%>" id="<%=nomtable%>">
    <%
        pi.getFormu().makeHtmlInsertTabIndex();
        out.println(pi.getFormu().getHtmlInsert());
        out.println(pi.getHtmlAddOnPopup());
    %>
    <input name="acte" type="hidden" id="nature" value="insert">
    <input name="bute" type="hidden" id="bute" value="<%=apres%>">
    <input name="classe" type="hidden" id="classe" value="<%=mapping%>">
    <input name="nomtable" type="hidden" id="nomtable" value="<%=nomtable%>">
    </form>
</div>


<%
    

}catch (Exception e) {
    e.printStackTrace();
%>
<script language="JavaScript"> alert('<%=e.getMessage()%>');
    history.back();</script>

<% }%>