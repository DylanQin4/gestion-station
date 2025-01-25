-- Insertion des arrondissements (les id sont générés automatiquement)
INSERT INTO arrondissement (libelle) VALUES
('1er arrondissement'),
('2ème arrondissement');


-- Insertion des coordonnées pour le 1er arrondissement
INSERT INTO coordonnee_arrondissement (longitude, latitude, id_arrondissement) VALUES
(2.33, 48.86, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '1er arrondissement')),
(2.34, 48.87, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '1er arrondissement')),
(2.35, 48.88, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '1er arrondissement'));

-- Insertion des coordonnées pour le 2ème arrondissement
INSERT INTO coordonnee_arrondissement (longitude, latitude, id_arrondissement) VALUES
(2.36, 48.89, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '2ème arrondissement')),
(2.37, 48.90, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '2ème arrondissement')),
(2.38, 48.91, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '2ème arrondissement'));

-- Insertion des types (les id sont générés automatiquement)
INSERT INTO typa (libelle) VALUES
('mur'),
('toit');



-- Insertion des caractéristiques (les id sont générés automatiquement)
INSERT INTO caracteristique (libelle, coefficient, id_typa) VALUES
-- Caractéristiques des murs
('Mur en brique', 1.2, (SELECT id_typa FROM typa WHERE libelle = 'mur')),
('Mur en pierre', 1.4, (SELECT id_typa FROM typa WHERE libelle = 'mur')),
('Mur en béton', 1.0, (SELECT id_typa FROM typa WHERE libelle = 'mur')),
-- Caractéristiques des toits
('Toit en ardoise', 1.3, (SELECT id_typa FROM typa WHERE libelle = 'toit')),
('Toit en tuile', 1.1, (SELECT id_typa FROM typa WHERE libelle = 'toit'));


-- Insertion des maisons (les id sont générés automatiquement)
INSERT INTO maison (nb_etage, longueur, largeur, latitude, longitude, id_arrondissement) VALUES
-- Maisons du 1er arrondissement
(3, 15.5, 10.2, 48.86123, 2.33234, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '1er arrondissement')),
(2, 12.3, 8.7, 48.86234, 2.33345, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '1er arrondissement')),
(4, 18.2, 12.5, 48.86345, 2.33456, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '1er arrondissement')),
(3, 14.8, 9.6, 48.86456, 2.33567, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '1er arrondissement')),
(2, 11.5, 7.8, 48.86567, 2.33678, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '1er arrondissement')),
-- Maisons du 2ème arrondissement
(3, 16.4, 11.3, 48.87123, 2.34234, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '2ème arrondissement')),
(4, 19.2, 13.5, 48.87234, 2.34345, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '2ème arrondissement')),
(2, 13.7, 9.2, 48.87345, 2.34456, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '2ème arrondissement')),
(3, 15.8, 10.6, 48.87456, 2.34567, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '2ème arrondissement')),
(4, 17.9, 12.8, 48.87567, 2.34678, (SELECT id_arrondissement FROM arrondissement WHERE libelle = '2ème arrondissement'));


-- Insertion des impôts (les id sont générés automatiquement)
INSERT INTO impot (impot_metre_carre, date_changement, id_arrondissement) VALUES
(25.50, TO_DATE('2022-01-01', 'YYYY-MM-DD'), (SELECT id_arrondissement FROM arrondissement WHERE libelle = '1er arrondissement')),
(28.75, TO_DATE('2022-01-01', 'YYYY-MM-DD'), (SELECT id_arrondissement FROM arrondissement WHERE libelle = '2ème arrondissement'));


-- Association des caractéristiques aux maisons (les id sont générés automatiquement)
INSERT INTO caracteristique_maison (id_maison, id_caracteristique) VALUES
((SELECT id_maison FROM maison WHERE id_maison = 'MSN00001'), (SELECT id_caracteristique FROM caracteristique WHERE libelle = 'Mur en brique')),
((SELECT id_maison FROM maison WHERE id_maison = 'MSN00001'), (SELECT id_caracteristique FROM caracteristique WHERE libelle = 'Toit en ardoise')),
-- Répétez pour les autres associations...


-- Insertion des paiements d'impôts (les id sont générés automatiquement)
INSERT INTO paiement_impot (date_paiement, montant_payer, id_maison, id_impot) VALUES
(TO_DATE('2025-01-15', 'YYYY-MM-DD'), 1250.75, (SELECT id_maison FROM maison WHERE id_maison = 'MSN00001'), (SELECT id_impot FROM impot WHERE id_impot = 'IMP00001')),
-- Répétez pour les autres paiements...