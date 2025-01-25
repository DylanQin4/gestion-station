INSERT INTO typa (nom) VALUES ('mur');
INSERT INTO typa (nom) VALUES ('toit');

INSERT INTO caracteristique (nom, coefficient, typa_id) 
VALUES ('Mur en brique', 1.2, (SELECT id FROM typa WHERE nom = 'mur'));
INSERT INTO caracteristique (nom, coefficient, typa_id) 
VALUES ('Mur en pierre', 1.4, (SELECT id FROM typa WHERE nom = 'mur'));
INSERT INTO caracteristique (nom, coefficient, typa_id) 
VALUES ('Mur en béton', 1.0, (SELECT id FROM typa WHERE nom = 'mur'));
INSERT INTO caracteristique (nom, coefficient, typa_id) 
VALUES ('Toit en ardoise', 1.3, (SELECT id FROM typa WHERE nom = 'toit'));
INSERT INTO caracteristique (nom, coefficient, typa_id) 
VALUES ('Toit en tuile', 1.1, (SELECT id FROM typa WHERE nom = 'toit'));

INSERT INTO caracteristique_maison (maison_id, caracteristique_id) 
VALUES ('MSN00063', (SELECT id FROM caracteristique WHERE nom = 'Mur en brique'));
INSERT INTO caracteristique_maison (maison_id, caracteristique_id) 
VALUES ('MSN00063', (SELECT id FROM caracteristique WHERE nom = 'Toit en ardoise'));


INSERT INTO arrondissement (nom) VALUES ('Centre-ville');
INSERT INTO arrondissement (nom) VALUES ('Nord');
INSERT INTO arrondissement (nom) VALUES ('Sud');
INSERT INTO arrondissement (nom) VALUES ('Est');
INSERT INTO arrondissement (nom) VALUES ('Ouest');

INSERT INTO impot (impot_metre_carre, date_changement, arrondissement_id) 
VALUES (25.50, TO_DATE('2022-01-01', 'YYYY-MM-DD'), (SELECT id FROM arrondissement WHERE nom = 'Centre-ville'));
INSERT INTO impot (impot_metre_carre, date_changement, arrondissement_id) 
VALUES (28.75, TO_DATE('2022-01-01', 'YYYY-MM-DD'), (SELECT id FROM arrondissement WHERE nom = 'Nord'));
    