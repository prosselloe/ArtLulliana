DROP TABLE IF EXISTS TblAlfabet;
CREATE TABLE TblAlfabet (
   Lletra VARCHAR(1),
   Ordre INTEGER,
PRIMARY KEY (Lletra)
);

INSERT INTO TblAlfabet VALUES ("B", 1);
INSERT INTO TblAlfabet VALUES ("C", 2);
INSERT INTO TblAlfabet VALUES ("D", 3);
INSERT INTO TblAlfabet VALUES ("E", 4);
INSERT INTO TblAlfabet VALUES ("F", 5);
INSERT INTO TblAlfabet VALUES ("G", 6);
INSERT INTO TblAlfabet VALUES ("H", 7);
INSERT INTO TblAlfabet VALUES ("I", 8);
INSERT INTO TblAlfabet VALUES ("K", 9);

DROP TABLE IF EXISTS TblTercera;
CREATE TABLE TblTercera (
   L1 VARCHAR(1),
   L2 VARCHAR(1),
   Columna INTEGER,
   Fila INTEGER,
   Cambra VARCHAR(2),
PRIMARY KEY (Cambra)
);

INSERT INTO TblTercera
SELECT 
   T1.Lletra AS L1, 
   T2.Lletra AS L2, 
   T1.Ordre AS Columna, 
   T2.Ordre - T1.Ordre AS Fila, 
   T1.Lletra || T2.Lletra AS Cambra 
FROM 
   TblAlfabet AS T1, 
   TblAlfabet AS T2
WHERE 
   T2.Lletra > T1.Lletra
ORDER BY T1.Lletra || T2.Lletra;

/* 
** TRANSFORM First(TblTercera.Cambra) AS PrimerDeCambra
** SELECT TblTercera.Fila
** FROM TblTercera
** GROUP BY TblTercera.Fila
** PIVOT TblTercera.Columna;
*/

SELECT TblTercera.Fila,
   MAX(CASE WHEN Columna = 1 THEN TblTercera.Cambra END) AS "1",
   MAX(CASE WHEN Columna = 2 THEN TblTercera.Cambra END) AS "2",
   MAX(CASE WHEN Columna = 3 THEN TblTercera.Cambra END) AS "3",
   MAX(CASE WHEN Columna = 4 THEN TblTercera.Cambra END) AS "4",
   MAX(CASE WHEN Columna = 5 THEN TblTercera.Cambra END) AS "5",
   MAX(CASE WHEN Columna = 6 THEN TblTercera.Cambra END) AS "6",
   MAX(CASE WHEN Columna = 7 THEN TblTercera.Cambra END) AS "7",
   MAX(CASE WHEN Columna = 8 THEN TblTercera.Cambra END) AS "8" 
FROM TblTercera
GROUP BY TblTercera.Fila
ORDER BY TblTercera.Fila;

DROP TABLE IF EXISTS TblAlfabetAmpliat;
CREATE TABLE TblAlfabetAmpliat (
   IdAlfabet VARCHAR(1),
   Ordre INTEGER,
   Lletra VARCHAR(1),
PRIMARY KEY (IdAlfabet)
);

INSERT INTO TblAlfabetAmpliat VALUES ("B", "1", "B");
INSERT INTO TblAlfabetAmpliat VALUES ("C", "2", "C");
INSERT INTO TblAlfabetAmpliat VALUES ("D", "3", "D");
INSERT INTO TblAlfabetAmpliat VALUES ("E", "4", "E");
INSERT INTO TblAlfabetAmpliat VALUES ("F", "5", "F");
INSERT INTO TblAlfabetAmpliat VALUES ("G", "6", "G");
INSERT INTO TblAlfabetAmpliat VALUES ("H", "7", "H");
INSERT INTO TblAlfabetAmpliat VALUES ("I", "8", "I");
INSERT INTO TblAlfabetAmpliat VALUES ("K", "9", "K");
INSERT INTO TblAlfabetAmpliat VALUES ("L", "10", "B");
INSERT INTO TblAlfabetAmpliat VALUES ("M", "11", "C");
INSERT INTO TblAlfabetAmpliat VALUES ("N", "12", "D");
INSERT INTO TblAlfabetAmpliat VALUES ("O", "13", "E");
INSERT INTO TblAlfabetAmpliat VALUES ("P", "14", "F");
INSERT INTO TblAlfabetAmpliat VALUES ("Q", "15", "G");
INSERT INTO TblAlfabetAmpliat VALUES ("R", "16", "H");
INSERT INTO TblAlfabetAmpliat VALUES ("U", "17", "I");
INSERT INTO TblAlfabetAmpliat VALUES ("W", "18", "K");

SELECT 
   T1.IdAlfabet AS L1, T2.IdAlfabet AS L2, T3.IdAlfabet AS L3, 
   IIf(T1.IdAlfabet>"K","t","") || T1.Lletra || 
   IIf(T2.IdAlfabet>"K" AND T1.IdAlfabet<"L","t","") || T2.Lletra || 
   IIf(T3.IdAlfabet>"K" AND T2.IdAlfabet<"L","t","") || T3.Lletra AS IdMultiplicacio, 
   T1.Ordre AS O1, T2.Ordre AS O2, T3.Ordre AS O3, 
   T1.Ordre || "." || T2.Ordre || "." || T3.Ordre AS Hash, 
   Length(T1.Ordre || "." || T2.Ordre || "." || T3.Ordre) AS Longitud,

   /* Cambres amb 84 multiplicacions vàlides 01,20 */ 
   IIf(Length(T1.Ordre || "." || T2.Ordre || "." || T3.Ordre)=5,"01",
   IIf(Length(T1.Ordre || "." || T2.Ordre || "." || T3.Ordre)=8,"20",

   /* Cambres amb 1 multiplicació vàlida 12,13,16,19 */ 
   IIf(T1.IdAlfabet ="I" AND T2.IdAlfabet ="K" AND T3.IdAlfabet ="U","12",
   IIf(T1.IdAlfabet ="I" AND T2.IdAlfabet ="K" AND T3.IdAlfabet ="W","13",
   IIf(T1.IdAlfabet ="I" AND T2.IdAlfabet ="U" AND T3.IdAlfabet ="W","16",
   IIf(T1.IdAlfabet ="K" AND T2.IdAlfabet ="U" AND T3.IdAlfabet ="W","19",

   /* Cambres amb 7 multiplicacions vàlides 05_,09_,07,18 
   IIf(T1.IdAlfabet>="B" AND T1.IdAlfabet<="H" AND 
       T2.IdAlfabet ="K" AND T3.IdAlfabet>="L" AND T3.IdAlfabet<="R","05",
   IIf(T1.IdAlfabet>="B" AND T1.IdAlfabet<="H" AND 
       T2.IdAlfabet>="L" AND T2.IdAlfabet<="R" AND T3.IdAlfabet ="W","09",
   */
   IIf(T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="1.9.10" OR 
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="2.9.11" OR 
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="3.9.12" OR
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="4.9.13" OR 
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="5.9.14" OR 
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="6.9.15" OR
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="7.9.16","05",
   IIf(T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="1.10.18" OR 
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="2.11.18" OR 
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="3.12.18" OR
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="4.13.18" OR 
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="5.14.18" OR 
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="6.15.18" OR
       T1.Ordre || "." || T2.Ordre || "." || T3.Ordre="7.16.18","09",
   IIf(                      T2.IdAlfabet ="K" AND T3.IdAlfabet ="W","07",
   IIf(T1.IdAlfabet ="K" AND 
       T2.IdAlfabet>="L" AND T2.IdAlfabet<="R" AND T3.IdAlfabet ="W","18",

   /* Cambres amb 28 multiplicacions vàlides 02_,08_,03,14 */
   IIf(T1.IdAlfabet>="B" AND T1.IdAlfabet<="H" AND T2.IdAlfabet>="C" AND 
       T2.IdAlfabet<="I" AND T3.IdAlfabet>="L" AND T3.IdAlfabet<="R","02",
   IIf(T1.IdAlfabet>="B" AND T1.IdAlfabet<="H" AND T2.IdAlfabet>="L" AND 
       T2.IdAlfabet<="R" AND T3.IdAlfabet>="M" AND T3.IdAlfabet<="U","08",
   IIf(T1.IdAlfabet>="B" AND T1.IdAlfabet<="H" AND T2.IdAlfabet>="C" AND 
       T2.IdAlfabet<="I" AND T3.IdAlfabet>="M" AND T3.IdAlfabet<="U","03",
   IIf(T1.IdAlfabet>="C" AND T1.IdAlfabet<="I" AND T2.IdAlfabet>="L" AND 
       T2.IdAlfabet<="R" AND T3.IdAlfabet>="M" AND T3.IdAlfabet<="U","14",

   /* Cambres amb 84 multiplicacions vàlides 04_,06_,10_,11_,15_,17  
   IIf(T1.IdAlfabet>="B" AND T1.IdAlfabet<="H" AND T2.IdAlfabet>="C" AND 
       T2.IdAlfabet<="I" AND T3.IdAlfabet>="N" AND T3.IdAlfabet<="W","04",
   IIf(T1.IdAlfabet>="B" AND T1.IdAlfabet<="H" AND T2.IdAlfabet>="D" AND 
       T2.IdAlfabet<="K" AND T3.IdAlfabet>="M" AND T3.IdAlfabet<="U","06",
   IIf(T1.IdAlfabet>="B" AND T1.IdAlfabet<="H" AND T2.IdAlfabet>="M" AND 
       T2.IdAlfabet<="U" AND T3.IdAlfabet>="N" AND T3.IdAlfabet<="W","10",
   IIf(T1.IdAlfabet>="C" AND T1.IdAlfabet<="I" AND T2.IdAlfabet>="D" AND 
       T2.IdAlfabet<="K" AND T3.IdAlfabet>="L" AND T3.IdAlfabet<="R","11",
   IIf(T1.IdAlfabet>="C" AND T1.IdAlfabet<="I" AND T2.IdAlfabet>="L" AND 
       T2.IdAlfabet<="R" AND T3.IdAlfabet>="N" AND T3.IdAlfabet<="W","15",
   IIf(T1.IdAlfabet>="D" AND T1.IdAlfabet<="K" AND T2.IdAlfabet>="L" AND 
       T2.IdAlfabet<="R" AND T3.IdAlfabet>="M" AND T3.IdAlfabet<="U","17",
   */

   IIf(Length(T1.Ordre || "." || T2.Ordre || "." || T3.Ordre)=6,"04","10"
   )) ))))  ))))  )))) /* )))))) */ ) AS Cambra
