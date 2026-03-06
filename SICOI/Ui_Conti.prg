/* ui_conti.prg */

#include "inkey.ch"
#include "set.ch"

STATIC cConti := "CONTI"
STATIC cIva := "IVA"
STATIC cRaggr := "RAGGR"

PROCEDURE BrowseConti()
LOCAL nKey, oBrw, nTop := 1, nLeft := 1, nBottom := MaxRow()-3, nRight := MaxCol()-1
LOCAL lLoop := .T., cOldAlias := Alias()

SELECT ( cConti )
IF NetErr() .OR. Used() == .F.
USE ( hb_FNameMerge( "data", "", "conti.dbf" ) ) SHARED NEW ALIAS ( cConti )
ENDIF
ordSetFocus( "KCONT" )

CLS
@ 0,2 SAY "PIANO DEI CONTI - Browse (F2=Nuovo, Enter=Modifica, Del=Cancella, F5=Find, Esc=Indietro)"

oBrw := TBrowseNew( nTop, nLeft, nBottom, nRight )
oBrw:alias := cConti
oBrw:addColumn( TBColumnNew( "Conto", {|| CONTO } ) )
oBrw:addColumn( TBColumnNew( "Descrizione", {|| DESCR } ) )
oBrw:addColumn( TBColumnNew( "Tipo", {|| TIPO } ) )
oBrw:addColumn( TBColumnNew( "Liv", {|| STR( LIVELLO,1 ) } ) )
oBrw:addColumn( TBColumnNew( "Padre", {|| PADRE } ) )
oBrw:addColumn( TBColumnNew( "IVA", {|| IVADEF } ) )
oBrw:goTop()

DO WHILE lLoop
oBrw:forceStable()
nKey := Inkey( 0 )
DO CASE
CASE nKey == K_ESC
lLoop := .F.
CASE nKey == K_DOWN
oBrw:down()
CASE nKey == K_UP
oBrw:up()
CASE nKey == K_PGDN
oBrw:pageDown()
CASE nKey == K_PGUP
oBrw:pageUp()
CASE nKey == K_HOME
oBrw:goTop()
CASE nKey == K_END
oBrw:goBottom()
CASE nKey == K_F2 // nuovo
NewConto()
oBrw:refreshAll()
CASE nKey == K_ENTER // modifica
EditConto()
oBrw:refreshAll()
CASE nKey == K_DEL // cancellazione
DelConto()
oBrw:refreshAll()
CASE nKey == K_F5 // ricerca veloce
SeekConto()
oBrw:refreshAll()
ENDCASE
ENDDO

IF ! Empty( cOldAlias )
SELECT ( cOldAlias )
ENDIF
RETURN

// --------- Nuovo conto (wizard + form) ----------
PROCEDURE NewConto()
LOCAL cPadre := Space(12), cTipo := "A", nLiv := 1, cConto := Space(12)
LOCAL cDesc := Space(60), cRag := Space(4), cIva := Space(4), cSez := "SP"
LOCAL lBlocco := .F., dCre := Date(), cUte := getenv("USERNAME")

CLS
@ 0,2 SAY "Nuovo Conto - Wizard"
@ 2,2 SAY "Padre (vuoto se livello 1):"
@ 2,35 GET cPadre PICTURE "@!" VALID Empty(cPadre) .OR. ContoExists( cPadre )
@ 3,2 SAY "Livello [1..9]:"
@ 3,35 GET nLiv PICTURE "9" VALID nLiv >= 1 .AND. nLiv <= 9
@ 4,2 SAY "Tipo [A=Attivo,P=Passivo,C=Costi,R=Ricavi,M=Memor]:"
@ 4,60 GET cTipo PICTURE "@!" VALID cTipo $ "APCRM"
READ

IF LastKey() == K_ESC
RETURN
ENDIF

IF ! Empty( cPadre )
cConto := NextChildCode( cPadre )
IF Empty( cConto )
MsgStop( "Impossibile creare figlio per " + cPadre )
RETURN
ENDIF
ELSE
cConto := PadR( InputBox( "Codice conto (livello 1)", "100" ), 12 )
ENDIF

// Form di dettaglio
CLS
@ 0,2 SAY "Nuovo Conto - Dettaglio"
@ 2,2 SAY "Conto:" ; @ 2,20 GET cConto PICTURE "@!" VALID ! ContoExists( cConto )
@ 3,2 SAY "Descrizione:" ; @ 3,20 GET cDesc PICTURE "@S50"
@ 4,2 SAY "Tipo:" ; @ 4,20 GET cTipo PICTURE "@!" VALID cTipo $ "APCRM"
@ 5,2 SAY "Livello:" ; @ 5,20 GET nLiv PICTURE "9"
@ 6,2 SAY "Padre:" ; @ 6,20 GET cPadre PICTURE "@!" WHEN nLiv > 1 VALID ( nLiv == 1 .AND. Empty(cPadre) ) .OR. ContoExists( cPadre )
@ 7,2 SAY "Raggrupp.:" ; @ 7,20 GET cRag PICTURE "@!" VALID Empty(cRag) .OR. RaggrExists( cRag )
@ 8,2 SAY "Sezione bil:" ; @ 8,20 GET cSez PICTURE "@!" VALID cSez $ "SPCEFO"
@ 9,2 SAY "IVA default:" ; @ 9,20 GET cIva PICTURE "@!" WHEN cTipo $ "CR" VALID Empty(cIva) .OR. IvaExists( cIva )
@10,2 SAY "Blocco:" ; @10,20 GET lBlocco
READ

