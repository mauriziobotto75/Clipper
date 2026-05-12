* ============================================================
*  GESTIONALE.PRG
*  Creazione Database GESTIONALE.DBC con tabelle e relazioni
* ============================================================

SET SAFETY OFF
SET EXCLUSIVE ON
SET DELETED ON

* === Percorso Output ===
lcDir = FULLPATH(".\\DB_GESTIONALE\\")
IF !DIRECTORY(lcDir)
    MD (lcDir)
ENDIF
CD (lcDir)

* --- Se esiste già, lo elimino ---
IF FILE("GESTIONALE.DBC")
    DELETE FILE GESTIONALE.DBC
    DELETE FILE GESTIONALE.DCT
    DELETE FILE GESTIONALE.DCX
ENDIF

* === Creazione Database ===
CREATE DATABASE GESTIONALE
OPEN DATABASE GESTIONALE EXCL


* ============================================================
* FUNZIONE DI SUPPORTO: Crea tabella DBF dentro al DBC
* ============================================================
PROCEDURE MakeTable
    LPARAMETERS tcName, tcStruct
    IF FILE(tcName + ".DBF")
        DELETE FILE (tcName + ".DBF")
    ENDIF
    CREATE TABLE (tcName) &tcStruct
ENDPROC


* ============================================================
* TABELLE
* ============================================================

* ------------------------------------------------------------
* CLIENTI
* ------------------------------------------------------------
MakeTable("CLIENTI", ;
"(CLI_ID I AUTOINC PRIMARY KEY, RAGSOC C(80), PIVA C(16), CFISC C(16), ;
  INDIR C(80), CAP C(5), CITTA C(40), PROV C(2), TEL C(20), EMAIL C(80), ;
  IDPAG I NULL, NOTE M)")

INDEX ON CLI_ID TAG CLI_ID
INDEX ON UPPER(RAGSOC) TAG RAGSOC

* ------------------------------------------------------------
* FORNITORI
* ------------------------------------------------------------
MakeTable("FORNITOR", ;
"(FOR_ID I AUTOINC PRIMARY KEY, RAGSOC C(80), PIVA C(16), CFISC C(16), ;
  INDIR C(80), CAP C(5), CITTA C(40), PROV C(2), TEL C(20), EMAIL C(80), ;
  IDPAG I NULL, NOTE M)")

INDEX ON FOR_ID TAG FOR_ID
INDEX ON UPPER(RAGSOC) TAG RAGSOC

* ------------------------------------------------------------
* PAGAMENTI
* ------------------------------------------------------------
MakeTable("PAGAMENT", ;
"(PAG_ID I AUTOINC PRIMARY KEY, DESCR C(60), NUMRATE I, GG1 I, GG2 I, GG3 I, ;
  FINEMES L, SCOSTA I, NOTE M)")

INDEX ON PAG_ID TAG PAG_ID


* ------------------------------------------------------------
* ARTICOLI (Nuova Tabella)
* ------------------------------------------------------------
MakeTable("ARTICOLI", ;
"(ART_ID I AUTOINC PRIMARY KEY, CODART C(30), DESCR C(80), UM C(6), ;
  PREZZO N(14,2), IVA_ALI N(5,2), BARCODE C(20), ATTIVO L, CATEG C(30))")

INDEX ON ART_ID TAG ART_ID
INDEX ON UPPER(CODART) TAG CODART UNIQUE
INDEX ON UPPER(DESCR) TAG DESCR


* ------------------------------------------------------------
* ORDINI
* ------------------------------------------------------------
MakeTable("ORDINI", ;
"(ORD_ID I AUTOINC PRIMARY KEY, DATA D, IDCLI I, RIF C(30), ;
  DATCONS D, STATO C(1), NOTE M)")

INDEX ON ORD_ID TAG ORD_ID
INDEX ON IDCLI TAG IDCLI


* ------------------------------------------------------------
* BOLLE (DDT)
* ------------------------------------------------------------
MakeTable("BOLLE", ;
"(BOL_ID I AUTOINC PRIMARY KEY, DATA D, NUMDOC C(20), IDCLI I, ;
  IDFOR I, IDORD I, NOTE M)")

INDEX ON BOL_ID TAG BOL_ID
INDEX ON NUMDOC TAG NUMDOC


