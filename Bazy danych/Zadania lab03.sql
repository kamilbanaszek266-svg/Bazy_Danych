Create table pracownik (
id_pracownika int auto_increment primary key,
imie varchar(40) not null,
nazwisko varchar(60) not null,
data_urodzenia DATE not null 
);

INSERT INTO pracownik (imie, nazwisko, data_urodzenia)
VALUES 
	('Jan', 'Kowalski', '1989-01-22'),
    ('Frank', 'Nowak', '1999-05-10'),
    ('Adam', 'Kopniak', '2000-12-05');

SELECT * FROM pracownik;

UPDATE pracownik
SET data_urodzenia = '2001-06-15'
WHERE id_pracownika = 2;

create table zadanie (
id_zadania int auto_increment primary key,
nazwa_zadania varchar(150) not null,
priorytet enum('normalny', 'wysoki', 'niski'),
opis longtext,
pracownik INT null, foreign key(pracownik) REFERENCES pracownik(id_pracownika) ON DELETE SET NULL
);

SELECT * FROM zadanie;

ALTER TABLE zadanie 
MODIFY priorytet ENUM('normalny', 'wysoki', 'niski') default ('normalny');

INSERT INTO zadanie (nazwa_zadania, priorytet, opis, pracownik) 
VALUES 	('Przygotowywanie raportu', 'wysoki', 'Wykonać raport jak w najszybszym czasie', 1),
		('Sprawdzanie wyników poprzednich raportów', default, 'Sprawdzić wyniki raportów', 2),
		('Wykonać różnicę między raportami świeżymi, a nowymi raportami', 'niski', 'Porównać różnicę', 3);
        
SELECT * FROM zadanie;

CREATE TABLE projekt (
	id_projektu int auto_increment primary key,
    nazwa_projektu VARCHAR(150),
    data_rozpoczęcia DATE not null,
    data_zakonczenia DATE
);

ALTER TABLE projekt ADD menedzer_projektu INT, ADD CONSTRAINT
FOREIGN KEY (menedzer_projektu) REFERENCES pracownik(id_pracownika);

SELECT * FROM projekt;

INSERT INTO projekt (nazwa_projektu, data_rozpoczęcia, data_zakonczenia, menedzer_projektu)
VALUES ('Aplikacja na telefon', '2026-10-29', null, 2),
('Ulepszenie systemu bezpieczeństwa', '2025-12-20', '2026-05-07', 1);

SELECT * FROM projekt;

ALTER TABLE zadanie ADD COLUMN projekt INT, ADD CONSTRAINT
FOREIGN KEY (projekt) REFERENCES projekt(id_projektu) ON DELETE CASCADE;

SELECT * FROM zadanie;

UPDATE zadanie SET projekt = 3 WHERE id_zadania = 3;

CREATE TABLE sprint (
id_sprintu INT auto_increment primary key,
numer_sprintu INT UNSIGNED,
data_rozpoczecia DATE,
data_zakończenia DATE
);
ALTER TABLE zadanie ADD COLUMN sprint INT, ADD FOREIGN KEY (sprint) references sprint(id_sprintu)  ON DELETE SET NULL;

select * FROM sprint;
SELECT * FROM zadanie;
INSERT INTO sprint (numer_sprintu, data_rozpoczecia, data_zakończenia) values
(1, '2000-05-10', '2000-05-20');

UPDATE zadanie set sprint = 1 WHERE id_zadania in (1,2);

SELECT * FROM status;
CREATE TABLE status (
id_statusu INT auto_increment primary key,
nazwa_statusu VARCHAR(20)
);

INSERT INTO status (nazwa_statusu) values
('status 1'),
('status 2'),
('status 3');

CREATE TABLE zadanie_has_status (
id_zdarzenia INT auto_increment primary key,
id_zadania INT null, foreign key(id_zadania) REFERENCES zadanie(id_zadania) ON DELETE SET NULL,
id_statusu INT null, foreign key(id_statusu) references status(id_statusu) ON DELETE SET NULL,
data_zdarzenia DATETIME DEFAULT current_timestamp
);

INSERT INTO zadanie_has_status (id_zdarzenia, id_zadania, id_statusu) VALUES
(1, 1 , 1),
(2, 2 , 2),
(3, 3, 3);
DELETE FROM zadanie_has_status WHERE id_zdarzenia = 3;
SELECT * FROM zadanie_has_status;

DELETE FROM projekt WHERE id_projektu = 1;
SELECT * from projekt;
SELECT * FROM zadanie;
ALTER TABLE zadanie drop foreign key zadanie_ibfk_3;
DROP TABLE sprint;