FROM 
   TblAlfabetAmpliat AS T1, TblAlfabetAmpliat AS T2, TblAlfabetAmpliat AS T3
WHERE 
   T2.IdAlfabet>T1.IdAlfabet AND T3.IdAlfabet>T1.IdAlfabet AND T3.IdAlfabet>T2.IdAlfabet 
   /* AND Cambra<>"04" AND Cambra<>"10" */
ORDER BY Cambra;

DROP TABLE IF EXISTS TblVàlides;
CREATE TABLE TblVàlides (
   IdMultiplicacio VARCHAR(4),
   Cambra VARCHAR(2),
   Columna VARCHAR(2),
PRIMARY KEY (IdMultiplicacio)
);

INSERT INTO TblVàlides VALUES ("BCD","01","01");
INSERT INTO TblVàlides VALUES ("BCE","01","02");
INSERT INTO TblVàlides VALUES ("BCF","01","03");
INSERT INTO TblVàlides VALUES ("BCG","01","04");
INSERT INTO TblVàlides VALUES ("BCH","01","05");
INSERT INTO TblVàlides VALUES ("BCI","01","06");
INSERT INTO TblVàlides VALUES ("BCK","01","07");
INSERT INTO TblVàlides VALUES ("BCtB","02","01");
INSERT INTO TblVàlides VALUES ("BCtC","03","01");
INSERT INTO TblVàlides VALUES ("BCtD","04","01");
INSERT INTO TblVàlides VALUES ("BCtE","04","02");
INSERT INTO TblVàlides VALUES ("BCtF","04","03");
INSERT INTO TblVàlides VALUES ("BCtG","04","04");
INSERT INTO TblVàlides VALUES ("BCtH","04","05");
INSERT INTO TblVàlides VALUES ("BCtI","04","06");
INSERT INTO TblVàlides VALUES ("BCtK","04","07");
INSERT INTO TblVàlides VALUES ("BDE","01","08");
INSERT INTO TblVàlides VALUES ("BDF","01","09");
INSERT INTO TblVàlides VALUES ("BDG","01","10");
INSERT INTO TblVàlides VALUES ("BDH","01","11");
INSERT INTO TblVàlides VALUES ("BDI","01","12");
INSERT INTO TblVàlides VALUES ("BDK","01","13");
INSERT INTO TblVàlides VALUES ("BDtB","02","08");
INSERT INTO TblVàlides VALUES ("BDtC","06","01");
INSERT INTO TblVàlides VALUES ("BDtD","03","08");
INSERT INTO TblVàlides VALUES ("BDtE","04","08");
INSERT INTO TblVàlides VALUES ("BDtF","04","09");
INSERT INTO TblVàlides VALUES ("BDtG","04","10");
INSERT INTO TblVàlides VALUES ("BDtH","04","11");
INSERT INTO TblVàlides VALUES ("BDtI","04","12");
INSERT INTO TblVàlides VALUES ("BDtK","04","13");
INSERT INTO TblVàlides VALUES ("BEF","01","14");
INSERT INTO TblVàlides VALUES ("BEG","01","15");
INSERT INTO TblVàlides VALUES ("BEH","01","16");
INSERT INTO TblVàlides VALUES ("BEI","01","17");
INSERT INTO TblVàlides VALUES ("BEK","01","18");
INSERT INTO TblVàlides VALUES ("BEtB","02","14");
INSERT INTO TblVàlides VALUES ("BEtC","06","02");
INSERT INTO TblVàlides VALUES ("BEtD","06","08");
INSERT INTO TblVàlides VALUES ("BEtE","03","14");
INSERT INTO TblVàlides VALUES ("BEtF","04","14");
INSERT INTO TblVàlides VALUES ("BEtG","04","15");
INSERT INTO TblVàlides VALUES ("BEtH","04","16");
INSERT INTO TblVàlides VALUES ("BEtI","04","17");
INSERT INTO TblVàlides VALUES ("BEtK","04","18");
INSERT INTO TblVàlides VALUES ("BFG","01","19");
INSERT INTO TblVàlides VALUES ("BFH","01","20");
INSERT INTO TblVàlides VALUES ("BFI","01","21");
INSERT INTO TblVàlides VALUES ("BFK","01","22");
INSERT INTO TblVàlides VALUES ("BFtB","02","19");
INSERT INTO TblVàlides VALUES ("BFtC","06","03");
INSERT INTO TblVàlides VALUES ("BFtD","06","09");
INSERT INTO TblVàlides VALUES ("BFtE","06","14");
INSERT INTO TblVàlides VALUES ("BFtF","03","19");
INSERT INTO TblVàlides VALUES ("BFtG","04","19");
INSERT INTO TblVàlides VALUES ("BFtH","04","20");
INSERT INTO TblVàlides VALUES ("BFtI","04","21");
INSERT INTO TblVàlides VALUES ("BFtK","04","22");
INSERT INTO TblVàlides VALUES ("BGH","01","23");
INSERT INTO TblVàlides VALUES ("BGI","01","24");
INSERT INTO TblVàlides VALUES ("BGK","01","25");
INSERT INTO TblVàlides VALUES ("BGtB","02","23");
INSERT INTO TblVàlides VALUES ("BGtC","06","04");
INSERT INTO TblVàlides VALUES ("BGtD","06","10");
INSERT INTO TblVàlides VALUES ("BGtE","06","15");
INSERT INTO TblVàlides VALUES ("BGtF","06","19");
INSERT INTO TblVàlides VALUES ("BGtG","03","23");
INSERT INTO TblVàlides VALUES ("BGtH","04","23");
INSERT INTO TblVàlides VALUES ("BGtI","04","24");
INSERT INTO TblVàlides VALUES ("BGtK","04","25");
INSERT INTO TblVàlides VALUES ("BHI","01","26");
INSERT INTO TblVàlides VALUES ("BHK","01","27");
INSERT INTO TblVàlides VALUES ("BHtB","02","26");
INSERT INTO TblVàlides VALUES ("BHtC","06","05");
INSERT INTO TblVàlides VALUES ("BHtD","06","11");
INSERT INTO TblVàlides VALUES ("BHtE","06","16");
INSERT INTO TblVàlides VALUES ("BHtF","06","20");
INSERT INTO TblVàlides VALUES ("BHtG","06","23");
INSERT INTO TblVàlides VALUES ("BHtH","03","26");
INSERT INTO TblVàlides VALUES ("BHtI","04","26");
INSERT INTO TblVàlides VALUES ("BHtK","04","27");
INSERT INTO TblVàlides VALUES ("BIK","01","28");
INSERT INTO TblVàlides VALUES ("BItB","02","28");
INSERT INTO TblVàlides VALUES ("BItC","06","06");
INSERT INTO TblVàlides VALUES ("BItD","06","12");
INSERT INTO TblVàlides VALUES ("BItE","06","17");
INSERT INTO TblVàlides VALUES ("BItF","06","21");
INSERT INTO TblVàlides VALUES ("BItG","06","24");
INSERT INTO TblVàlides VALUES ("BItH","06","26");
INSERT INTO TblVàlides VALUES ("BItI","03","28");
INSERT INTO TblVàlides VALUES ("BItK","04","28");
INSERT INTO TblVàlides VALUES ("BKtB","05","07");
INSERT INTO TblVàlides VALUES ("BKtC","06","07");
INSERT INTO TblVàlides VALUES ("BKtD","06","13");
INSERT INTO TblVàlides VALUES ("BKtE","06","18");
INSERT INTO TblVàlides VALUES ("BKtF","06","22");
INSERT INTO TblVàlides VALUES ("BKtG","06","25");
INSERT INTO TblVàlides VALUES ("BKtH","06","27");
INSERT INTO TblVàlides VALUES ("BKtI","06","28");
INSERT INTO TblVàlides VALUES ("BKtK","07","07");
INSERT INTO TblVàlides VALUES ("BtBC","08","01");
INSERT INTO TblVàlides VALUES ("BtBD","08","08");
INSERT INTO TblVàlides VALUES ("BtBE","08","14");
INSERT INTO TblVàlides VALUES ("BtBF","08","19");
INSERT INTO TblVàlides VALUES ("BtBG","08","23");
INSERT INTO TblVàlides VALUES ("BtBH","08","26");
INSERT INTO TblVàlides VALUES ("BtBI","08","28");
INSERT INTO TblVàlides VALUES ("BtBK","09","07");
INSERT INTO TblVàlides VALUES ("BtCD","10","01");
INSERT INTO TblVàlides VALUES ("BtCE","10","02");
INSERT INTO TblVàlides VALUES ("BtCF","10","03");
INSERT INTO TblVàlides VALUES ("BtCG","10","04");
INSERT INTO TblVàlides VALUES ("BtCH","10","05");
INSERT INTO TblVàlides VALUES ("BtCI","10","06");
INSERT INTO TblVàlides VALUES ("BtCK","10","07");
INSERT INTO TblVàlides VALUES ("BtDE","10","08");
INSERT INTO TblVàlides VALUES ("BtDF","10","09");
INSERT INTO TblVàlides VALUES ("BtDG","10","10");
INSERT INTO TblVàlides VALUES ("BtDH","10","11");
INSERT INTO TblVàlides VALUES ("BtDI","10","12");
INSERT INTO TblVàlides VALUES ("BtDK","10","13");
INSERT INTO TblVàlides VALUES ("BtEF","10","14");
INSERT INTO TblVàlides VALUES ("BtEG","10","15");
INSERT INTO TblVàlides VALUES ("BtEH","10","16");
INSERT INTO TblVàlides VALUES ("BtEI","10","17");
INSERT INTO TblVàlides VALUES ("BtEK","10","18");
INSERT INTO TblVàlides VALUES ("BtFG","10","19");
INSERT INTO TblVàlides VALUES ("BtFH","10","20");
INSERT INTO TblVàlides VALUES ("BtFI","10","21");
INSERT INTO TblVàlides VALUES ("BtFK","10","22");
INSERT INTO TblVàlides VALUES ("BtGH","10","23");
INSERT INTO TblVàlides VALUES ("BtGI","10","24");
INSERT INTO TblVàlides VALUES ("BtGK","10","25");
INSERT INTO TblVàlides VALUES ("BtHI","10","26");
INSERT INTO TblVàlides VALUES ("BtHK","10","27");
INSERT INTO TblVàlides VALUES ("BtIK","10","28");
INSERT INTO TblVàlides VALUES ("CDE","01","29");
INSERT INTO TblVàlides VALUES ("CDF","01","30");
INSERT INTO TblVàlides VALUES ("CDG","01","31");
INSERT INTO TblVàlides VALUES ("CDH","01","32");
INSERT INTO TblVàlides VALUES ("CDI","01","33");
INSERT INTO TblVàlides VALUES ("CDK","01","34");
INSERT INTO TblVàlides VALUES ("CDtB","11","01");
INSERT INTO TblVàlides VALUES ("CDtC","02","29");
INSERT INTO TblVàlides VALUES ("CDtD","03","29");
INSERT INTO TblVàlides VALUES ("CDtE","04","29");
INSERT INTO TblVàlides VALUES ("CDtF","04","30");
INSERT INTO TblVàlides VALUES ("CDtG","04","31");
INSERT INTO TblVàlides VALUES ("CDtH","04","32");
INSERT INTO TblVàlides VALUES ("CDtI","04","33");
INSERT INTO TblVàlides VALUES ("CDtK","04","34");
INSERT INTO TblVàlides VALUES ("CEF","01","35");
INSERT INTO TblVàlides VALUES ("CEG","01","36");
INSERT INTO TblVàlides VALUES ("CEH","01","37");
INSERT INTO TblVàlides VALUES ("CEI","01","38");
INSERT INTO TblVàlides VALUES ("CEK","01","39");
INSERT INTO TblVàlides VALUES ("CEtB","11","02");
INSERT INTO TblVàlides VALUES ("CEtC","02","35");
INSERT INTO TblVàlides VALUES ("CEtD","06","29");
INSERT INTO TblVàlides VALUES ("CEtE","03","35");
INSERT INTO TblVàlides VALUES ("CEtF","04","35");
INSERT INTO TblVàlides VALUES ("CEtG","04","36");
INSERT INTO TblVàlides VALUES ("CEtH","04","37");
INSERT INTO TblVàlides VALUES ("CEtI","04","38");
INSERT INTO TblVàlides VALUES ("CEtK","04","39");
INSERT INTO TblVàlides VALUES ("CFG","01","40");
INSERT INTO TblVàlides VALUES ("CFH","01","41");
INSERT INTO TblVàlides VALUES ("CFI","01","42");
INSERT INTO TblVàlides VALUES ("CFK","01","43");
INSERT INTO TblVàlides VALUES ("CFtB","11","03");
INSERT INTO TblVàlides VALUES ("CFtC","02","40");
INSERT INTO TblVàlides VALUES ("CFtD","06","30");
INSERT INTO TblVàlides VALUES ("CFtE","06","35");
INSERT INTO TblVàlides VALUES ("CFtF","03","40");
INSERT INTO TblVàlides VALUES ("CFtG","04","40");
INSERT INTO TblVàlides VALUES ("CFtH","04","41");
INSERT INTO TblVàlides VALUES ("CFtI","04","42");
INSERT INTO TblVàlides VALUES ("CFtK","04","43");
INSERT INTO TblVàlides VALUES ("CGH","01","44");
INSERT INTO TblVàlides VALUES ("CGI","01","45");
INSERT INTO TblVàlides VALUES ("CGK","01","46");
INSERT INTO TblVàlides VALUES ("CGtB","11","04");
INSERT INTO TblVàlides VALUES ("CGtC","02","44");
INSERT INTO TblVàlides VALUES ("CGtD","06","31");
INSERT INTO TblVàlides VALUES ("CGtE","06","36");
INSERT INTO TblVàlides VALUES ("CGtF","06","40");
INSERT INTO TblVàlides VALUES ("CGtG","03","44");
INSERT INTO TblVàlides VALUES ("CGtH","04","44");
INSERT INTO TblVàlides VALUES ("CGtI","04","45");
INSERT INTO TblVàlides VALUES ("CGtK","04","46");
INSERT INTO TblVàlides VALUES ("CHI","01","47");
INSERT INTO TblVàlides VALUES ("CHK","01","48");
INSERT INTO TblVàlides VALUES ("CHtB","11","05");
INSERT INTO TblVàlides VALUES ("CHtC","02","47");
INSERT INTO TblVàlides VALUES ("CHtD","06","32");
INSERT INTO TblVàlides VALUES ("CHtE","06","37");
INSERT INTO TblVàlides VALUES ("CHtF","06","41");
INSERT INTO TblVàlides VALUES ("CHtG","06","44");
INSERT INTO TblVàlides VALUES ("CHtH","03","47");
INSERT INTO TblVàlides VALUES ("CHtI","04","47");
INSERT INTO TblVàlides VALUES ("CHtK","04","48");
INSERT INTO TblVàlides VALUES ("CIK","01","49");
INSERT INTO TblVàlides VALUES ("CItB","11","06");
INSERT INTO TblVàlides VALUES ("CItC","02","49");
INSERT INTO TblVàlides VALUES ("CItD","06","33");
INSERT INTO TblVàlides VALUES ("CItE","06","38");
INSERT INTO TblVàlides VALUES ("CItF","06","42");
INSERT INTO TblVàlides VALUES ("CItG","06","45");
INSERT INTO TblVàlides VALUES ("CItH","06","47");
INSERT INTO TblVàlides VALUES ("CItI","03","49");
INSERT INTO TblVàlides VALUES ("CItK","04","49");
INSERT INTO TblVàlides VALUES ("CKtB","11","07");
INSERT INTO TblVàlides VALUES ("CKtC","05","34");
INSERT INTO TblVàlides VALUES ("CKtD","06","34");
INSERT INTO TblVàlides VALUES ("CKtE","06","39");
INSERT INTO TblVàlides VALUES ("CKtF","06","43");
INSERT INTO TblVàlides VALUES ("CKtG","06","46");
INSERT INTO TblVàlides VALUES ("CKtH","06","48");
INSERT INTO TblVàlides VALUES ("CKtI","06","49");
INSERT INTO TblVàlides VALUES ("CKtK","07","34");
INSERT INTO TblVàlides VALUES ("CtBC","14","01");
INSERT INTO TblVàlides VALUES ("CtBD","15","01");
INSERT INTO TblVàlides VALUES ("CtBE","15","02");
INSERT INTO TblVàlides VALUES ("CtBF","15","03");
INSERT INTO TblVàlides VALUES ("CtBG","15","04");
INSERT INTO TblVàlides VALUES ("CtBH","15","05");
INSERT INTO TblVàlides VALUES ("CtBI","15","06");
INSERT INTO TblVàlides VALUES ("CtBK","15","07");
INSERT INTO TblVàlides VALUES ("CtCD","08","29");
INSERT INTO TblVàlides VALUES ("CtCE","08","35");
INSERT INTO TblVàlides VALUES ("CtCF","08","40");
INSERT INTO TblVàlides VALUES ("CtCG","08","44");
INSERT INTO TblVàlides VALUES ("CtCH","08","47");
INSERT INTO TblVàlides VALUES ("CtCI","08","49");
INSERT INTO TblVàlides VALUES ("CtCK","09","34");
INSERT INTO TblVàlides VALUES ("CtDE","10","29");
INSERT INTO TblVàlides VALUES ("CtDF","10","30");
INSERT INTO TblVàlides VALUES ("CtDG","10","31");
INSERT INTO TblVàlides VALUES ("CtDH","10","32");
INSERT INTO TblVàlides VALUES ("CtDI","10","33");
INSERT INTO TblVàlides VALUES ("CtDK","10","34");
INSERT INTO TblVàlides VALUES ("CtEF","10","35");
INSERT INTO TblVàlides VALUES ("CtEG","10","36");
INSERT INTO TblVàlides VALUES ("CtEH","10","37");
INSERT INTO TblVàlides VALUES ("CtEI","10","38");
INSERT INTO TblVàlides VALUES ("CtEK","10","39");
INSERT INTO TblVàlides VALUES ("CtFG","10","40");
INSERT INTO TblVàlides VALUES ("CtFH","10","41");
INSERT INTO TblVàlides VALUES ("CtFI","10","42");
INSERT INTO TblVàlides VALUES ("CtFK","10","43");
INSERT INTO TblVàlides VALUES ("CtGH","10","44");
INSERT INTO TblVàlides VALUES ("CtGI","10","45");
INSERT INTO TblVàlides VALUES ("CtGK","10","46");
INSERT INTO TblVàlides VALUES ("CtHI","10","47");
INSERT INTO TblVàlides VALUES ("CtHK","10","48");
INSERT INTO TblVàlides VALUES ("CtIK","10","49");
INSERT INTO TblVàlides VALUES ("DEF","01","50");
INSERT INTO TblVàlides VALUES ("DEG","01","51");
INSERT INTO TblVàlides VALUES ("DEH","01","52");
INSERT INTO TblVàlides VALUES ("DEI","01","53");
INSERT INTO TblVàlides VALUES ("DEK","01","54");
INSERT INTO TblVàlides VALUES ("DEtB","11","08");
INSERT INTO TblVàlides VALUES ("DEtC","11","29");
INSERT INTO TblVàlides VALUES ("DEtD","02","50");
INSERT INTO TblVàlides VALUES ("DEtE","03","50");
INSERT INTO TblVàlides VALUES ("DEtF","04","50");
INSERT INTO TblVàlides VALUES ("DEtG","04","51");
INSERT INTO TblVàlides VALUES ("DEtH","04","52");
INSERT INTO TblVàlides VALUES ("DEtI","04","53");
INSERT INTO TblVàlides VALUES ("DEtK","04","54");
INSERT INTO TblVàlides VALUES ("DFG","01","55");
INSERT INTO TblVàlides VALUES ("DFH","01","56");
INSERT INTO TblVàlides VALUES ("DFI","01","57");
INSERT INTO TblVàlides VALUES ("DFK","01","58");
INSERT INTO TblVàlides VALUES ("DFtB","11","09");
INSERT INTO TblVàlides VALUES ("DFtC","11","30");
INSERT INTO TblVàlides VALUES ("DFtD","02","55");
INSERT INTO TblVàlides VALUES ("DFtE","06","50");
INSERT INTO TblVàlides VALUES ("DFtF","03","55");
INSERT INTO TblVàlides VALUES ("DFtG","04","55");
INSERT INTO TblVàlides VALUES ("DFtH","04","56");
INSERT INTO TblVàlides VALUES ("DFtI","04","57");
INSERT INTO TblVàlides VALUES ("DFtK","04","58");
INSERT INTO TblVàlides VALUES ("DGH","01","59");
INSERT INTO TblVàlides VALUES ("DGI","01","60");
INSERT INTO TblVàlides VALUES ("DGK","01","61");
INSERT INTO TblVàlides VALUES ("DGtB","11","10");
INSERT INTO TblVàlides VALUES ("DGtC","11","31");
INSERT INTO TblVàlides VALUES ("DGtD","02","59");
INSERT INTO TblVàlides VALUES ("DGtE","06","51");
INSERT INTO TblVàlides VALUES ("DGtF","06","55");
INSERT INTO TblVàlides VALUES ("DGtG","03","59");
INSERT INTO TblVàlides VALUES ("DGtH","04","59");
INSERT INTO TblVàlides VALUES ("DGtI","04","60");
INSERT INTO TblVàlides VALUES ("DGtK","04","61");
INSERT INTO TblVàlides VALUES ("DHI","01","62");
INSERT INTO TblVàlides VALUES ("DHK","01","63");
INSERT INTO TblVàlides VALUES ("DHtB","11","11");
INSERT INTO TblVàlides VALUES ("DHtC","11","32");
INSERT INTO TblVàlides VALUES ("DHtD","02","62");
INSERT INTO TblVàlides VALUES ("DHtE","06","52");
INSERT INTO TblVàlides VALUES ("DHtF","06","56");
INSERT INTO TblVàlides VALUES ("DHtG","06","59");
INSERT INTO TblVàlides VALUES ("DHtH","03","62");
INSERT INTO TblVàlides VALUES ("DHtI","04","62");
INSERT INTO TblVàlides VALUES ("DHtK","04","63");
INSERT INTO TblVàlides VALUES ("DIK","01","64");
INSERT INTO TblVàlides VALUES ("DItB","11","12");
INSERT INTO TblVàlides VALUES ("DItC","11","33");
INSERT INTO TblVàlides VALUES ("DItD","02","64");
INSERT INTO TblVàlides VALUES ("DItE","06","53");
INSERT INTO TblVàlides VALUES ("DItF","06","57");
INSERT INTO TblVàlides VALUES ("DItG","06","60");
INSERT INTO TblVàlides VALUES ("DItH","06","62");
INSERT INTO TblVàlides VALUES ("DItI","03","64");
INSERT INTO TblVàlides VALUES ("DItK","04","64");
INSERT INTO TblVàlides VALUES ("DKtB","11","13");
INSERT INTO TblVàlides VALUES ("DKtC","11","34");
INSERT INTO TblVàlides VALUES ("DKtD","05","54");
INSERT INTO TblVàlides VALUES ("DKtE","06","54");
INSERT INTO TblVàlides VALUES ("DKtF","06","58");
INSERT INTO TblVàlides VALUES ("DKtG","06","61");
INSERT INTO TblVàlides VALUES ("DKtH","06","63");
INSERT INTO TblVàlides VALUES ("DKtI","06","64");
INSERT INTO TblVàlides VALUES ("DKtK","07","54");
INSERT INTO TblVàlides VALUES ("DtBC","17","01");
INSERT INTO TblVàlides VALUES ("DtBD","14","08");
INSERT INTO TblVàlides VALUES ("DtBE","15","08");
INSERT INTO TblVàlides VALUES ("DtBF","15","09");
INSERT INTO TblVàlides VALUES ("DtBG","15","10");
INSERT INTO TblVàlides VALUES ("DtBH","15","11");
INSERT INTO TblVàlides VALUES ("DtBI","15","12");
INSERT INTO TblVàlides VALUES ("DtBK","15","13");
INSERT INTO TblVàlides VALUES ("DtCD","14","29");
INSERT INTO TblVàlides VALUES ("DtCE","15","29");
INSERT INTO TblVàlides VALUES ("DtCF","15","30");
INSERT INTO TblVàlides VALUES ("DtCG","15","31");
INSERT INTO TblVàlides VALUES ("DtCH","15","32");
INSERT INTO TblVàlides VALUES ("DtCI","15","33");
INSERT INTO TblVàlides VALUES ("DtCK","15","34");
INSERT INTO TblVàlides VALUES ("DtDE","08","50");
INSERT INTO TblVàlides VALUES ("DtDF","08","55");
INSERT INTO TblVàlides VALUES ("DtDG","08","59");
INSERT INTO TblVàlides VALUES ("DtDH","08","62");
INSERT INTO TblVàlides VALUES ("DtDI","08","64");
INSERT INTO TblVàlides VALUES ("DtDK","09","54");
INSERT INTO TblVàlides VALUES ("DtEF","10","50");
INSERT INTO TblVàlides VALUES ("DtEG","10","51");
INSERT INTO TblVàlides VALUES ("DtEH","10","52");
INSERT INTO TblVàlides VALUES ("DtEI","10","53");
INSERT INTO TblVàlides VALUES ("DtEK","10","54");
INSERT INTO TblVàlides VALUES ("DtFG","10","55");
INSERT INTO TblVàlides VALUES ("DtFH","10","56");
INSERT INTO TblVàlides VALUES ("DtFI","10","57");
INSERT INTO TblVàlides VALUES ("DtFK","10","58");
INSERT INTO TblVàlides VALUES ("DtGH","10","59");
INSERT INTO TblVàlides VALUES ("DtGI","10","60");
INSERT INTO TblVàlides VALUES ("DtGK","10","61");
INSERT INTO TblVàlides VALUES ("DtHI","10","62");
INSERT INTO TblVàlides VALUES ("DtHK","10","63");
INSERT INTO TblVàlides VALUES ("DtIK","10","64");
INSERT INTO TblVàlides VALUES ("EFG","01","65");
INSERT INTO TblVàlides VALUES ("EFH","01","66");
INSERT INTO TblVàlides VALUES ("EFI","01","67");
INSERT INTO TblVàlides VALUES ("EFK","01","68");
INSERT INTO TblVàlides VALUES ("EFtB","11","14");
INSERT INTO TblVàlides VALUES ("EFtC","11","35");
INSERT INTO TblVàlides VALUES ("EFtD","11","50");
INSERT INTO TblVàlides VALUES ("EFtE","02","65");
INSERT INTO TblVàlides VALUES ("EFtF","03","65");
INSERT INTO TblVàlides VALUES ("EFtG","04","65");
INSERT INTO TblVàlides VALUES ("EFtH","04","66");
INSERT INTO TblVàlides VALUES ("EFtI","04","67");
INSERT INTO TblVàlides VALUES ("EFtK","04","68");
INSERT INTO TblVàlides VALUES ("EGH","01","69");
INSERT INTO TblVàlides VALUES ("EGI","01","70");
INSERT INTO TblVàlides VALUES ("EGK","01","71");
INSERT INTO TblVàlides VALUES ("EGtB","11","15");
INSERT INTO TblVàlides VALUES ("EGtC","11","36");
INSERT INTO TblVàlides VALUES ("EGtD","11","51");
INSERT INTO TblVàlides VALUES ("EGtE","02","69");
INSERT INTO TblVàlides VALUES ("EGtF","06","65");
INSERT INTO TblVàlides VALUES ("EGtG","03","69");
INSERT INTO TblVàlides VALUES ("EGtH","04","69");
INSERT INTO TblVàlides VALUES ("EGtI","04","70");
INSERT INTO TblVàlides VALUES ("EGtK","04","71");
INSERT INTO TblVàlides VALUES ("EHI","01","72");
INSERT INTO TblVàlides VALUES ("EHK","01","73");
INSERT INTO TblVàlides VALUES ("EHtB","11","16");
INSERT INTO TblVàlides VALUES ("EHtC","11","37");
INSERT INTO TblVàlides VALUES ("EHtD","11","52");
INSERT INTO TblVàlides VALUES ("EHtE","02","72");
INSERT INTO TblVàlides VALUES ("EHtF","06","66");
INSERT INTO TblVàlides VALUES ("EHtG","06","69");
INSERT INTO TblVàlides VALUES ("EHtH","03","72");
INSERT INTO TblVàlides VALUES ("EHtI","04","72");
INSERT INTO TblVàlides VALUES ("EHtK","04","73");
INSERT INTO TblVàlides VALUES ("EIK","01","74");
INSERT INTO TblVàlides VALUES ("EItB","11","17");
INSERT INTO TblVàlides VALUES ("EItC","11","38");
INSERT INTO TblVàlides VALUES ("EItD","11","53");
INSERT INTO TblVàlides VALUES ("EItE","02","74");
INSERT INTO TblVàlides VALUES ("EItF","06","67");
INSERT INTO TblVàlides VALUES ("EItG","06","70");
INSERT INTO TblVàlides VALUES ("EItH","06","72");
INSERT INTO TblVàlides VALUES ("EItI","03","74");
INSERT INTO TblVàlides VALUES ("EItK","04","74");
INSERT INTO TblVàlides VALUES ("EKtB","11","18");
INSERT INTO TblVàlides VALUES ("EKtC","11","39");
INSERT INTO TblVàlides VALUES ("EKtD","11","54");
INSERT INTO TblVàlides VALUES ("EKtE","05","68");
INSERT INTO TblVàlides VALUES ("EKtF","06","68");
INSERT INTO TblVàlides VALUES ("EKtG","06","71");
INSERT INTO TblVàlides VALUES ("EKtH","06","73");
INSERT INTO TblVàlides VALUES ("EKtI","06","74");
INSERT INTO TblVàlides VALUES ("EKtK","07","68");
INSERT INTO TblVàlides VALUES ("EtBC","17","02");
INSERT INTO TblVàlides VALUES ("EtBD","17","08");
INSERT INTO TblVàlides VALUES ("EtBE","14","14");
INSERT INTO TblVàlides VALUES ("EtBF","15","14");
INSERT INTO TblVàlides VALUES ("EtBG","15","15");
INSERT INTO TblVàlides VALUES ("EtBH","15","16");
INSERT INTO TblVàlides VALUES ("EtBI","15","17");
INSERT INTO TblVàlides VALUES ("EtBK","15","18");
INSERT INTO TblVàlides VALUES ("EtCD","17","29");
INSERT INTO TblVàlides VALUES ("EtCE","14","35");
INSERT INTO TblVàlides VALUES ("EtCF","15","35");
INSERT INTO TblVàlides VALUES ("EtCG","15","36");
INSERT INTO TblVàlides VALUES ("EtCH","15","37");
INSERT INTO TblVàlides VALUES ("EtCI","15","38");
INSERT INTO TblVàlides VALUES ("EtCK","15","39");
INSERT INTO TblVàlides VALUES ("EtDE","14","50");
INSERT INTO TblVàlides VALUES ("EtDF","15","50");
INSERT INTO TblVàlides VALUES ("EtDG","15","51");
INSERT INTO TblVàlides VALUES ("EtDH","15","52");
INSERT INTO TblVàlides VALUES ("EtDI","15","53");
INSERT INTO TblVàlides VALUES ("EtDK","15","54");
INSERT INTO TblVàlides VALUES ("EtEF","08","65");
INSERT INTO TblVàlides VALUES ("EtEG","08","69");
INSERT INTO TblVàlides VALUES ("EtEH","08","72");
INSERT INTO TblVàlides VALUES ("EtEI","08","74");
INSERT INTO TblVàlides VALUES ("EtEK","09","68");
INSERT INTO TblVàlides VALUES ("EtFG","10","65");
INSERT INTO TblVàlides VALUES ("EtFH","10","66");
INSERT INTO TblVàlides VALUES ("EtFI","10","67");
INSERT INTO TblVàlides VALUES ("EtFK","10","68");
INSERT INTO TblVàlides VALUES ("EtGH","10","69");
INSERT INTO TblVàlides VALUES ("EtGI","10","70");
INSERT INTO TblVàlides VALUES ("EtGK","10","71");
INSERT INTO TblVàlides VALUES ("EtHI","10","72");
INSERT INTO TblVàlides VALUES ("EtHK","10","73");
INSERT INTO TblVàlides VALUES ("EtIK","10","74");
INSERT INTO TblVàlides VALUES ("FGH","01","75");
INSERT INTO TblVàlides VALUES ("FGI","01","76");
INSERT INTO TblVàlides VALUES ("FGK","01","77");
INSERT INTO TblVàlides VALUES ("FGtB","11","19");
INSERT INTO TblVàlides VALUES ("FGtC","11","40");
INSERT INTO TblVàlides VALUES ("FGtD","11","55");
INSERT INTO TblVàlides VALUES ("FGtE","11","65");
INSERT INTO TblVàlides VALUES ("FGtF","02","75");
INSERT INTO TblVàlides VALUES ("FGtG","03","75");
INSERT INTO TblVàlides VALUES ("FGtH","04","75");
INSERT INTO TblVàlides VALUES ("FGtI","04","76");
INSERT INTO TblVàlides VALUES ("FGtK","04","77");
INSERT INTO TblVàlides VALUES ("FHI","01","78");
INSERT INTO TblVàlides VALUES ("FHK","01","79");
INSERT INTO TblVàlides VALUES ("FHtB","11","20");
INSERT INTO TblVàlides VALUES ("FHtC","11","41");
INSERT INTO TblVàlides VALUES ("FHtD","11","56");
INSERT INTO TblVàlides VALUES ("FHtE","11","66");
INSERT INTO TblVàlides VALUES ("FHtF","02","78");
INSERT INTO TblVàlides VALUES ("FHtG","06","75");
INSERT INTO TblVàlides VALUES ("FHtH","03","78");
INSERT INTO TblVàlides VALUES ("FHtI","04","78");
INSERT INTO TblVàlides VALUES ("FHtK","04","79");
INSERT INTO TblVàlides VALUES ("FIK","01","80");
INSERT INTO TblVàlides VALUES ("FItB","11","21");
INSERT INTO TblVàlides VALUES ("FItC","11","42");
INSERT INTO TblVàlides VALUES ("FItD","11","57");
INSERT INTO TblVàlides VALUES ("FItE","11","67");
INSERT INTO TblVàlides VALUES ("FItF","02","80");
INSERT INTO TblVàlides VALUES ("FItG","06","76");
INSERT INTO TblVàlides VALUES ("FItH","06","78");
INSERT INTO TblVàlides VALUES ("FItI","03","80");
INSERT INTO TblVàlides VALUES ("FItK","04","80");
INSERT INTO TblVàlides VALUES ("FKtB","11","22");
INSERT INTO TblVàlides VALUES ("FKtC","11","43");
INSERT INTO TblVàlides VALUES ("FKtD","11","58");
INSERT INTO TblVàlides VALUES ("FKtE","11","68");
INSERT INTO TblVàlides VALUES ("FKtF","05","77");
INSERT INTO TblVàlides VALUES ("FKtG","06","77");
INSERT INTO TblVàlides VALUES ("FKtH","06","79");
INSERT INTO TblVàlides VALUES ("FKtI","06","80");
INSERT INTO TblVàlides VALUES ("FKtK","07","77");
INSERT INTO TblVàlides VALUES ("FtBC","17","03");
INSERT INTO TblVàlides VALUES ("FtBD","17","09");
INSERT INTO TblVàlides VALUES ("FtBE","17","14");
INSERT INTO TblVàlides VALUES ("FtBF","14","19");
INSERT INTO TblVàlides VALUES ("FtBG","15","19");
INSERT INTO TblVàlides VALUES ("FtBH","15","20");
INSERT INTO TblVàlides VALUES ("FtBI","15","21");
INSERT INTO TblVàlides VALUES ("FtBK","15","22");
INSERT INTO TblVàlides VALUES ("FtCD","17","30");
INSERT INTO TblVàlides VALUES ("FtCE","17","35");
INSERT INTO TblVàlides VALUES ("FtCF","14","40");
INSERT INTO TblVàlides VALUES ("FtCG","15","40");
INSERT INTO TblVàlides VALUES ("FtCH","15","41");
INSERT INTO TblVàlides VALUES ("FtCI","15","42");
INSERT INTO TblVàlides VALUES ("FtCK","15","43");
INSERT INTO TblVàlides VALUES ("FtDE","17","50");
INSERT INTO TblVàlides VALUES ("FtDF","14","55");
INSERT INTO TblVàlides VALUES ("FtDG","15","55");
INSERT INTO TblVàlides VALUES ("FtDH","15","56");
INSERT INTO TblVàlides VALUES ("FtDI","15","57");
INSERT INTO TblVàlides VALUES ("FtDK","15","58");
INSERT INTO TblVàlides VALUES ("FtEF","14","65");
INSERT INTO TblVàlides VALUES ("FtEG","15","65");
INSERT INTO TblVàlides VALUES ("FtEH","15","66");
INSERT INTO TblVàlides VALUES ("FtEI","15","67");
INSERT INTO TblVàlides VALUES ("FtEK","15","68");
INSERT INTO TblVàlides VALUES ("FtFG","08","75");
INSERT INTO TblVàlides VALUES ("FtFH","08","78");
INSERT INTO TblVàlides VALUES ("FtFI","08","80");
INSERT INTO TblVàlides VALUES ("FtFK","09","77");
INSERT INTO TblVàlides VALUES ("FtGH","10","75");
INSERT INTO TblVàlides VALUES ("FtGI","10","76");
INSERT INTO TblVàlides VALUES ("FtGK","10","77");
INSERT INTO TblVàlides VALUES ("FtHI","10","78");
INSERT INTO TblVàlides VALUES ("FtHK","10","79");
INSERT INTO TblVàlides VALUES ("FtIK","10","80");
INSERT INTO TblVàlides VALUES ("GHI","01","81");
INSERT INTO TblVàlides VALUES ("GHK","01","82");
INSERT INTO TblVàlides VALUES ("GHtB","11","23");
INSERT INTO TblVàlides VALUES ("GHtC","11","44");
INSERT INTO TblVàlides VALUES ("GHtD","11","59");
INSERT INTO TblVàlides VALUES ("GHtE","11","69");
INSERT INTO TblVàlides VALUES ("GHtF","11","75");
INSERT INTO TblVàlides VALUES ("GHtG","02","81");
INSERT INTO TblVàlides VALUES ("GHtH","03","81");
INSERT INTO TblVàlides VALUES ("GHtI","04","81");
INSERT INTO TblVàlides VALUES ("GHtK","04","82");
INSERT INTO TblVàlides VALUES ("GIK","01","83");
INSERT INTO TblVàlides VALUES ("GItB","11","24");
INSERT INTO TblVàlides VALUES ("GItC","11","45");
INSERT INTO TblVàlides VALUES ("GItD","11","60");
INSERT INTO TblVàlides VALUES ("GItE","11","70");
INSERT INTO TblVàlides VALUES ("GItF","11","76");
INSERT INTO TblVàlides VALUES ("GItG","02","83");
INSERT INTO TblVàlides VALUES ("GItH","06","81");
INSERT INTO TblVàlides VALUES ("GItI","03","83");
INSERT INTO TblVàlides VALUES ("GItK","04","83");
INSERT INTO TblVàlides VALUES ("GKtB","11","25");
INSERT INTO TblVàlides VALUES ("GKtC","11","46");
INSERT INTO TblVàlides VALUES ("GKtD","11","61");
INSERT INTO TblVàlides VALUES ("GKtE","11","71");
INSERT INTO TblVàlides VALUES ("GKtF","11","77");
INSERT INTO TblVàlides VALUES ("GKtG","05","82");
INSERT INTO TblVàlides VALUES ("GKtH","06","82");
INSERT INTO TblVàlides VALUES ("GKtI","06","83");
INSERT INTO TblVàlides VALUES ("GKtK","07","82");
INSERT INTO TblVàlides VALUES ("GtBC","17","04");
INSERT INTO TblVàlides VALUES ("GtBD","17","10");
INSERT INTO TblVàlides VALUES ("GtBE","17","15");
INSERT INTO TblVàlides VALUES ("GtBF","17","19");
INSERT INTO TblVàlides VALUES ("GtBG","14","23");
INSERT INTO TblVàlides VALUES ("GtBH","15","23");
INSERT INTO TblVàlides VALUES ("GtBI","15","24");
INSERT INTO TblVàlides VALUES ("GtBK","15","25");
INSERT INTO TblVàlides VALUES ("GtCD","17","31");
INSERT INTO TblVàlides VALUES ("GtCE","17","36");
INSERT INTO TblVàlides VALUES ("GtCF","17","40");
INSERT INTO TblVàlides VALUES ("GtCG","14","44");
INSERT INTO TblVàlides VALUES ("GtCH","15","44");
INSERT INTO TblVàlides VALUES ("GtCI","15","45");
INSERT INTO TblVàlides VALUES ("GtCK","15","46");
INSERT INTO TblVàlides VALUES ("GtDE","17","51");
INSERT INTO TblVàlides VALUES ("GtDF","17","55");
INSERT INTO TblVàlides VALUES ("GtDG","14","59");
INSERT INTO TblVàlides VALUES ("GtDH","15","59");
INSERT INTO TblVàlides VALUES ("GtDI","15","60");
INSERT INTO TblVàlides VALUES ("GtDK","15","61");
INSERT INTO TblVàlides VALUES ("GtEF","17","65");
INSERT INTO TblVàlides VALUES ("GtEG","14","69");
INSERT INTO TblVàlides VALUES ("GtEH","15","69");
INSERT INTO TblVàlides VALUES ("GtEI","15","70");
INSERT INTO TblVàlides VALUES ("GtEK","15","71");
INSERT INTO TblVàlides VALUES ("GtFG","14","75");
INSERT INTO TblVàlides VALUES ("GtFH","15","75");
INSERT INTO TblVàlides VALUES ("GtFI","15","76");
INSERT INTO TblVàlides VALUES ("GtFK","15","77");
INSERT INTO TblVàlides VALUES ("GtGH","08","81");
INSERT INTO TblVàlides VALUES ("GtGI","08","83");
INSERT INTO TblVàlides VALUES ("GtGK","09","82");
INSERT INTO TblVàlides VALUES ("GtHI","10","81");
INSERT INTO TblVàlides VALUES ("GtHK","10","82");
INSERT INTO TblVàlides VALUES ("GtIK","10","83");
INSERT INTO TblVàlides VALUES ("HIK","01","84");
INSERT INTO TblVàlides VALUES ("HItB","11","26");
INSERT INTO TblVàlides VALUES ("HItC","11","47");
INSERT INTO TblVàlides VALUES ("HItD","11","62");
INSERT INTO TblVàlides VALUES ("HItE","11","72");
INSERT INTO TblVàlides VALUES ("HItF","11","78");
INSERT INTO TblVàlides VALUES ("HItG","11","81");
INSERT INTO TblVàlides VALUES ("HItH","02","84");
INSERT INTO TblVàlides VALUES ("HItI","03","84");
INSERT INTO TblVàlides VALUES ("HItK","04","84");
INSERT INTO TblVàlides VALUES ("HKtB","11","27");
INSERT INTO TblVàlides VALUES ("HKtC","11","48");
INSERT INTO TblVàlides VALUES ("HKtD","11","63");
INSERT INTO TblVàlides VALUES ("HKtE","11","73");
INSERT INTO TblVàlides VALUES ("HKtF","11","79");
INSERT INTO TblVàlides VALUES ("HKtG","11","82");
INSERT INTO TblVàlides VALUES ("HKtH","05","84");
INSERT INTO TblVàlides VALUES ("HKtI","06","84");
INSERT INTO TblVàlides VALUES ("HKtK","07","84");
INSERT INTO TblVàlides VALUES ("HtBC","17","05");
INSERT INTO TblVàlides VALUES ("HtBD","17","11");
INSERT INTO TblVàlides VALUES ("HtBE","17","16");
INSERT INTO TblVàlides VALUES ("HtBF","17","20");
INSERT INTO TblVàlides VALUES ("HtBG","17","23");
INSERT INTO TblVàlides VALUES ("HtBH","14","26");
INSERT INTO TblVàlides VALUES ("HtBI","15","26");
INSERT INTO TblVàlides VALUES ("HtBK","15","27");
INSERT INTO TblVàlides VALUES ("HtCD","17","32");
INSERT INTO TblVàlides VALUES ("HtCE","17","37");
INSERT INTO TblVàlides VALUES ("HtCF","17","41");
INSERT INTO TblVàlides VALUES ("HtCG","17","44");
INSERT INTO TblVàlides VALUES ("HtCH","14","47");
INSERT INTO TblVàlides VALUES ("HtCI","15","47");
INSERT INTO TblVàlides VALUES ("HtCK","15","48");
INSERT INTO TblVàlides VALUES ("HtDE","17","52");
INSERT INTO TblVàlides VALUES ("HtDF","17","56");
INSERT INTO TblVàlides VALUES ("HtDG","17","59");
INSERT INTO TblVàlides VALUES ("HtDH","14","62");
INSERT INTO TblVàlides VALUES ("HtDI","15","62");
INSERT INTO TblVàlides VALUES ("HtDK","15","63");
INSERT INTO TblVàlides VALUES ("HtEF","17","66");
INSERT INTO TblVàlides VALUES ("HtEG","17","69");
INSERT INTO TblVàlides VALUES ("HtEH","14","72");
INSERT INTO TblVàlides VALUES ("HtEI","15","72");
INSERT INTO TblVàlides VALUES ("HtEK","15","73");
INSERT INTO TblVàlides VALUES ("HtFG","17","75");
INSERT INTO TblVàlides VALUES ("HtFH","14","78");
INSERT INTO TblVàlides VALUES ("HtFI","15","78");
INSERT INTO TblVàlides VALUES ("HtFK","15","79");
INSERT INTO TblVàlides VALUES ("HtGH","14","81");
INSERT INTO TblVàlides VALUES ("HtGI","15","81");
INSERT INTO TblVàlides VALUES ("HtGK","15","82");
INSERT INTO TblVàlides VALUES ("HtHI","08","84");
INSERT INTO TblVàlides VALUES ("HtHK","09","84");
INSERT INTO TblVàlides VALUES ("HtIK","10","84");
INSERT INTO TblVàlides VALUES ("IKtB","11","28");
INSERT INTO TblVàlides VALUES ("IKtC","11","49");
INSERT INTO TblVàlides VALUES ("IKtD","11","64");
INSERT INTO TblVàlides VALUES ("IKtE","11","74");
INSERT INTO TblVàlides VALUES ("IKtF","11","80");
INSERT INTO TblVàlides VALUES ("IKtG","11","83");
INSERT INTO TblVàlides VALUES ("IKtH","11","84");
INSERT INTO TblVàlides VALUES ("IKtI","12","28");
INSERT INTO TblVàlides VALUES ("IKtK","13","28");
INSERT INTO TblVàlides VALUES ("ItBC","17","06");
INSERT INTO TblVàlides VALUES ("ItBD","17","12");
INSERT INTO TblVàlides VALUES ("ItBE","17","17");
INSERT INTO TblVàlides VALUES ("ItBF","17","21");
INSERT INTO TblVàlides VALUES ("ItBG","17","24");
INSERT INTO TblVàlides VALUES ("ItBH","17","26");
INSERT INTO TblVàlides VALUES ("ItBI","14","28");
INSERT INTO TblVàlides VALUES ("ItBK","15","28");
INSERT INTO TblVàlides VALUES ("ItCD","17","33");
INSERT INTO TblVàlides VALUES ("ItCE","17","38");
INSERT INTO TblVàlides VALUES ("ItCF","17","42");
INSERT INTO TblVàlides VALUES ("ItCG","17","45");
INSERT INTO TblVàlides VALUES ("ItCH","17","47");
INSERT INTO TblVàlides VALUES ("ItCI","14","49");
INSERT INTO TblVàlides VALUES ("ItCK","15","49");
INSERT INTO TblVàlides VALUES ("ItDE","17","53");
INSERT INTO TblVàlides VALUES ("ItDF","17","57");
INSERT INTO TblVàlides VALUES ("ItDG","17","60");
INSERT INTO TblVàlides VALUES ("ItDH","17","62");
INSERT INTO TblVàlides VALUES ("ItDI","14","64");
INSERT INTO TblVàlides VALUES ("ItDK","15","64");
INSERT INTO TblVàlides VALUES ("ItEF","17","67");
INSERT INTO TblVàlides VALUES ("ItEG","17","70");
INSERT INTO TblVàlides VALUES ("ItEH","17","72");
INSERT INTO TblVàlides VALUES ("ItEI","14","74");
INSERT INTO TblVàlides VALUES ("ItEK","15","74");
INSERT INTO TblVàlides VALUES ("ItFG","17","76");
INSERT INTO TblVàlides VALUES ("ItFH","17","78");
INSERT INTO TblVàlides VALUES ("ItFI","14","80");
INSERT INTO TblVàlides VALUES ("ItFK","15","80");
INSERT INTO TblVàlides VALUES ("ItGH","17","81");
INSERT INTO TblVàlides VALUES ("ItGI","14","83");
INSERT INTO TblVàlides VALUES ("ItGK","15","83");
INSERT INTO TblVàlides VALUES ("ItHI","14","84");
INSERT INTO TblVàlides VALUES ("ItHK","15","84");
INSERT INTO TblVàlides VALUES ("ItIK","16","28");
INSERT INTO TblVàlides VALUES ("KtBC","17","07");
INSERT INTO TblVàlides VALUES ("KtBD","17","13");
INSERT INTO TblVàlides VALUES ("KtBE","17","18");
INSERT INTO TblVàlides VALUES ("KtBF","17","22");
INSERT INTO TblVàlides VALUES ("KtBG","17","25");
INSERT INTO TblVàlides VALUES ("KtBH","17","27");
INSERT INTO TblVàlides VALUES ("KtBI","17","28");
INSERT INTO TblVàlides VALUES ("KtBK","18","07");
INSERT INTO TblVàlides VALUES ("KtCD","17","34");
INSERT INTO TblVàlides VALUES ("KtCE","17","39");
INSERT INTO TblVàlides VALUES ("KtCF","17","43");
INSERT INTO TblVàlides VALUES ("KtCG","17","46");
INSERT INTO TblVàlides VALUES ("KtCH","17","48");
INSERT INTO TblVàlides VALUES ("KtCI","17","49");
INSERT INTO TblVàlides VALUES ("KtCK","18","34");
INSERT INTO TblVàlides VALUES ("KtDE","17","54");
INSERT INTO TblVàlides VALUES ("KtDF","17","58");
INSERT INTO TblVàlides VALUES ("KtDG","17","61");
INSERT INTO TblVàlides VALUES ("KtDH","17","63");
INSERT INTO TblVàlides VALUES ("KtDI","17","64");
INSERT INTO TblVàlides VALUES ("KtDK","18","54");
INSERT INTO TblVàlides VALUES ("KtEF","17","68");
INSERT INTO TblVàlides VALUES ("KtEG","17","71");
INSERT INTO TblVàlides VALUES ("KtEH","17","73");
INSERT INTO TblVàlides VALUES ("KtEI","17","74");
INSERT INTO TblVàlides VALUES ("KtEK","18","68");
INSERT INTO TblVàlides VALUES ("KtFG","17","77");
INSERT INTO TblVàlides VALUES ("KtFH","17","79");
INSERT INTO TblVàlides VALUES ("KtFI","17","80");
INSERT INTO TblVàlides VALUES ("KtFK","18","77");
INSERT INTO TblVàlides VALUES ("KtGH","17","82");
INSERT INTO TblVàlides VALUES ("KtGI","17","83");
INSERT INTO TblVàlides VALUES ("KtGK","18","82");
INSERT INTO TblVàlides VALUES ("KtHI","17","84");
INSERT INTO TblVàlides VALUES ("KtHK","18","84");
INSERT INTO TblVàlides VALUES ("KtIK","19","28");
INSERT INTO TblVàlides VALUES ("tBCD","20","01");
INSERT INTO TblVàlides VALUES ("tBCE","20","02");
INSERT INTO TblVàlides VALUES ("tBCF","20","03");
INSERT INTO TblVàlides VALUES ("tBCG","20","04");
INSERT INTO TblVàlides VALUES ("tBCH","20","05");
INSERT INTO TblVàlides VALUES ("tBCI","20","06");
INSERT INTO TblVàlides VALUES ("tBCK","20","07");
INSERT INTO TblVàlides VALUES ("tBDE","20","08");
INSERT INTO TblVàlides VALUES ("tBDF","20","09");
INSERT INTO TblVàlides VALUES ("tBDG","20","10");
INSERT INTO TblVàlides VALUES ("tBDH","20","11");
INSERT INTO TblVàlides VALUES ("tBDI","20","12");
INSERT INTO TblVàlides VALUES ("tBDK","20","13");
INSERT INTO TblVàlides VALUES ("tBEF","20","14");
INSERT INTO TblVàlides VALUES ("tBEG","20","15");
INSERT INTO TblVàlides VALUES ("tBEH","20","16");
INSERT INTO TblVàlides VALUES ("tBEI","20","17");
INSERT INTO TblVàlides VALUES ("tBEK","20","18");
INSERT INTO TblVàlides VALUES ("tBFG","20","19");
INSERT INTO TblVàlides VALUES ("tBFH","20","20");
INSERT INTO TblVàlides VALUES ("tBFI","20","21");
INSERT INTO TblVàlides VALUES ("tBFK","20","22");
INSERT INTO TblVàlides VALUES ("tBGH","20","23");
INSERT INTO TblVàlides VALUES ("tBGI","20","24");
INSERT INTO TblVàlides VALUES ("tBGK","20","25");
INSERT INTO TblVàlides VALUES ("tBHI","20","26");
INSERT INTO TblVàlides VALUES ("tBHK","20","27");
INSERT INTO TblVàlides VALUES ("tBIK","20","28");
INSERT INTO TblVàlides VALUES ("tCDE","20","29");
INSERT INTO TblVàlides VALUES ("tCDF","20","30");
INSERT INTO TblVàlides VALUES ("tCDG","20","31");
INSERT INTO TblVàlides VALUES ("tCDH","20","32");
INSERT INTO TblVàlides VALUES ("tCDI","20","33");
INSERT INTO TblVàlides VALUES ("tCDK","20","34");
INSERT INTO TblVàlides VALUES ("tCEF","20","35");
INSERT INTO TblVàlides VALUES ("tCEG","20","36");
INSERT INTO TblVàlides VALUES ("tCEH","20","37");
INSERT INTO TblVàlides VALUES ("tCEI","20","38");
INSERT INTO TblVàlides VALUES ("tCEK","20","39");
INSERT INTO TblVàlides VALUES ("tCFG","20","40");
INSERT INTO TblVàlides VALUES ("tCFH","20","41");
INSERT INTO TblVàlides VALUES ("tCFI","20","42");
INSERT INTO TblVàlides VALUES ("tCFK","20","43");
INSERT INTO TblVàlides VALUES ("tCGH","20","44");
INSERT INTO TblVàlides VALUES ("tCGI","20","45");
INSERT INTO TblVàlides VALUES ("tCGK","20","46");
INSERT INTO TblVàlides VALUES ("tCHI","20","47");
INSERT INTO TblVàlides VALUES ("tCHK","20","48");
INSERT INTO TblVàlides VALUES ("tCIK","20","49");
INSERT INTO TblVàlides VALUES ("tDEF","20","50");
INSERT INTO TblVàlides VALUES ("tDEG","20","51");
INSERT INTO TblVàlides VALUES ("tDEH","20","52");
INSERT INTO TblVàlides VALUES ("tDEI","20","53");
INSERT INTO TblVàlides VALUES ("tDEK","20","54");
INSERT INTO TblVàlides VALUES ("tDFG","20","55");
INSERT INTO TblVàlides VALUES ("tDFH","20","56");
INSERT INTO TblVàlides VALUES ("tDFI","20","57");
INSERT INTO TblVàlides VALUES ("tDFK","20","58");
INSERT INTO TblVàlides VALUES ("tDGH","20","59");
INSERT INTO TblVàlides VALUES ("tDGI","20","60");
INSERT INTO TblVàlides VALUES ("tDGK","20","61");
INSERT INTO TblVàlides VALUES ("tDHI","20","62");
INSERT INTO TblVàlides VALUES ("tDHK","20","63");
INSERT INTO TblVàlides VALUES ("tDIK","20","64");
INSERT INTO TblVàlides VALUES ("tEFG","20","65");
INSERT INTO TblVàlides VALUES ("tEFH","20","66");
INSERT INTO TblVàlides VALUES ("tEFI","20","67");
INSERT INTO TblVàlides VALUES ("tEFK","20","68");
INSERT INTO TblVàlides VALUES ("tEGH","20","69");
INSERT INTO TblVàlides VALUES ("tEGI","20","70");
INSERT INTO TblVàlides VALUES ("tEGK","20","71");
INSERT INTO TblVàlides VALUES ("tEHI","20","72");
INSERT INTO TblVàlides VALUES ("tEHK","20","73");
INSERT INTO TblVàlides VALUES ("tEIK","20","74");
INSERT INTO TblVàlides VALUES ("tFGH","20","75");
INSERT INTO TblVàlides VALUES ("tFGI","20","76");
INSERT INTO TblVàlides VALUES ("tFGK","20","77");
INSERT INTO TblVàlides VALUES ("tFHI","20","78");
INSERT INTO TblVàlides VALUES ("tFHK","20","79");
INSERT INTO TblVàlides VALUES ("tFIK","20","80");
INSERT INTO TblVàlides VALUES ("tGHI","20","81");
INSERT INTO TblVàlides VALUES ("tGHK","20","82");
INSERT INTO TblVàlides VALUES ("tGIK","20","83");
INSERT INTO TblVàlides VALUES ("tHIK","20","84");

