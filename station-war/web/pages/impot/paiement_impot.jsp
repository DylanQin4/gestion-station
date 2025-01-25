<%@page import="entite.*"%>
<%@ page import="user.*"%>
<%@ page import="bean.*"%>
<%@ page import="utilitaire.*"%>
<%@ page import="affichage.*"%>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
    try {
        Paiement_impot a = new Paiement_impot();
        PageInsert pi = new PageInsert(a, request, (user.UserEJB) session.getValue("u"));
        pi.setLien((String) session.getValue("lien"));
        Liste[] liste = new Liste[1];
        Maison maison = new Maison();
        maison.setNomTable("maison");
        
        Impot impot = new Impot();
        impot.setNomTable("impot");
        
        // Récupérer maisonId depuis l'attribut de la requête
        String maisonId = request.getParameter("maisonId");
        
        // Correction de la récupération de la date
        String date_paiement = request.getParameter("date_paiement");
        
        liste[0] = new Liste("maison_id", maison, "id", "id");
        pi.getFormu().changerEnChamp(liste);
        
        pi.getFormu().getChamp("date_paiement").setLibelle("Date du Paiement");
        pi.getFormu().getChamp("montant_payer").setLibelle("Montant A Payer");
        pi.getFormu().getChamp("maison_id").setLibelle("Maison");

        ImpotLib impot_lib = new ImpotLib();
        if(maisonId != null && !maisonId.trim().isEmpty() && date_paiement != null && !date_paiement.trim().isEmpty()){
            String impot_id = impot_lib.getIdImpotMaison(maisonId).getImpot_id();
            double reste_a_payer = impot_lib.getResteAPayer(maisonId, date_paiement);
            System.out.println("IMPOT "+impot_id);
            System.out.println("reste_a_payer "+reste_a_payer);
            System.out.println("date_payement "+date_paiement);
            
            
        
            pi.getFormu().getChamp("impot_id").setDefaut(impot_id);
            pi.getFormu().getChamp("montant_payer").setDefaut(String.valueOf(reste_a_payer));
        }
        
        pi.getFormu().getChamp("impot_id").setVisible(false);
        
        String classe = "entite.Paiement_impot";
        String butApresPost = "impot/paiement_impot_list.jsp";
        String nomTable = "paiement_impot";
        
        pi.preparerDataFormu();
        pi.getFormu().makeHtmlInsertTabIndex();
%>

<div class="content-wrapper">
    <h1 align="center">Paiement Impot</h1>
    <form action="<%=pi.getLien()%>?but=apresTarif.jsp" method="post" data-parsley-validate>
        <%
            out.println(pi.getFormu().getHtmlInsert());
        %>
        <input name="acte" type="hidden" id="nature" value="insert">
        <input name="bute" type="hidden" id="bute" value="<%= butApresPost %>">
        <input name="classe" type="hidden" id="classe" value="<%= classe %>">
        <input name="nomtable" type="hidden" id="nomtable" value="<%= nomTable %>">
        <input type="hidden" id="currentMaisonId" value="<%= maisonId != null ? maisonId : "" %>">
        
        <div id="selected-maison-id" style="margin-top: 20px; font-weight: bold;"></div>
    </form>
</div>


<script>
document.addEventListener("DOMContentLoaded", function () {
    var maisonInput = document.querySelector("select[name='maison_id']");
    var dateInput = document.querySelector("input[name='date_paiement']");
    var displayDiv = document.getElementById("selected-maison-id");
    var currentMaisonId = document.getElementById("currentMaisonId").value;
    
    if (currentMaisonId && maisonInput) {
        maisonInput.value = currentMaisonId;
        displayDiv.textContent = "Maison sélectionnée : " + currentMaisonId;
    }
    
    if (maisonInput && dateInput) {
        maisonInput.addEventListener("change", function () {
            var maisonId = maisonInput.value;
            var datePaiement = dateInput.value;
            displayDiv.textContent = "Maison sélectionnée : " + maisonId;
            
            window.location.href = "http://localhost:9093/station/pages/module.jsp?but=impot/paiement_impot.jsp?maisonId=" + 
                encodeURIComponent(maisonId) + 
                "&date_paiement=" + encodeURIComponent(datePaiement);
        });
        
        dateInput.addEventListener("change", function() {
            var maisonId = maisonInput.value;
            var datePaiement = dateInput.value;
            
            if (maisonId) {
                window.location.href = "http://localhost:9093/station/pages/module.jsp?but=impot/paiement_impot.jsp?maisonId=" + 
                    encodeURIComponent(maisonId) + 
                    "&date_paiement=" + encodeURIComponent(datePaiement);
            }
        });
    } else {
        console.error("Impossible de trouver l'input maison_id ou date_paiement.");
    }
});
</script>

<%
    } catch (Exception e) {
        e.printStackTrace();
    }
%>