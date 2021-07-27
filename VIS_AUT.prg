************************VISUALIZZAZIONE AUTOMOBILI*****************************
*****                           VIS_AUT                                   *****
*                                                                             *
*SCRITTO DA BOTTO MAURIZIO                                                    *
*                                                                             *
*                                                                             *
SET BELL OFF
SET COLOR TO BG/BR, BR/BG
SET ECHO OFF
SET TALK OFF
W_RISP="S"
w_cod_aut = 0
@0,0 CLEAR
SELECT 1
USE "c:clippeR5\BIN\AUTO.dbf"
 
@7,20 say "codice auto : "
@7,48 GET W_COD_AUT PICTURE "99999"
READ
        do while w_cod_aut <> 0 
            go top
            DO WHILE .NOT. EOF()
            LOCATE FOR COD_AUT=w_COD_AUT  
             
              @10,10 SAY  MOD_AUT PICTURE  "Xxxxxxxxxxxxxxxxxxxx"
              @12,10 SAY  MARC_AUT PICTURE "Xxxxxxxxxxxxxxxxxxxx" 
              @14,10 SAY  CIL_AUT PICTURE "Xxxxx"
              @16,10 SAY  NUM_AUT PICTURE  "99999" 
              @18,10 SAY  TAR_AUT PICTURE "9999999999"
              @20,10 SAY  VERS_AUT PICTURE "xxxxx"
              @21,10 SAY  N_PORT PICTURE   "99"
*             @22,48 SAY  KM_LIT PICTURE   "99"
              @23,10 SAY  CARAT_VERS PICTURE "xxxxxxxxxxxxxxx"
              @24,10 say "Vuoi visualizzare il prossimo(s/n)?"
              @24,50 get w_risp picture "X"
              READ
           
               IF W_RISP="n"
                  exit
                  
               else
                  continue
               ENDIF
             ENDDO
  
                 @7,20 say "codice auto : "
                 @7,48 GET W_COD_AUT PICTURE "99999"
                 READ
          ENDDO
CLOSE DATA
RETURN

