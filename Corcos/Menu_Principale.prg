PROCEDURE MenuPrincipale()
   LOCAL nScelta := 0

   CLS
   @ 2,10 SAY "GESTIONE DISEGNI CORCOS"
   @ 4,10 SAY "1 - Inserimento Disegno"
   @ 5,10 SAY "2 - Ricerca Disegni"
   @ 6,10 SAY "3 - Stampa Disegni"
   @ 7,10 SAY "0 - Uscita"

   @ 9,10 GET nScelta
   READ

   DO CASE
      CASE nScelta == 1
         InsDisegno()
      CASE nScelta == 2
         MenuRicerca()
      CASE nScelta == 3
         StampaDisegni()
      CASE nScelta == 0
         QUIT
   ENDCASE
RETURN
