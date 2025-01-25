package entite;

import bean.ClassMAPTable;

public class Typa extends ClassMAPTable{
    private String id;
    private String libelle;
    
    
    public Typa() {
        super.setNomTable("typa");
    }
    public Typa(String id, String libelle) {
        this.id = id;
        this.libelle = libelle;
    }
    public String getId() {
        return id;
    }
    public void setId(String id) {
        this.id = id;
    }
    public String getLibelle() {
        return libelle;
    }
    public void setLibelle(String libelle) {
        this.libelle = libelle;
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
        String[] motCles={"id","libelle"};
        return motCles;
    }

}
