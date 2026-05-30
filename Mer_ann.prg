**************************ANNULLAMENTO MERCI***********************************
**********                    MER_ANN                                  ********
*                                                                            **
*                                                                            **
*SCRITTO DA BOTTO MAURIZIO                                                    *
*                                                                             *
*                                                                             *
 
SET BELL OFF
SET COLOR TO BG/BR, BR/BG
SET ECHO OFF
SET TALK OFF
W_RISP="S"
W_COD_MERC=0
@0,0 CLEAR
SELECT 2
USE A:MERCI.DBF INDEX A:MERCIX.IDX

@7,10 SAY "CODICE MERCE:"
@7,48 GET W_COD_MERC PICTURE "99999"
READ
           DO WHILE W_COD_MERC <>0
             GO TOP
             LOCATE FOR COD_MERC = W_COD_MERC
         
 
             if .not. eof()
                 @12,15 SAY DES_MERC
                 @13,15 SAY PREZ_MERC
                 @14,15 SAY GIAC_MERC
                 @23,15 SAY "VUOI ANNULLARE(S/N)?   "
                 @23,45 GET W_RISP  PICTURE "x"
                 READ
                 IF UPPER(W_RISP)="S"
                     DELETE
                     PACK
                 ENDIF
             else
                 @9,10 say "CODICE NON TROVATO"   
             endif
                 
            @9,10 clear
            @7,10 SAY "CODICE MERCE"
            @7,48 GET W_COD_MERC PICTURE "99999"  
            READ                
          
         ENDDO
CLOSE DATA
RETURN
