drop database tsw_prog;
create database tsw_prog; 
USE tsw_prog;

CREATE TABLE PRODOTTI(
	id INT PRIMARY KEY,
    nome VARCHAR(15) NOT NULL,
    tipo ENUM('macchina','accessorio') NOT NULL,
    descrizione VARCHAR(500),
    data_rilascio VARCHAR(4),
    prezzo VARCHAR(15) NOT NULL,
	id_brand INT NOT NULL REFERENCES BRAND(id)
    ON UPDATE CASCADE ON DELETE CASCADE
); 

CREATE TABLE MEDIA(
	 percorso VARCHAR(100) PRIMARY KEY,
     id_prodotto INT NOT NULL REFERENCES PRODOTTI(id)
     ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE COLORI(
	 id int PRIMARY KEY,
     nome VARCHAR(15) NOT NULL
);

CREATE TABLE RUOTE(
	 id int PRIMARY KEY,
     tipo VARCHAR(15) NOT NULL
);

CREATE TABLE INTERNI (
    id INT PRIMARY KEY,
    tipo VARCHAR(15) NOT NULL
);

CREATE TABLE BRAND (
    id INT PRIMARY KEY,
    nome VARCHAR(15) NOT NULL,
    percorso_logo VARCHAR(100) NOT NULL
);

CREATE TABLE UTENTI (
    email VARCHAR(50) PRIMARY KEY,
	psw VARCHAR(25) NOT NULL,
    nome VARCHAR(15) NOT NULL,
    cognome VARCHAR(15) NOT NULL,
    telefono CHAR(12) NOT NULL,
	provincia VARCHAR(15),
    citta VARCHAR(30),
    cap CHAR(5), 
    via VARCHAR(50),
    n_civ VARCHAR(3),
    
    numero_carta CHAR(16),
    data_scadenza_carta CHAR(5),
    cvv_carta CHAR(3)
);

CREATE TABLE ACQUISTI (
	data_acquisto DATE NOT NULL,
    tracciabilita VARCHAR(10),
    ruote VARCHAR(10),
    interni VARCHAR(10),
    colore VARCHAR(10),
    id_prodotto INT NOT NULL REFERENCES PRODOTTI (id)
    ON UPDATE CASCADE ON DELETE CASCADE,
	email_utenti VARCHAR(20) NOT NULL REFERENCES UTENTI(email)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE PERSONALIZZAZIONE_RUOTE (
    id_prodotto INT NOT NULL REFERENCES PRODOTTI (id)
    ON UPDATE CASCADE ON DELETE CASCADE,
	id_ruote VARCHAR(20) NOT NULL REFERENCES RUOTE(id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE PERSONALIZZAZIONE_INTERNI (
    id_prodotto INT NOT NULL REFERENCES PRODOTTI (id)
    ON UPDATE CASCADE ON DELETE CASCADE,
	id_interni VARCHAR(20) NOT NULL REFERENCES INTERNI(id)
    ON UPDATE CASCADE ON DELETE CASCADE
);

CREATE TABLE PERSONALIZZAZIONE_COLORE(
    id_prodotto INT NOT NULL REFERENCES PRODOTTI (id)
    ON UPDATE CASCADE ON DELETE CASCADE,
	id_colori VARCHAR(20) NOT NULL REFERENCES COLORI(id)
    ON UPDATE CASCADE ON DELETE CASCADE
);


insert into BRAND(id, nome, percorso_logo) 
values (1, "Ferrari",'logo1'),
(2, "Mercedes",'logo2') ,
(3, "BMW",'logo3'),
(4, "Alpina",'logo4'),
(5, "Alfa Romeo",'logo5'),
(6, "Tesla",'logo6');


insert into PRODOTTI(id, nome, tipo, descrizione, data_rilascio, prezzo,id_brand) 
values ('1', 'A110', 'macchina', '1102 kg - 1140 kg Peso a vuoto, 4,5 s Accelerazione da 0 a 100 km/h,
250 km/h Velocità massima su circuito,252 cv.L&#8217;A110 è la porta d&#8217;accesso al mondo Alpine. Leggera, precisa, briosa, l&#8217;A110 dimostra agilità e dinamicità in ogni circostanza.',  '1977',  '62.882,90','4'),

('2', 'Roma', 'macchina', 'Lunga 466 cm, larga 197 e alta 130, la Ferrari Roma ha linee frutto del lavoro svolto dal Centro Stile Ferrari coordinato da Flavio Manzoni. Ha forme fluide e moderne, capaci di intrecciare gli stilemi delle coupé dell epopea Rossa.',
'2019',  '217.100','1'),

('3', 'SL', 'macchina', 'L&#8217;altezza è quella tipica di una cabrio/coupè e arriva a 1.5 metri. Il passo di 2.7 metri, invece, permette di poter contare anche su due piccoli posti posteriori. Il bagagliaio, infine, ha una capacità che va dai 213 ai 240 litri a seconda della posizione del tetto.',  '1954',  '138.930','2'),

('4', 'Portachiave', 'accessorio', 'Portachiave con logo bmw',  '2010',  '18,99','3'),

('5', 'Cappuccio BMW', 'accessorio', 'Cappuccio per ruote brandizzato BMW',  '2023',  '25,99','3'),

('6', 'F8 Spider', 'macchina', 'Nella versione F8 Spider con motore a benzina di 3902 cc (Euro 6) capace di erogare una potenza massima di 530 kW/720 CV ed una coppia massima di 770 Nm a 3250 giri/min. La trazione è posteriore. Il serbatoio ha una capienza di 78 litri. L&#8217;accelerazione da 0 a 100 km/h avviene in 2.9 secondi.',  '2019',  '21.500','1');

insert into MEDIA(percorso, id_prodotto)
values ('imgs/prodotti/a110.jpg', '1'),
('imgs/prodotti/roma.jpg', '2'),
('imgs/prodotti/sl.jpg', '3'),
('imgs/prodotti/bmw_portachiave.jpg', '4'),
('imgs/prodotti/cappuccio_bmw.jpg', '5'),
('imgs/prodotti/f8.jpg', '6');


insert into COLORI(id, nome)
values (1, 'nero'), 
(2, 'blu'), 
(3, 'giallo'),
(4, 'rosa'), 
(5, 'rosso'), 
(6, 'bianco');

insert into RUOTE(id, tipo)
values (1, 'carbonio'), 
(2, 'magnesio'), 
(3, 'alluminio'), 
(4, 'ghisa'), 
(5, 'oro');

insert into INTERNI(id, tipo)
values (1,'pelle'),
(2,'riscaldati');

insert into UTENTI(email, psw, nome, cognome, telefono, cap, via, n_civ, numero_carta, data_scadenza_carta, cvv_carta)
values ('admin@fgms.it', '123staila', 'Ambrogio', 'De Girolamo', '3332221111', '84016', 'Via Sant Eustacchio, PEGANI', '71', NULL, NULL, NULL);

insert into ACQUISTI(data_acquisto,tracciabilita,ruote,interni,colore,id_prodotto,email_utenti)
values ('2023-06-07', '001','oro','pelle','blu','1','admin@fgms.it'),
('2023-06-10', '002','carbonio','pelle','nero','2','admin@fgms.it');

insert into PERSONALIZZAZIONE_RUOTE(id_prodotto, id_ruote)
values ('1', '5'),
 ('2', '1'),
 ('3', '3'),
 ('4', '1'),
 ('5','4'),
 ('6','2');

insert into PERSONALIZZAZIONE_INTERNI(id_prodotto, id_interni)
values ('1', '1'),
 ('2', '1'),
 ('3', '2'),
 ('4', '1'),
 ('5','2'),
 ('6','2');

insert into PERSONALIZZAZIONE_COLORE(id_prodotto, id_colori)
values ('1', '2'),
 ('2', '1'),
 ('3', '3'),
 ('4', '5'),
 ('5','6'),
 ('6','4');