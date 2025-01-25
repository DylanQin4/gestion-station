CREATE TABLE typa(
   id VARCHAR2(50) ,
   nom VARCHAR2(50) ,
   PRIMARY KEY(id)
);

CREATE TABLE arrondissement(
   id VARCHAR2(50) ,
   nom VARCHAR2(50) ,
   PRIMARY KEY(id)
);

CREATE TABLE coordonnee_arrondissement(
   id VARCHAR2(50) ,
   longitude NUMBER(15,7),
   latitude NUMBER(15,7)   NOT NULL,
   arrondissement_id VARCHAR2(50)  NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(arrondissement_id) REFERENCES arrondissement(id)
);

CREATE TABLE maison(
   id VARCHAR2(50) ,
   nb_etage NUMBER(10) NOT NULL,
   longeur NUMBER(15,2)   NOT NULL,
   largeur NUMBER(15,2)   NOT NULL,
   latitude NUMBER(15,7)   NOT NULL,
   longitude NUMBER(15,7)   NOT NULL,
   arrondissement_id VARCHAR2(50)  NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(arrondissement_id) REFERENCES arrondissement(id)
);

CREATE TABLE caracteristique(
   id VARCHAR2(50) ,
   nom VARCHAR2(50) ,
   coefficient NUMBER(15,2)  ,
   typa_id VARCHAR2(50)  NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(typa_id) REFERENCES typa(id)
);

CREATE TABLE impot(
   id VARCHAR2(50) ,
   impot_metre_carre NUMBER(15,2)  ,
   date_changement DATE,
   arrondissement_id VARCHAR2(50)  NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(arrondissement_id) REFERENCES arrondissement(id)
);

CREATE TABLE paiement_impot(
   id VARCHAR2(50) ,
   date_paiement DATE,
   montant_payer NUMBER(15,2)   NOT NULL,
   maison_id VARCHAR2(50)  NOT NULL,
   impot_id VARCHAR2(50)  NOT NULL,
   PRIMARY KEY(id),
   FOREIGN KEY(maison_id) REFERENCES maison(id),
   FOREIGN KEY(impot_id) REFERENCES impot(id)
);

CREATE TABLE caracteristique_maison(
   maison_id VARCHAR2(50) ,
   caracteristique_id VARCHAR2(50) ,
   PRIMARY KEY(maison_id, caracteristique_id),
   FOREIGN KEY(maison_id) REFERENCES maison(id),
   FOREIGN KEY(caracteristique_id) REFERENCES caracteristique(id)
);
