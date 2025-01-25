package entite;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.ClassMAPTable;
import utilitaire.UtilDB;

public class ArrondissementFiche extends ClassMAPTable{
    private String id;
    private String nom;
    private int nombre_maisons;
    private double total_montant_paye;
    private double total_montant_du;
    private double total_reste_a_payer;
    private Date date_paiement;

    
    
    public ArrondissementFiche() {
        super.setNomTable("v_arrondissement_fiche");
    }
    
    public ArrondissementFiche(String id, String nom, int nombre_maisons, double total_montant_paye,
            double total_montant_du, double total_reste_a_payer, Date date_paiement) {
        this.id = id;
        this.nom = nom;
        this.nombre_maisons = nombre_maisons;
        this.total_montant_paye = total_montant_paye;
        this.total_montant_du = total_montant_du;
        this.total_reste_a_payer = total_reste_a_payer;
        this.date_paiement = date_paiement;
    }


    public String getId() {
        return id;
    }


    public void setId(String id) {
        this.id = id;
    }


    public String getNom() {
        return nom;
    }


    public void setNom(String nom) {
        this.nom = nom;
    }


    public int getNombre_maisons() {
        return nombre_maisons;
    }


    public void setNombre_maisons(int nombre_maisons) {
        this.nombre_maisons = nombre_maisons;
    }


    public double getTotal_montant_paye() {
        return total_montant_paye;
    }


    public void setTotal_montant_paye(double total_montant_paye) {
        this.total_montant_paye = total_montant_paye;
    }


    public double getTotal_montant_du() {
        return total_montant_du;
    }


    public void setTotal_montant_du(double total_montant_du) {
        this.total_montant_du = total_montant_du;
    }


    public double getTotal_reste_a_payer() {
        return total_reste_a_payer;
    }


    public void setTotal_reste_a_payer(double total_reste_a_payer) {
        this.total_reste_a_payer = total_reste_a_payer;
    }


    @Override
    public String getAttributIDName() {
        return "id";
    }

    @Override
    public String getTuppleID() {
        return id;
    }

    @Override
    public String[] getMotCles() {
        String[] motCles={"id","nom"};
        return motCles;
    }

    public Date getDate_paiement() {
        return date_paiement;
    }

    public void setDate_paiement(Date date_paiement) {
        this.date_paiement = date_paiement;
    }


    public ArrondissementFiche getMaxDette() throws Exception {
        Connection c = null;
        ArrondissementFiche arrondissementFiche = null;

        try {
            c = new UtilDB().GetConn(); // Obtenir une connexion à la base de données
            String sql = "SELECT * FROM v_max_dette"; // Requête pour la vue

            try (PreparedStatement ps = c.prepareStatement(sql)) {
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        arrondissementFiche = new ArrondissementFiche();
                        arrondissementFiche.setId(rs.getString("id"));
                        arrondissementFiche.setNom(rs.getString("nom"));
                        arrondissementFiche.setNombre_maisons(rs.getInt("nombre_maisons"));
                        arrondissementFiche.setTotal_montant_paye(rs.getDouble("total_montant_paye"));
                        arrondissementFiche.setTotal_montant_du(rs.getDouble("total_montant_du"));
                        arrondissementFiche.setTotal_reste_a_payer(rs.getDouble("total_reste_a_payer"));
                        arrondissementFiche.setDate_paiement(rs.getDate("date_paiement"));
                    }
                } catch (SQLException e) {
                    e.printStackTrace(); // Gestion des exceptions liées à ResultSet
                }
            } catch (SQLException e) {
                e.printStackTrace(); // Gestion des exceptions liées à PreparedStatement
            }
        } finally {
            if (c != null) {
                try {
                    c.close(); // Fermeture de la connexion
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }

        return arrondissementFiche; // Retourne l'enregistrement avec la dette maximale
    }

    

}
