package entite;

import java.sql.Connection;

import bean.CGenUtil;
import bean.ClassMAPTable;
import utilitaire.UtilDB;

public class Coordonnee_arrondissement extends ClassMAPTable{
    private String id;
    private double longitude;
    private double latitude;
    private String arrondissement_id;

    public Coordonnee_arrondissement() {
        super.setNomTable("coordonnee_arrondissement");
    }

    public Coordonnee_arrondissement(String id, double longitude, double latitude, String arrondissement_id) {
        this.id = id;
        this.longitude = longitude;
        this.latitude = latitude;
        this.arrondissement_id = arrondissement_id;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public double getLongitude() {
        return longitude;
    }

    public void setLongitude(double longitude) {
        this.longitude = longitude;
    }

    public double getLatitude() {
        return latitude;
    }

    public void setLatitude(double latitude) {
        this.latitude = latitude;
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
        String[] motCles={"id","longitude","latitude","arrondissement_id"};
        return motCles;
    }

    public Coordonnee_arrondissement[] getAllCoordonnee_arrondissements() throws Exception {
        Connection c = null;
        try {
            c = new UtilDB().GetConn();
            Coordonnee_arrondissement coordonnee_arrondissement = new Coordonnee_arrondissement();
            
            Coordonnee_arrondissement[] resultats = (Coordonnee_arrondissement[]) CGenUtil.rechercher(coordonnee_arrondissement, null, null, c, "");
            
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
