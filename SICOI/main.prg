REQUEST DBFCDX
REQUEST HB_GT_WIN_DEFAULT // su Windows; su Linux può andare HB_GT_TRM

#include "inkey.ch"
#include "set.ch"

STATIC cAppName := "SICOI - Sistema Contabile Integrato"
STATIC cDataDir := "data"

PROCEDURE Main()
LOCAL nOpt

SET DATE ITALIAN
SET EPOCH TO 1950
SET CENTURY ON
SET CONFIRM ON
SET DELETED ON
SET EXACT OFF
SET WRAP ON
SET SOFTSEEK ON
SET ESCAPE ON

RDDSETDEFAULT( "DBFCDX" )
SET(_SET_EXCLUSIVE, .F.)
SET(_SET_AUTOPEN, .T.)
SET(_SET_MARGINS, 2)

IF ! hb_DirExists( cDataDir )
hb_DirCreate( cDataDir )
ENDIF

// crea/apre archivi e indici
TablesInit( cDataDir )

DO WHILE .T.
nOpt := MenuMain( cAppName )
DO CASE
CASE nOpt == 1
MenuTrattamentoArchivi()
CASE nOpt == 2
MenuContabilita()
CASE nOpt == 3
MenuGestioneVendite()
CASE nOpt == 4
MenuMagazzino()
CASE nOpt == 5
MenuObblighiIVA()
CASE nOpt == 6
MenuStatistiche()
CASE nOpt == 7
MenuElenchiVari()
CASE nOpt == 0 .OR. LastKey() == K_ESC
EXIT
ENDCASE
ENDDO

CLOSE ALL
CLEAR
RETURN
