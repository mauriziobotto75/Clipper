PROCEDURE InsDisegno()
   APPEND BLANK
   @ 2,2 SAY "Codice Prodotto:" GET CODPROD
   @ 3,2 SAY "Cliente:" GET CLIENTE
   @ 4,2 SAY "Dimensione:" GET DIMENSIONE
   @ 5,2 SAY "Forma Corcos:" GET FORMCORCOS
   @ 6,2 SAY "Nome File:" GET NOMEFILE
   @ 7,2 SAY "Estensione:" GET ESTENSIONE
   @ 8,2 SAY "Descrizione:" GET DESCRIZIONE
   @ 9,2 SAY "Tipo Disegno:" GET TIPO
   @10,2 SAY "Attivo (S/N):" GET ATTIVO PICTURE "@!"

   READ
   IF LASTKEY() != 27
      COMMIT
   ELSE
      ROLLBACK
   ENDIF
RETURN
``
