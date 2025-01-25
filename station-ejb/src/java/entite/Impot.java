package entite;

import java.sql.Date;

import bean.ClassMAPTable;

public class Impot extends ClassMAPTable{
    private String id;
    private double impot_metre_carre;
    private Date date_changement;
    private String arrondissement_id;

    
    public Impot() {
        super.setNomTable("impot");
    }

    
    public Impot(String id, double impot_metre_carre, Date date_changement, String arrondissement_id) {
        this.id = id;
        this.impot_metre_carre = impot_metre_carre;
        this.date_changement = date_changement;
        this.arrondissement_id = arrondissement_id;
    }


    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public double getImpot_metre_carre() {
        return impot_metre_carre;
    }
    public void setImpot_metre_carre(double impot_metre_carre) {
        this.impot_metre_carre = impot_metre_carre;
    }
    public Date getDate_changement() {
        return date_changement;
    }
    public void setDate_changement(Date date_changement) {
        this.date_changement = date_changement;
    }
    public String getArrondissement_id() {
        return arrondissement_id;
    }
    public void setArrondissement_id(String arrondissement_id) {
        this.arrondissement_id = arrondissement_id;
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
        String[] motCles={"id","impot_metre_carre","date_changement","arrondissement_id"};
        return motCles;
    }   
}
