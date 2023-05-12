USE tsw_prog;

/*BRAND*/
insert into BRAND(id, nome, percorso_logo) 
values (1, "Ferrari",'logo1'),
(2, "Mercedes",'logo2') ,
(3, "BMW",'logo3'),
(4, "Alpina",'logo4'),
(5, "Alfa Romeo",'logo5'),
(6, "Tesla",'logo6');

/*PRODOTTI*/
insert into PRODOTTI(id, nome, tipo, descrizione, data_rilascio, prezzo,id_brand) 
values ('1', 'A110', 'macchina', '1102 kg - 1140 kg Peso a vuoto, 4,5 s Accelerazione da 0 a 100 km/h,
250 km/h Velocità massima su circuito,252 cv.L&#8217;A110 è la porta d&#8217;accesso al mondo Alpine. Leggera, precisa, briosa, l&#8217;A110 dimostra agilità e dinamicità in ogni circostanza.',  '1977',  '62.882,90','4'),

('2', 'Roma', 'macchina', 'Lunga 466 cm, larga 197 e alta 130, la Ferrari Roma ha linee frutto del lavoro svolto dal Centro Stile Ferrari coordinato da Flavio Manzoni. Ha forme fluide e moderne, capaci di intrecciare gli stilemi delle coupé dell epopea Rossa.',
'2019',  '217.100','1'),

('3', 'SL', 'macchina', 'L&#8217;altezza è quella tipica di una cabrio/coupè e arriva a 1.5 metri. Il passo di 2.7 metri, invece, permette di poter contare anche su due piccoli posti posteriori. Il bagagliaio, infine, ha una capacità che va dai 213 ai 240 litri a seconda della posizione del tetto.',  '1954',  '138.930','2'),

('4', 'Portachiave', 'accessorio', 'Portachiave con logo bmw',  '2010',  '18,99','3'),

('5', 'Cappuccio BMW', 'accessorio', 'Cappuccio per ruote brandizzato BMW',  '2023',  '25,99','3'),

('6', 'F8 Spider', 'macchina', 'Nella versione F8 Spider con motore a benzina di 3902 cc (Euro 6) capace di erogare una potenza massima di 530 kW/720 CV ed una coppia massima di 770 Nm a 3250 giri/min. La trazione è posteriore. Il serbatoio ha una capienza di 78 litri. L&#8217;accelerazione da 0 a 100 km/h avviene in 2.9 secondi.',  '2019',  '21.500','1');

/*MEDIA*/
insert into MEDIA(percorso, id_prodotto)
values ('imgs/prodotti/a110.jpg', '1'),
('imgs/prodotti/roma.jpg', '2'),
('imgs/prodotti/sl.jpg', '3'),
('imgs/prodotti/bmw_portachiave.jpg', '4'),
('imgs/prodotti/cappuccio_bmw.jpg', '5'),
('imgs/prodotti/f8.jpg', '6');

/*COLORI*/
insert into COLORI(id, nome)
values (1, 'nero'), 
(2, 'blu'), 
(3, 'giallo'),
(4, 'rosa'), 
(5, 'rosso'), 
(6, 'bianco');

/*RUOTE*/
insert into RUOTE(id, tipo)
values (1, 'carbonio'), 
(2, 'magnesio'), 
(3, 'alluminio'), 
(4, 'ghisa'), 
(5, 'oro');

/*INTERNI*/
insert into INTERNI(id, tipo)
values (1,'pelle'),
(2,'riscaldati');

/*UTENTI*/
insert into UTENTI(email, psw, nome, cognome, telefono, cap, via, n_civ, numero_carta, data_scadenza_carta, cvv_carta)
values ('admin@fgms.it', '123staila', 'Ambrogio', 'De Girolamo', '3332221111', '84016', 'Via Sant Eustacchio, PEGANI', '71', NULL, NULL, NULL);

/*ACQUISTI*/
insert into ACQUISTI(data_acquisto,tracciabilita,ruote,interni,colore,id_prodotto,email_utenti)
values ('2023/06/07', '001','oro','pelle','blu','1','admin@fgms.it'),
('2023/06/10', '002','carbonio','pelle','nero','2','admin@fgms.it');

/*PERSONALIZZAZIONE RUOTE*/
insert into PERSONALIZZAZIONE_RUOTE(id_prodotto, id_ruote)
values ('1', '5'),
 ('2', '1'),
 ('3', '3'),
 ('4', '1'),
 ('5','4'),
 ('6','2');

/*PERSONALIZZAZIONE INTERNI*/
insert into PERSONALIZZAZIONE_INTERNI(id_prodotto, id_interni)
values ('1', '1'),
 ('2', '1'),
 ('3', '2'),
 ('4', '1'),
 ('5','2'),
 ('6','2');

/*PERSONALIZZAZIONE COLORE*/
insert into PERSONALIZZAZIONE_COLORE(id_prodotto, id_colori)
values ('1', '2'),
 ('2', '1'),
 ('3', '3'),
 ('4', '5'),
 ('5','6'),
 ('6','4');

