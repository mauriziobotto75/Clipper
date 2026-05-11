PROCEDURE MenuRicerca()
   LOCAL nScelta := 0

   CLS
   @ 2,5 SAY "RICERCA DISEGNI"
   @ 4,5 SAY "1 - Per Codice Prodotto"
   @ 5,5 SAY "2 - Per Cliente"
   @ 6,5 SAY "3 - Per Forma Corcos"
   @ 7,5 SAY "4 - Per Dimensione"
   @ 8,5 SAY "5 - Ricerca Incrociata"
   @ 9,5 SAY "0 - Ritorna"

   @11,5 GET nScelta
   READ

   DO CASE
      CASE nScelta == 1
         SET ORDER TO CODPROD
         SEEK InputBox("Codice prodotto")
         BROWSE()
      CASE nScelta == 2
         SET ORDER TO CLIENTE
         SEEK InputBox("Cliente")
         BROWSE()
      CASE nScelta == 5
         RicercaIncrociata()
   ENDCASE
RETURN

PROCEDURE RicercaIncrociata()
   LOCAL cMin, cMax
   cMin := InputBox("Valore MIN")
   cMax := InputBox("Valore MAX")

   SET FILTER TO CODPROD >= cMin .AND. CODPROD <= cMax
   BROWSE()
   SET FILTER TO
RETURN
