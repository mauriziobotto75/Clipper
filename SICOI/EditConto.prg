PROCEDURE EditConto()
LOCAL cConto := CONTO, cDesc := DESCR, cTipo := TIPO
LOCAL nLiv := LIVELLO, cPadre := PADRE, cRag := RAGGR, cSez := SEZBIL
LOCAL cIva := IVADEF, lBlocco := BLOCCO

IF lBlocco
MsgStop( "Conto bloccato: modifica non consentita." )
RETURN
ENDIF

CLS
@ 0,2 SAY "Modifica Conto"
@ 2,2 SAY "Codice:" ; @ 2,20 GET cConto PICTURE "@!" VALID IsValidContoCode( cConto )
@ 3,2 SAY "Descrizione:" ; @ 3,20 GET cDesc PICTURE "@S50"
READ
IF LastKey() == K_ESC ; RETURN ; ENDIF

// Ricalcola padre/livello/Tipo/Sezione dal codice aggiornato
nLiv := LevelFromCode( cConto )
cPadre := ParentFromCode( cConto )
InferTipoSezione( cConto, @cTipo, @cSez )

@ 5,2 SAY "Raggrupp.:" ; @ 5,20 GET cRag PICTURE "@!"
@ 6,2 SAY "IVA default:" ; @ 6,20 GET cIva PICTURE "@!"
@ 7,2 SAY "Blocco:" ; @ 7,20 GET lBlocco
READ
IF LastKey() == K_ESC ; RETURN ; ENDIF

REPLACE CONTO WITH AllTrim( cConto )
REPLACE DESCR WITH AllTrim( cDesc )
REPLACE TIPO WITH cTipo
REPLACE LIVELLO WITH nLiv
REPLACE PADRE WITH cPadre
REPLACE RAGGR WITH AllTrim( cRag )
REPLACE SEZBIL WITH cSez
REPLACE IVADEF WITH AllTrim( cIva )
REPLACE BLOCCO WITH lBlocco
DBCommit()
RETURN
