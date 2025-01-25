package entite;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import bean.CGenUtil;
import utilitaire.UtilDB;

public class ImpotLib extends Impot{
    private String maison_id;
    private String impot_id;

    
    public ImpotLib(){
        super.setNomTable("v_get_impot_id");
    }

    public ImpotLib getIdImpotMaison(String id) throws Exception {
        Connection c = null;
        ImpotLib impotLib = null; // Déclaration en dehors du bloc try pour être accessible à l'extérieur.
        
        try {
            c = new UtilDB().GetConn();
            String sql = "SELECT * FROM v_get_impot_id WHERE maison_id = ?";
            
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setString(1, id);
                
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        impotLib = new ImpotLib();
                        impotLib.setImpot_id(rs.getString("impot_id"));
                        impotLib.setMaison_id(rs.getString("maison_id"));
                    }
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } finally {
            if (c != null) {
                try {
                    c.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        
        return impotLib;
    }


    public double getResteAPayer(String idMaison, String dateInput) throws SQLException {
        Connection c = null;
        double resteAPayer = 0.0;
    
        try {
            c = new UtilDB().GetConn();
            String sql = "SELECT reste_a_payer FROM v_situation_impots " +
                         "WHERE id = ? AND (date_paiement IS NULL OR date_paiement <= TO_DATE(?, 'DD/MM/YYYY'))";
    
            try (PreparedStatement ps = c.prepareStatement(sql)) {
                ps.setString(1, idMaison);
                ps.setString(2, dateInput);
    
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        resteAPayer = rs.getDouble("reste_a_payer");
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
    
        return resteAPayer;
    }
    


    public String getImpot_id() {
        return impot_id;
    }

    public void setImpot_id(String impot_id) {
        
        this.impot_id = impot_id;
        
    }

    public String getMaison_id() {
        return maison_id;
    }

    public void setMaison_id(String maison_id) {
        this.maison_id = maison_id;
    }

    
}
