QST1


CREATE PROCEDURE InsertStagiaire(
      p_Nom VARCHAR(50),
      p_Prenom VARCHAR(50),
      p_Datenaiss DATE,
      p_Dateinscri DATE,
      p_Adresse VARCHAR(255),
      p_Tel VARCHAR(15),
      p_Nfiliere INT
)
BEGIN
    INSERT INTO Stagiaire (Nom, Prénom, datenaiss, dateinscri, Adresse, tel, Nfilière)
    VALUES (p_Nom, p_Prenom, p_Datenaiss, p_Dateinscri, p_Adresse, p_Tel, p_Nfiliere);
END;


*******
QST2

CREATE PROCEDURE UpdateNotes()
BEGIN
    DECLARE minNote INT;
    
     
    SELECT MIN(note) INTO minNote FROM Notation WHERE note IS NOT NULL AND note > 0;
    
     
    UPDATE Notation
    SET note = minNote
    WHERE note IS NULL OR note = 0;
END;



********
QST3


CREATE FUNCTION NombreFilieres(p_Nfiliere INT) 
RETURNS INT
BEGIN
    DECLARE nbFilieres INT;
    SELECT COUNT(*) INTO nbFilieres FROM Filière WHERE Nfilière = p_Nfiliere;
    RETURN nbFilieres;
END;



**********
QST4


CREATE FUNCTION InsertStagiaireReturnID(
    p_Nom VARCHAR(50), 
    p_Prenom VARCHAR(50), 
    p_Datenaiss DATE,
    p_Dateinscri DATE,
    p_Adresse VARCHAR(255),
    p_Tel VARCHAR(15), 
    p_Nfiliere INT
) RETURNS INT
BEGIN
    INSERT INTO Stagiaire (Nom, Prénom, datenaiss, dateinscri, Adresse, tel, Nfilière)
    VALUES (p_Nom, p_Prenom, p_Datenaiss, p_Dateinscri, p_Adresse, p_Tel, p_Nfiliere);
    
    RETURN LAST_INSERT_ID();
END;





********
QST5



CREATE PROCEDURE ListStagiairesFiliere(  p_Nfiliere INT)
BEGIN
    SELECT * FROM Stagiaire WHERE Nfilière = p_Nfiliere;
END;


*************

QST6


CREATE PROCEDURE ListStagiairesTrancheAge(  p_AgeMin INT,   p_AgeMax INT)
BEGIN
    SELECT * FROM Stagiaire
    WHERE TIMESTAMPDIFF(YEAR, datenaiss, CURDATE()) BETWEEN p_AgeMin AND p_AgeMax;
END;
*****************
QST7




CREATE PROCEDURE AugmenterNotesMetierFormation()
BEGIN
    UPDATE Notation
    SET note = note + 1
    WHERE N°module IN (SELECT N°module FROM Module WHERE intitulémod = 'métier et formation');
END;





**********
QST8


CREATE PROCEDURE ListStagiairesLettre(IN p_Lettre CHAR(1))
BEGIN
    SELECT * FROM Stagiaire
    WHERE Nom LIKE CONCAT(p_Lettre, '%');
END;



*************
QST9

CREATE PROCEDURE BulletinStagiaire(  p_Nstagiaire INT)
BEGIN
    SELECT s.Nom, s.Prénom, m.intitulémod, n.note
    FROM Notation n
    JOIN Stagiaire s ON s.Nºstagiaire = n.N°Stagaire
    JOIN Module m ON m.N°module = n.N°module
    WHERE s.Nºstagiaire = p_Nstagiaire;
END;




************
QST10

CREATE PROCEDURE ListStagiairesDates(p_DateDebut DATE,  p_DateFin DATE)
BEGIN
    SELECT * FROM Stagiaire
    WHERE dateinscri BETWEEN p_DateDebut AND p_DateFin;
END;
