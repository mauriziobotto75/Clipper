/* ui_common.prg */

#include "inkey.ch"

FUNCTION MsgInfo( cMsg, cTit )
Alert( cMsg )
RETURN NIL

FUNCTION MsgStop( cMsg )
Alert( "** " + cMsg + " **" )
RETURN NIL

FUNCTION MsgYesNo( cMsg )
RETURN ( Alert( cMsg, { "Si", "No" } ) == 1 )

FUNCTION InputBox( cPrompt, cDefault )
LOCAL c := cDefault
@ MaxRow()-2, 2 SAY cPrompt
@ MaxRow()-2, 2+Len(cPrompt)+1 GET c PICTURE "@S60"
READ
RETURN c