IF LastKey() == K_ESC
RETURN
ENDIF

APPEND BLANK
REPLACE CONTO WITH AllTrim( cConto )
REPLACE DESCR WITH AllTrim( cDesc )
REPLACE TIPO WITH cTipo
REPLACE LIVELLO WITH nLiv
REPLACE PADRE WITH AllTrim( cPadre )
REPLACE RAGGR WITH AllTrim( cRag )
REPLACE SEZBIL WITH cSez
REPLACE IVADEF WITH AllTrim( cIva )
REPLACE BLOCCO WITH lBlocco
REPLACE DTCREA WITH dCre
REPLACE UTECREA WITH cUte

ordSetFocus( "KCONT" )
DBCommit()
RETURN

// --------- Modifica conto ----------
PROCEDURE EditConto()
LOCAL cConto := CONTO, cDesc := DESCR, cTipo := TIPO
LOCAL nLiv := LIVELLO, cPadre := PADRE, cRag := RAGGR, cSez := SEZBIL
LOCAL cIva := IVADEF, lBlocco := BLOCCO

IF lBlocco
MsgStop( "Conto bloccato: modifica non consentita." )
RETURN
ENDIF

CLS
@ 0,2 SAY "Modifica Conto: " + CONTO
@ 2,2 SAY "Descrizione:" ; @ 2,20 GET cDesc PICTURE "@S50"
@ 3,2 SAY "Tipo:" ; @ 3,20 GET cTipo PICTURE "@!" VALID cTipo $ "APCRM"
@ 4,2 SAY "Livello:" ; @ 4,20 GET nLiv PICTURE "9"
@ 5,2 SAY "Padre:" ; @ 5,20 GET cPadre PICTURE "@!" WHEN nLiv > 1 VALID Empty(cPadre) .OR. ContoExists( cPadre )
@ 6,2 SAY "Raggrupp.:" ; @ 6,20 GET cRag PICTURE "@!" VALID Empty(cRag) .OR. RaggrExists( cRag )
@ 7,2 SAY "Sezione bil:" ; @ 7,20 GET cSez PICTURE "@!" VALID cSez $ "SPCEFO"
@ 8,2 SAY "IVA default:" ; @ 8,20 GET cIva PICTURE "@!" WHEN cTipo $ "CR" VALID Empty(cIva) .OR. IvaExists( cIva )
READ

IF LastKey() == K_ESC
RETURN
ENDIF

REPLACE DESCR WITH AllTrim( cDesc )
REPLACE TIPO WITH cTipo
REPLACE LIVELLO WITH nLiv
REPLACE PADRE WITH AllTrim( cPadre )
REPLACE RAGGR WITH AllTrim( cRag )
REPLACE SEZBIL WITH cSez
REPLACE IVADEF WITH AllTrim( cIva )
DBCommit()
RETURN

// --------- Cancella ----------
PROCEDURE DelConto()
LOCAL c := CONTO
IF MsgYesNo( "Cancellare il conto " + c + " ?" )
DELETE
DBCommit()
ENDIF
RETURN

// --------- Ricerca ----------
PROCEDURE SeekConto()
LOCAL c := AllTrim( InputBox( "Cerca conto (codice o descrizione)", "" ) )
IF Empty( c )
RETURN
ENDIF
IF IsDigit( Left( c,1 ) )
ordSetFocus( "KCONT" )
SEEK c
ELSE
ordSetFocus( "DESCR" )
SEEK Upper( c )
ENDIF
RETURN

// --------- Helpers logici ----------
FUNCTION ContoExists( cCode )
LOCAL l := .F., nSel := Select()
SELECT ( cConti )
ordSetFocus( "KCONT" )
l := DBSeek( cCode )
SELECT ( nSel )
RETURN l

FUNCTION IvaExists( cCode )
LOCAL nSel := Select(), l
SELECT ( cIva )
ordSetFocus( "CODICE" )
l := DBSeek( cCode )
SELECT ( nSel )
RETURN l

FUNCTION RaggrExists( cCode )
LOCAL nSel := Select(), l
SELECT ( cRaggr )
ordSetFocus( "CODICE" )
l := DBSeek( cCode )
SELECT ( nSel )
RETURN l

// Calcola il prossimo codice figlio: se PADRE=100 -> 100.01, 100.02, ...
FUNCTION NextChildCode( cPadre )
LOCAL cPre := AllTrim( cPadre )
LOCAL nMax := 0, cChild := ""
LOCAL nSel := Select()

SELECT ( cConti )
ordSetFocus( "PADRE" )
IF DBSeek( cPre )
DO WHILE ! Eof() .AND. PADRE == cPre
// Estrai numero finale dopo separatore
IF "." $ CONTO
cChild := SubStr( CONTO, Rat(".", CONTO)+1 )
nMax := Max( nMax, Val( cChild ) )
ELSE
// se il padre non usa separatore, crea ".01"
ENDIF
SKIP
ENDDO
ENDIF
SELECT ( nSel )

RETURN cPre + "." + PadL( LTrim( Str( nMax + 1 ) ), 2, "0" )
