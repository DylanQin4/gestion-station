-- Séquence et trigger pour typa
CREATE SEQUENCE seq_typa START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_typa_id
BEFORE INSERT ON typa
FOR EACH ROW
BEGIN
    SELECT 'TYP'||LPAD(seq_typa.NEXTVAL, 5, '0')
    INTO :NEW.id
    FROM dual;
END;
/

-- Séquence et trigger pour arrondissement
CREATE SEQUENCE seq_arrondissement START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_arrondissement_id
BEFORE INSERT ON arrondissement
FOR EACH ROW
BEGIN
    SELECT 'ARR'||LPAD(seq_arrondissement.NEXTVAL, 5, '0')
    INTO :NEW.id
    FROM dual;
END;
/

-- Séquence et trigger pour coordonnee_arrondissement
CREATE SEQUENCE seq_coord_arr START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_coord_arr_id
BEFORE INSERT ON coordonnee_arrondissement
FOR EACH ROW
BEGIN
    SELECT 'CRD'||LPAD(seq_coord_arr.NEXTVAL, 5, '0')
    INTO :NEW.id
    FROM dual;
END;
/

-- Séquence et trigger pour maison
CREATE SEQUENCE seq_maison START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_maison_id
BEFORE INSERT ON maison
FOR EACH ROW
BEGIN
    SELECT 'MSN'||LPAD(seq_maison.NEXTVAL, 5, '0')
    INTO :NEW.id
    FROM dual;
END;
/

-- Séquence et trigger pour caracteristique
CREATE SEQUENCE seq_caracteristique START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_caracteristique_id
BEFORE INSERT ON caracteristique
FOR EACH ROW
BEGIN
    SELECT 'CAR'||LPAD(seq_caracteristique.NEXTVAL, 5, '0')
    INTO :NEW.id
    FROM dual;
END;
/

-- Séquence et trigger pour impot
CREATE SEQUENCE seq_impot START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_impot_id
BEFORE INSERT ON impot
FOR EACH ROW
BEGIN
    SELECT 'IMP'||LPAD(seq_impot.NEXTVAL, 5, '0')
    INTO :NEW.id
    FROM dual;
END;
/

-- Séquence et trigger pour paiement_impot
CREATE SEQUENCE seq_paiement_impot START WITH 1 INCREMENT BY 1;

CREATE OR REPLACE TRIGGER trg_paiement_impot_id
BEFORE INSERT ON paiement_impot
FOR EACH ROW
BEGIN
    SELECT 'PAI'||LPAD(seq_paiement_impot.NEXTVAL, 5, '0')
    INTO :NEW.id
    FROM dual;
END;
/
