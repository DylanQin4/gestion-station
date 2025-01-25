package entite;

import java.sql.Date;

public class MaisonFiche extends Maison{
    private String impot_id;
    private double montant_total;
    private double montant_paye;
    private double reste_a_payer;
    private Date date_paiement;

    
    public MaisonFiche() {
        super.setNomTable("v_situation_impots");
    }
    
    public String getImpot_id() {
        return impot_id;
    }
    public void setImpot_id(String impot_id) {
        this.impot_id = impot_id;
    }
    public double getMontant_total() {
        return montant_total;
    }
    public void setMontant_total(double montant_total) {
        this.montant_total = montant_total;
    }
    public double getMontant_paye() {
        return montant_paye;
    }
    public void setMontant_paye(double montant_paye) {
        this.montant_paye = montant_paye;
    }
    public double getReste_a_payer() {
        return reste_a_payer;
    }
    public void setReste_a_payer(double reste_a_payer) {
        this.reste_a_payer = reste_a_payer;
    }
    public Date getDate_paiement() {
        return date_paiement;
    }
    public void setDate_paiement(Date date_paiement) {
        this.date_paiement = date_paiement;
    }

    
}
