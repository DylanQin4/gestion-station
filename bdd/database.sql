-- D'abord, supprimons les objets existants pour repartir proprement
DROP TRIGGER trg_score_id;
DROP SEQUENCE getSeqScore;
DROP TABLE score;

-- Création de la table avec les bons noms de colonnes
CREATE TABLE score (
   id VARCHAR2(50),
   score_equipe_blue NUMBER,
   score_equipe_rouge NUMBER,
   arret_gardient_blue NUMBER,
   arret_gardient_rouge NUMBER,
   CONSTRAINT pk_score PRIMARY KEY (id)
);


-- Création de la séquence
CREATE SEQUENCE getSeqScore START WITH 1 INCREMENT BY 1;

-- Création du trigger
CREATE OR REPLACE TRIGGER trg_score_id
BEFORE INSERT ON score
FOR EACH ROW
BEGIN
    :NEW.id := 'SCORE'||LPAD(getSeqScore.NEXTVAL, 5, '0');
END;
/

-- Et voici la bonne syntaxe pour l'insertion
INSERT INTO score (
    score_equipe_blue, 
    score_equipe_rouge, 
    arret_gardient_blue, 
    arret_gardient_rouge
) VALUES (
    1, 
    1, 
    3, 
    2
);