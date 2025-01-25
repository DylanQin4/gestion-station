CREATE OR REPLACE VIEW v_calcul_montant_impot AS
SELECT 
    m.id AS maison_id,
    i.id AS impot_id,
    (
        m.longeur * m.largeur * m.nb_etage * i.impot_metre_carre * 
        COALESCE(
            (SELECT EXP(SUM(LN(c.coefficient))) 
             FROM caracteristique_maison cm
             JOIN caracteristique c ON c.id = cm.caracteristique_id
             WHERE cm.maison_id = m.id), 
            1
        )
    ) AS montant_total
FROM 
    maison m
    JOIN impot i ON i.arrondissement_id = m.arrondissement_id;



CREATE OR REPLACE VIEW v_paiement_status AS
SELECT 
    m.id AS maison_id,
    i.id AS impot_id,
    vci.montant_total,
    COALESCE(SUM(pi.montant_payer), 0) AS montant_paye,
    vci.montant_total - COALESCE(SUM(pi.montant_payer), 0) AS reste_a_payer,
    pi.date_paiement
FROM 
    maison m
    JOIN v_calcul_montant_impot vci ON vci.maison_id = m.id
    JOIN impot i ON i.id = vci.impot_id
    LEFT JOIN paiement_impot pi ON pi.maison_id = m.id AND pi.impot_id = i.id
GROUP BY 
    m.id, 
    i.id, 
    vci.montant_total,
    pi.date_paiement;


CREATE OR REPLACE VIEW v_situation_impots AS
SELECT 
    m.*,
    v.impot_id,
    v.montant_total,
    v.montant_paye,
    v.reste_a_payer,
    v.date_paiement 
FROM 
    maison m
    JOIN v_paiement_status v ON v.maison_id = m.id
ORDER BY 
    m.id, 
    v.impot_id,
    v.date_paiement;

-- dette d impot par maison 


CREATE OR REPLACE VIEW v_arrondissement_fiche AS
SELECT 
    a.id AS id,
    a.nom AS nom,
    COUNT(DISTINCT m.id) AS nombre_maisons,
    COALESCE(SUM(pi.montant_payer), 0) AS total_montant_paye,
    COALESCE(SUM(vci.montant_total), 0) AS total_montant_du,
    COALESCE(SUM(vci.montant_total - COALESCE(pi.montant_payer, 0)), 0) AS total_reste_a_payer,
    pi.date_paiement
FROM 
    arrondissement a
    LEFT JOIN maison m ON m.arrondissement_id = a.id
    LEFT JOIN v_calcul_montant_impot vci ON vci.maison_id = m.id
    LEFT JOIN paiement_impot pi ON pi.maison_id = m.id AND pi.impot_id = vci.impot_id
GROUP BY 
    a.id, 
    a.nom,
    pi.date_paiement
ORDER BY 
    a.id,
    pi.date_paiement;


CREATE OR REPLACE VIEW v_get_impot_id AS
SELECT 
m.id AS maison_id,
i.id AS impot_id
FROM maison m
JOIN impot i ON m.arrondissement_id = i.arrondissement_id;



CREATE OR REPLACE FUNCTION get_arrondissement(
    p_latitude IN NUMBER,
    p_longitude IN NUMBER
) RETURN VARCHAR2 IS
    TYPE t_coords IS TABLE OF coordonnee_arrondissement%ROWTYPE;
    v_coords t_coords;
    v_intersections NUMBER;
    v_x1 NUMBER;
    v_y1 NUMBER;
    v_x2 NUMBER;
    v_y2 NUMBER;
    v_libelle VARCHAR2(50);
BEGIN
    -- Récupérer tous les arrondissements distincts
    FOR arr IN (SELECT DISTINCT arrondissement_id FROM coordonnee_arrondissement) LOOP
        -- Récupérer les coordonnées pour cet arrondissement
        SELECT *
        BULK COLLECT INTO v_coords
        FROM coordonnee_arrondissement
        WHERE arrondissement_id = arr.arrondissement_id
        ORDER BY id;

        -- Initialiser le compteur d'intersections
        v_intersections := 0;

        -- Vérifier chaque segment du polygone
        FOR i IN 1..v_coords.COUNT LOOP
            v_x1 := v_coords(i).longitude;
            v_y1 := v_coords(i).latitude;
            
            IF i = v_coords.COUNT THEN
                v_x2 := v_coords(1).longitude;
                v_y2 := v_coords(1).latitude;
            ELSE
                v_x2 := v_coords(i + 1).longitude;
                v_y2 := v_coords(i + 1).latitude;
            END IF;

            -- Algorithme ray-casting
            IF ((v_y1 > p_latitude) != (v_y2 > p_latitude)) AND
               (p_longitude < (v_x2 - v_x1) * (p_latitude - v_y1) / (v_y2 - v_y1) + v_x1) THEN
                v_intersections := v_intersections + 1;
            END IF;
        END LOOP;

        -- Si nombre impair d'intersections, le point est dans le polygone
        IF MOD(v_intersections, 2) = 1 THEN
            RETURN arr.arrondissement_id;
        END IF;
    END LOOP;

    -- Si aucun arrondissement n'est trouvé
    RETURN 'Aucun arrondissement trouvé';
END get_arrondissement;
/