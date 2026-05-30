************************INSERIMENTO CLIENTI ***********************************
*****                           CLI_INS                                   *****
*                                                                             *
*                                                                             *
*SCRITTO DA BOTTO MAURIZIO                                                    *
*                                                                             *
*                                                                             *

SET BELL OFF
SET COLOR TO BG/BR, BR/BG
SET ECHO OFF
SET TALK OFF
@0,0 CLEAR
SELECT 1
USE A:\CLIENTI.dbf
GO TOP
W_COD_CLI=0
W_NOM_CLI=SPACE(30)
W_IND_CLI=SPACE(20)
W_P_IVA_CLI=SPACE(11)
W_RAG_SOC=SPACE(10)
@7,10 SAY "CODICE CLIENTE:(Batti 0 per finire)"
@7,48 GET W_COD_CLI  PICTURE "99999"
READ
      
      DO WHILE W_COD_CLI<>0
           @10,10 SAY "NOME CLIENTE"
           @10,48 GET W_NOM_CLI PICTURE  "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
           @12,10 SAY "INDIRIZZO CLIENTE"
           @12,48 GET W_IND_CLI PICTURE "XXXXXXXXXXXXXXXXXXXX"
           @14,10 SAY "PARTITA IVA CLIENTE"
           @14,48 GET W_P_IVA_CLI PICTURE "XXXXXXXXXXX"
           @16,10 SAY "RAGIONE SOCIALE"
           @16,48 GET W_RAG_SOC PICTURE  "XXXXXXXXXX"
           READ
           APPEND BLANK
           REPLACE COD_CLI WITH W_COD_CLI
           REPLACE NOM_CLI WITH W_NOM_CLI
           REPLACE IND_CLI WITH W_IND_CLI
           REPLACE P_IVA_CLI WITH W_P_IVA_CLI
           REPLACE RAG_CLI WITH W_RAG_SOC
              @7,10 SAY "CODICE CLIENTE:(Batti 0 per finire)"
              @7,48 GET W_COD_CLI  PICTURE "99999"
              READ
       ENDDO        
  
CLOSE DATA
RETURN
