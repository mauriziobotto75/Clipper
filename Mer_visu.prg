************************VISUALIZZAZIONE MERCI *********************************
*****                           MER_VISU                                  *****
*                                                                             *
*SCRITTO DA BOTTO MAURIZIO                                                    *
*                                                                             *
*                                                                             *

SET BELL OFF
SET COLOR TO BG/BR, BR/BG
SET ECHO OFF
SET TALK OFF
W_RISP="S"
@0,0 CLEAR
SELECT 1
USE MERCI
GO TOP
DO MER_SCR1
           DO WHILE .NOT. EOF()
           @5,42 SAY COD_MERC
           @7,15 SAY DES_MERC
           @11,15 SAY PREZ_MERC
           @15,15 SAY GIAC_MERC
           @23,15 SAY "VUOI CONTINUARE(S/N)?   "
           GET W_RISP picture "X"
           READ
           IF W_RISP="S"
              DO MER_SCR1
                  
                      ELSE
              IF W_RISP="N"
              QUIT
           endif
           
ENDDO
CLOSE DATA
RETURN
DO MER_SCR1
CLOSE DATA
RETURN