* ------------------------------------------------------------
* FATTURE ATTIVE
* ------------------------------------------------------------
MakeTable("FAT_ATT", ;
"(FAA_ID I AUTOINC PRIMARY KEY, NUMDOC C(20), DATA D, IDCLI I, ;
  IDPAG I, IMPON N(14,2), IVA N(14,2), TOTALE N(14,2), ;
  SALDATO L, NOTE M)")

INDEX ON FAA_ID TAG FAA_ID
INDEX ON NUMDOC TAG NUMDOC


* ------------------------------------------------------------
* FATTURE PASSIVE
* ------------------------------------------------------------
MakeTable("FAT_PAS", ;
"(FAP_ID I AUTOINC PRIMARY KEY, NUMDOC C(20), DATA D, IDFOR I, ;
  IDPAG I, IMPON N(14,2), IVA N(14,2), TOTALE N(14,2), ;
  SALDATO L, NOTE M)")

INDEX ON FAP_ID TAG FAP_ID
INDEX ON NUMDOC TAG NUMDOC


* ------------------------------------------------------------
* SCADENZE
* ------------------------------------------------------------
MakeTable("SCADENZE", ;
"(SCA_ID I AUTOINC PRIMARY KEY, TIPO C(1), IDDOC I, NUMRATA I, ;
  DTSCAD D, IMPORTO N(14,2), PAGATA L, DTPAG D, NOTE M)")

INDEX ON SCA_ID TAG SCA_ID
INDEX ON TIPO + STR(IDDOC,10) TAG DOC


* ------------------------------------------------------------
* RIGHE DOCUMENTO
* ------------------------------------------------------------
MakeTable("RIGHE_DOC", ;
"(RIG_ID I AUTOINC PRIMARY KEY, TIPO C(1), IDDOC I, RIGA I, ;
  IDART I, CODART C(30), DESCR C(80), ;
  QTA N(14,3), PREZZO N(14,2), SCONTO N(6,2), IVA N(5,2), TOTALE N(14,2))")

INDEX ON RIG_ID TAG RIG_ID
INDEX ON TIPO + STR(IDDOC,10) + STR(RIGA,4) TAG RIFRIGA
INDEX ON IDART TAG IDART


* ============================================================
* RELAZIONI NEL DATABASE (RI)
* ============================================================

* Attiva la RI
SET DATABASE TO GESTIONALE
DBSETPROP("GESTIONALE", "Database", "Version", "Visual FoxPro 09")

* CLIENTI ↔ ORDINI
ALTER TABLE ORDINI ADD FOREIGN KEY IDCLI ;
    REFERENCES CLIENTI (CLI_ID) ;
    ON DELETE RESTRICT ON UPDATE CASCADE

* CLIENTI ↔ FATTURE ATTIVE
ALTER TABLE FAT_ATT ADD FOREIGN KEY IDCLI ;
    REFERENCES CLIENTI (CLI_ID) ;
    ON DELETE RESTRICT ON UPDATE CASCADE

* PAGAMENTI ↔ CLIENTI/FORNITOR/FATTURE
ALTER TABLE CLIENTI ADD FOREIGN KEY IDPAG REFERENCES PAGAMENT (PAG_ID)
ALTER TABLE FORNITOR ADD FOREIGN KEY IDPAG REFERENCES PAGAMENT (PAG_ID)
ALTER TABLE FAT_ATT ADD FOREIGN KEY IDPAG REFERENCES PAGAMENT (PAG_ID)
ALTER TABLE FAT_PAS ADD FOREIGN KEY IDPAG REFERENCES PAGAMENT (PAG_ID)

* FORNITORI ↔ FATTURE PASSIVE
ALTER TABLE FAT_PAS ADD FOREIGN KEY IDFOR ;
    REFERENCES FORNITOR(FOR_ID)

* ORDINI ↔ BOLLE
ALTER TABLE BOLLE ADD FOREIGN KEY IDORD REFERENCES ORDINI (ORD_ID)

* ARTICOLI ↔ RIGHE DOCUMENTO
ALTER TABLE RIGHE_DOC ADD FOREIGN KEY IDART REFERENCES ARTICOLI (ART_ID)

* DOCUMENTO GENERICO ↔ RIGHE_DOCUMENTO
* (Tipo definisce a quale tabella appartiene)
* FoxPro non supporta FK condizionali → si gestisce lato applicazione


* ============================================================
? "Database GESTIONALE.DBC creato con successo!"
RETURN
