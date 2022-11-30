************************VISUALIZZAZIONE CLIENTI *******************************
*****                           CLI_VISU                                  *****
*                                                                             *
*SCRITTO DA BOTTO MAURIZIO                                                    *
*                                                                             *
*                                                                             *

SET BELL OFF
SET COLOR TO BG/BR, BR/BG
SET ECHO OFF
SET TALK OFF
W_RISP="S"
W_COD_CLI = 0
@0,0 CLEAR
SELECT 1
USE A:\CLIENTI.DBF
 
@5,10 say "CODICE CLIENTE "
@5,42 GET W_COD_CLI  PICTURE "99999"
READ
       DO WHILE W_COD_CLI <> 0
         GO TOP
         LOCATE FOR COD_CLI = W_COD_CLI  
           @5,10 SAY "CODICE CLIENTE" 
           @5,42 SAY COD_CLI
           @7,10 SAY "NOME CLIENTE"
           @7,42 SAY NOM_CLI
           @11,10 SAY "VENDITE CLIENTE"
           @11,42 SAY QUANT_VEND
           @11,10 SAY "INDIRIZZO CLIENTE"
           @15,42 SAY IND_CLI
           @19,10 SAY "TELEFONO CLIENTE"
           @19,20 SAY TEL_CLI
           @20,15 SAY "VUOI CONTINUARE(S/N)?   "
           @20,30 GET W_RISP  PICTURE "x"
           READ
           IF W_RISP="S"
              @5,10 say "CODICE CLIENTE "
              @5,42 GET W_COD_CLI  PICTURE "99999"
              READ
           ELSE
              IF W_RISP="N"
                 EXIT 
              ENDIF
           ENDIF
              
       ENDDO
CLOSE DATA
RETURN
