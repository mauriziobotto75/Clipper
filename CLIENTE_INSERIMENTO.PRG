//piccolo esempio maschera di input con creazione e inserimento valori all'interno del DBF anagrafica
PROCEDURE Main ()
    //comando per creare la struttura della tabella 
    CREATE TempStru
    APPEND BLANK //aggiungo nella tabella temporanea  necessario append blank per la creazione delle definizioni dei nuovi campi
    REPLACE Field_name WITH “COD_CLIENTE”,;
            Field_type WITH “N”,;
            Field_len WITH  5,;
            Field_dec WITH  0
    REPLACE Field_name WITH "NOME",;
           Field_type WITH "C",;
           Field_len WITH 25,;
           Field_dec WITH 0
    APPEND BLANK
    REPLACE Field_name WITH "COGNOME",;
           Field_type WITH "C",;
           Field_len WITH 25,;
           Field_dec WITH 0
    APPEND BLANK
    REPLACE Field_name WITH "ETA",;
           Field_type WITH "N",;
           Field_len WITH 3,;
           Field_dec WITH 0
    CLOSE

    //comando per creare il file DBF
    CREATE anagrafica FROM TempStru
   CLS
   cCognome = SPACE(20)
   cNome = SPACE(20)
   nEta = 0
   cCodice = 0
   @ 05,18 SAY “INSERISCI COD. CLIENTE (0 – PER FINIRE)” COLOR "w+/n" 
           get cCodice COLOR "rg+/r"
           READ 

           DO WHILE cCodice <> 0
              @ 07,18 TO 13,63 DOUBLE COLOR "g+/n"
       	   @ 08,20 SAY "Inserire il cognome  " COLOR "w+/n" get       		          cCognome COLOR "rg+/r"
              @ 10,20 SAY "Inserire il nome     " COLOR "w+/n" get cNome      			COLOR "rg+/r"
   		   @ 12,20 SAY "Inserire l'eta       " COLOR "rg+/n" get nEta 			COLOR "w+/b"
           READ
               USE anagrafica ALIAS anag
               APPEND BLANK
               REPLACE anag->COGNOME WITH cCognome
               REPLACE anag->NOME WITH cNome
               REPLACE anag->ETA  WITH nEta
    @ 05,18 SAY “INSERISCI COD. CLIENTE (0 – PER FINIRE)”      COLOR   "w+/n" 
           		get cCodice COLOR "rg+/r"
           		READ 
           ENDDO

   
RETURN
