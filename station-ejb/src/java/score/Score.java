package score;


import affichage.PageInsert;
import bean.ClassMAPTable;

public class Score extends ClassMAPTable{
    private String id;
    private int score_equipe_blue;
    private int score_equipe_rouge;
    private int arret_gardient_blue;
    private int arret_gardient_rouge;

    public Score() {
        super.setNomTable("score");
    }

    public Score(String id, int score_equipe_blue, int score_equipe_rouge, int arret_gardient_blue,
            int arret_gardient_rouge) {
        this.id = id;
        this.score_equipe_blue = score_equipe_blue;
        this.score_equipe_rouge = score_equipe_rouge;
        this.arret_gardient_blue = arret_gardient_blue;
        this.arret_gardient_rouge = arret_gardient_rouge;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getScore_equipe_blue() {
        return score_equipe_blue;
    }

    public void setScore_equipe_blue(int score_equipe_blue) {
        this.score_equipe_blue = score_equipe_blue;
    }

    public int getScore_equipe_rouge() {
        return score_equipe_rouge;
    }

    public void setScore_equipe_rouge(int score_equipe_rouge) {
        this.score_equipe_rouge = score_equipe_rouge;
    }

    public int getArret_gardient_blue() {
        return arret_gardient_blue;
    }

    public void setArret_gardient_blue(int arret_gardient_blue) {
        this.arret_gardient_blue = arret_gardient_blue;
    }

    public int getArret_gardient_rouge() {
        return arret_gardient_rouge;
    }

    public void setArret_gardient_rouge(int arret_gardient_rouge) {
        this.arret_gardient_rouge = arret_gardient_rouge;
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
        String[] motCles={"id","score_equipe_blue","score_equipe_rouge","arret_gardient_blue","arret_gardient_rouge"};
        return motCles;
    }
}
