PROCEDURE StampaDisegni()
   LOCAL cCmd

   GO TOP
   DO WHILE ! EOF()
      IF ATTIVO
         cCmd := "PRINT " + NOMEFILE + "." + ESTENSIONE
         RUN (cCmd)
      ENDIF
      SKIP
   ENDDO
RETURN
