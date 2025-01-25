package entite;

import java.sql.Connection;

import bean.CGenUtil;
import bean.ClassMAPTable;
import utilitaire.UtilDB;

public class Maison extends ClassMAPTable{
    private String id;
    private int nb_etage;
    private double longeur;
    private double largeur;
    private double latitude;
    private double longitude;
    private String arrondissement_id;

    
    public Maison() {
        super.setNomTable("maison");
    }

    
    public Maison(String id, int nb_etage, double longeur, double largeur, double latitude, double longitude,
            String arrondissement_id) {
        this.id = id;
        this.nb_etage = nb_etage;
        this.longeur = longeur;
        this.largeur = largeur;
        this.latitude = latitude;
        this.longitude = longitude;
        this.arrondissement_id = arrondissement_id;
    }


    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public int getNb_etage() {
        return nb_etage;
    }
    public void setNb_etage(int nb_etage) {
        this.nb_etage = nb_etage;
    }
    public double getLongeur() {
        return longeur;
    }
    public void setLongeur(double longeur) {
        this.longeur = longeur;
    }
    public double getLargeur() {
        return largeur;
    }
    public void setLargeur(double largeur) {
        this.largeur = largeur;
    }
    public double getLatitude() {
        return latitude;
    }
    public void setLatitude(double latitude) {
        this.latitude = latitude;
    }
    public double getLongitude() {
        return longitude;
    }
    public void setLongitude(double longitude) {
        this.longitude = longitude;
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
        String[] motCles={"id","nb_etage","longeur","largeur","latitude","longitude","arrondissement_id"};
        return motCles;
    }    

    public Maison[] getAllMaison() throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            Maison maison = new Maison();
            
            Maison[] resultats = (Maison[]) CGenUtil.rechercher(maison, null, null, c, "");
            
            if (resultats.length == 0) {
                return null;
            }
            
            return resultats;
            
        } finally {
            if (c != null) {
                try {
                    c.close();
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
    }
}
