************************* SCHERMO GESTIONE NOLEGGIO ***************************
*****                           GES_NOL                                 *******
*                                                                             *
*                                                                             *
*SCRITTO DA BOTTO MAURIZIO                                                    *
*                                                                             *
*                                                                             *
SET BELL OFF
SET COLOR TO B/W, W/B
SET ECHO OFF
SET TALK OFF
W_SCELTA=0
@0,0 CLEAR

@2,10 TO 22,70 DOUBLE
@2,10 TO 5,70 DOUBLE
@7,15 say "1 - CARICAMENTO NOLEGGIO"
@9,15 SAY "2 - AGGIORNAMENTO NOLEGGIO"
@11,15 SAY "3 - VISUALIZZAZIONE NOLEGGIO"
@13,15 SAY "4 - STAMPA NOLEGGI"
@15,15 SAY "0 - FINE"
@17,15 SAY "SCELTA" GET W_SCELTA PICTURE "9"
READ
      DO WHILE .NOT. W_SCELTA=0
         DO CASE
            CASE W_SCELTA=1
                 DO CAR_NOL.PRG
            CASE W_SCELTA=2
                 DO AGG_NOL.PRG
            CASE W_SCELTA=3
                 DO VIS_NOL.PRG
            CASE W_SCELTA=4
                 DO STA_NOL.PRG
            OTHERWISE
                 @18,15 SAY "DEVI INSERIRE UN VALORE TRA 0 E 4"     
           
          ENDCASE
       @7,15 say "1 - CARICAMENTO NOLEGGIO"
       @9,15 SAY "2 - AGGIORNAMENTO NOLEGGIO"
       @11,15 SAY "3 - VISUALIZZAZIONE NOLEGGIO"
       @13,15 SAY "4 - STAMPA NOLEGGI"
       @15,15 SAY "0 - FINE"
       @17,15 SAY "SCELTA" GET W_SCELTA PICTURE "9"
       READ
       ENDDO
RETURN
clear screen
