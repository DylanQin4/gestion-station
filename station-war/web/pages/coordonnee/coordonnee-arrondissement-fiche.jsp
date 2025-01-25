       <%@page import="affichage.*"%>
       <%@page import="entite.*"%>
       <%@page import="user.*"%>

       <%
       try {
              ArrondissementFiche arrondissement_fiche = new ArrondissementFiche();

              String id = request.getParameter("id");
              if (id != null && !id.trim().isEmpty()) {
              arrondissement_fiche.setId(id);
              }

              // Définition des critères de recherche
              String[] intervalles = {"date_paiement"};
              String[] criteres = {
              "id", "nom","date_paiement"
              };

              String[] libEntete = {
              "id", "nom", "nombre_maisons", 
              "total_montant_paye", "total_montant_du", 
              "total_reste_a_payer","date_paiement"
              };

              String[] libEnteteAffiche = {
              "ID", "Nom", "Nombre Maisons", 
              "Total Montant Payé", "Total Montant Dû", 
              "Total Reste à Payer","Date Paiement"
              };

              // Initialisation de PageRecherche
              PageRecherche pr = new PageRecherche(arrondissement_fiche, request, criteres, intervalles, 3, libEntete, libEntete.length);

              pr.setTitre("Recherche Arrondissement");
              pr.setUtilisateur((UserEJB) session.getValue("u"));
              pr.setLien((String) session.getValue("lien"));
              pr.setApres("coordonnee/coordonnee-arrondissement-fiche.jsp");

              // Configuration des colonnes pour les sommes
              String[] colSomme = {"nombre_maisons","total_montant_paye", "total_montant_du", "total_reste_a_payer"};
              pr.creerObjetPage(libEntete, colSomme);

              // Configuration des libellés
              pr.getFormu().getChamp("date_paiement1").setLibelle("Date Min");
              pr.getFormu().getChamp("date_paiement2").setLibelle("Date Max");

              // Si un ID est fourni, on pré-remplit le formulaire
              if (id != null && !id.trim().isEmpty()) {
              pr.getFormu().getChamp("id").setValeur(id);
              }

              // Configuration des liens dans le tableau
              String lienTableau[] = {pr.getLien() + "?but=coordonnee/coordonnee-arrondissement-fiche.jsp"};
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
                            <form action="<%=pr.getLien()%>?but=<%= pr.getApres() %>" method="post" name="arrondissement" id="arrondissement">
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
