package entite;

import java.sql.Date;

import affichage.PageInsert;
import bean.ClassMAPTable;

public class Paiement_impot extends ClassMAPTable{
    private String id;
    private Date date_paiement;
    private double montant_payer;
    private String maison_id;
    private String impot_id;

    public Paiement_impot() {
        super.setNomTable("paiement_impot");
        
    }

    public Paiement_impot(String id, Date date_paiement, double montant_payer, String maison_id, String impot_id) {
        this.id = id;
        this.date_paiement = date_paiement;
        this.montant_payer = montant_payer;
        this.maison_id = maison_id;
        this.impot_id = impot_id;
        
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public Date getDate_paiement() {
        return date_paiement;
    }

    public void setDate_paiement(Date date_paiement) {
        this.date_paiement = date_paiement;
    }

    public double getMontant_payer() {
        return montant_payer;
    }

    public void setMontant_payer(double montant_payer) {
        this.montant_payer = montant_payer;
    }

    public String getMaison_id() {
        return maison_id;
    }

    public void setMaison_id(String maison_id) {
        this.maison_id = maison_id;
    }

    public String getImpot_id() {
        return impot_id;
    }

    public void setImpot_id(String impot_id) {
        this.impot_id = impot_id;
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
        String[] motCles={"id","date_paiement","montant_payer","maison_id","impot_id"};
        return motCles;
    }    
}