/* 
* TRANSFORM First(TblVàlides.IdMultiplicacio) AS PrimerDeIdMultiplicacio
* SELECT TblVàlides.Columna
* FROM TblVàlides
* GROUP BY TblVàlides.Columna
* PIVOT TblVàlides.Cambra;
*/ 

SELECT TblVàlides.Columna,
   MAX(CASE WHEN Cambra = "01" THEN TblVàlides.IdMultiplicacio END) AS "01",
   MAX(CASE WHEN Cambra = "02" THEN TblVàlides.IdMultiplicacio END) AS "02",
   MAX(CASE WHEN Cambra = "03" THEN TblVàlides.IdMultiplicacio END) AS "03",
   MAX(CASE WHEN Cambra = "04" THEN TblVàlides.IdMultiplicacio END) AS "04",
   MAX(CASE WHEN Cambra = "05" THEN TblVàlides.IdMultiplicacio END) AS "05",
   MAX(CASE WHEN Cambra = "06" THEN TblVàlides.IdMultiplicacio END) AS "06",
   MAX(CASE WHEN Cambra = "07" THEN TblVàlides.IdMultiplicacio END) AS "07",
   MAX(CASE WHEN Cambra = "08" THEN TblVàlides.IdMultiplicacio END) AS "08",
   MAX(CASE WHEN Cambra = "09" THEN TblVàlides.IdMultiplicacio END) AS "09",
   MAX(CASE WHEN Cambra = "10" THEN TblVàlides.IdMultiplicacio END) AS "10",
   MAX(CASE WHEN Cambra = "11" THEN TblVàlides.IdMultiplicacio END) AS "11",
   MAX(CASE WHEN Cambra = "12" THEN TblVàlides.IdMultiplicacio END) AS "12",
   MAX(CASE WHEN Cambra = "13" THEN TblVàlides.IdMultiplicacio END) AS "13",
   MAX(CASE WHEN Cambra = "14" THEN TblVàlides.IdMultiplicacio END) AS "14",
   MAX(CASE WHEN Cambra = "15" THEN TblVàlides.IdMultiplicacio END) AS "15",
   MAX(CASE WHEN Cambra = "16" THEN TblVàlides.IdMultiplicacio END) AS "16",
   MAX(CASE WHEN Cambra = "17" THEN TblVàlides.IdMultiplicacio END) AS "17",
   MAX(CASE WHEN Cambra = "18" THEN TblVàlides.IdMultiplicacio END) AS "18",
   MAX(CASE WHEN Cambra = "19" THEN TblVàlides.IdMultiplicacio END) AS "19",
   MAX(CASE WHEN Cambra = "20" THEN TblVàlides.IdMultiplicacio END) AS "20" 
FROM TblVàlides
GROUP BY TblVàlides.Columna
ORDER BY TblVàlides.Columna;
