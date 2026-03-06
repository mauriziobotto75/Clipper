PROCEDURE NewConto()
LOCAL cConto := Space(12), cDesc := Space(60), cTipo := "A"
LOCAL nLiv := 2, cPadre := "", cRag := "", cSez := "SP", cIva := "", lBlocco := .F.
LOCAL dCre := Date(), cUte := getenv("USERNAME")

CLS
@ 0,2 SAY "Nuovo Conto - Inserire CODICE (formato CC.SS o CC.SS.PP) + Descrizione"
@ 2,2 SAY "Codice:" ; @ 2,20 GET cConto PICTURE "@!" VALID IsValidContoCode( cConto ) .AND. ! ContoExists( cConto )
@ 3,2 SAY "Descrizione:" ; @ 3,20 GET cDesc PICTURE "@S50"
READ
IF LastKey() == K_ESC ; RETURN ; ENDIF

nLiv := LevelFromCode( cConto )
cPadre:= ParentFromCode( cConto )
InferTipoSezione( cConto, @cTipo, @cSez )

// opzionali
@ 5,2 SAY "Raggrupp.:" ; @ 5,20 GET cRag PICTURE "@!"
@ 6,2 SAY "IVA default:" ; @ 6,20 GET cIva PICTURE "@!"
@ 7,2 SAY "Blocco:" ; @ 7,20 GET lBlocco
READ
IF LastKey() == K_ESC ; RETURN ; ENDIF

APPEND BLANK
REPLACE CONTO WITH AllTrim( cConto )
REPLACE DESCR WITH AllTrim( cDesc )
REPLACE TIPO WITH cTipo
REPLACE LIVELLO WITH nLiv
REPLACE PADRE WITH cPadre
REPLACE RAGGR WITH AllTrim( cRag )
REPLACE SEZBIL WITH cSez
REPLACE IVADEF WITH AllTrim( cIva )
REPLACE BLOCCO WITH lBlocco
REPLACE DTCREA WITH dCre
REPLACE UTECREA WITH cUte
DBCommit()
RETURN
