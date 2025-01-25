package entite;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import bean.ClassMAPTable;
import utilitaire.UtilDB;

public class Arrondissement extends ClassMAPTable{
    private String id;
    private String nom;
    
    
    public Arrondissement() {
        super.setNomTable("arrondissement");
    }
    public Arrondissement(String id, String nom) {
        this.id = id;
        this.nom = nom;
        
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

    public String getArrondissementByCoordinates(double latitude, double longitude) throws SQLException {
        Connection c = null;
        String arrondissementId = null;
        
        try {
            c = new UtilDB().GetConn();
            String sql = "SELECT get_arrondissement(?, ?) AS arrondissement_id FROM DUAL";
            
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setDouble(1, latitude);
                ps.setDouble(2, longitude);
                
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        arrondissementId = rs.getString("arrondissement_id");
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (c != null) {
                try {
                    c.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return arrondissementId;
    }
}
