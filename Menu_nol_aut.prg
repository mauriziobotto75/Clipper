************************     SCHERMO AUTOMOBILI *******************************
*****                           SCHERMO1                                  *****
*                                                                             *
*SCRITTO DA BOTTO MAURIZIO                                                    *
*                                                                             *
*                                                                             *
SET BELL OFF
SET COLOR TO BG/BR, BR/BG
SET ECHO OFF
SET TALK OFF
W_SCELTA=0
@0,0 CLEAR
@3,31 SAY 'GESTIONE NOLEGGIO AUTOMOBILI'
@4,35 SAY 'DITTA BOTTO s.r.l   '
@7,21 SAY '1 - INSERIMENTO AUTO '
@09,21 SAY '2 - AGGIORNAMENTO AUTO '
@11,21 SAY '3 - VISUALIZZAZIONE AUTO'
@13,21 SAY '4 - STAMPA AUTO   '
@15,21 SAY '0 - FINE '
@19,21 SAY 'SCELTA     '
@19,30 GET W_SCELTA PICture "9"
read
      DO WHILE W_SCELTA <> 0
                 IF  W_SCELTA = 1
                     DO INS_AUT
              
                 ELSEIF  W_SCELTA = 3
                      do vis_aut
                 ENDIF
       @7,21 SAY '1 - INSERIMENTO AUTO '
       @09,21 SAY '2 - AGGIORNAMENTO AUTO '
       @11,21 SAY '3 - VISUALIZZAZIONE AUTO'
       @13,21 SAY '4 - STAMPA AUTO   '
       @15,21 SAY '0 - FINE '
       @19,21 SAY 'SCELTA     '
       @19,30 GET W_SCELTA PICture "9"
       read
      ENDDO
CLOSE DATA
RETURN 
