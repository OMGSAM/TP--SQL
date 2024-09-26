EXO1 §§§

    CREATE PROCEDURE ChangerIndicatifsTel()
    BEGIN
    UPDATE Employés
    SET Tel = CASE 
                WHEN Tel LIKE '05%' THEN CONCAT('03', SUBSTRING(Tel, 3))
                WHEN Tel LIKE '04%' THEN CONCAT('02', SUBSTRING(Tel, 3))
              END;
END;

***********

    CREATE PROCEDURE CalculerSalaireMoyen(IN CodeFonction INT)
    BEGIN
    SELECT AVG(Salaire) AS SalaireMoyen
    FROM Employés
    WHERE Fonction = CodeFonction;
END;

*************
EXO2§§§

CREATE VIEW FilmsLouesPlusDe10 AS
SELECT NumExemplaire, COUNT(*) AS NombreLocations
FROM Locations
GROUP BY NumExemplaire
HAVING COUNT(*) > 10;


**********



    CREATE PROCEDURE NewLocation(IN NumClient INT, IN NumExemplaire INT, IN DateLocation DATE)
    BEGIN
    INSERT INTO Locations (NumClient, NumExemplaire, DateLocation, DateRetour)
    VALUES (NumClient, NumExemplaire, DateLocation, NULL);
END;



**********
EXO3 §§§§§§§§§


CREATE FUNCTION EffectifClients() 
RETURNS INT
    BEGIN
    DECLARE NbClients INT;
    SELECT COUNT(*) INTO NbClients 
    FROM Clients 
    WHERE Ville = 'Oujda';
    RETURN NbClients;
END;


*************


CREATE PROCEDURE MAJ_Catégorie()
    BEGIN
    UPDATE Factures
    SET Catégorie = CASE
                     WHEN Montant > 100000 THEN 'Bon Client'
                     WHEN Montant <= 100000 THEN 'Moyen Client'
                    END;
END;
