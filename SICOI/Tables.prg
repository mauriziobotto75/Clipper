harbour isn’t fully supported. Syntax highlighting is based on Plain Text.
/* tables.prg */

#include "dbstruct.ch"

STATIC s_cDataDir

PROCEDURE TablesInit( cDataDir )
s_cDataDir := cDataDir

CreateOrOpen_UM()
CreateOrOpen_IVA()
CreateOrOpen_Pagamenti()
CreateOrOpen_Banche()
CreateOrOpen_Agenti()
CreateOrOpen_Raggruppamenti()
CreateOrOpen_Articoli()
CreateOrOpen_Clienti()
CreateOrOpen_Fornitori()
CreateOrOpen_Conti()

RETURN

// ---------- Unità di misura ----------
STATIC PROCEDURE CreateOrOpen_UM()
LOCAL a := { ;
{ "CODUM" , "C", 3, 0 }, ;
{ "DESCR" , "C", 30, 0 }, ;
{ "ATTIVO" , "L", 1, 0 } ;
}
OpenOrCreateDBF( "um", a, { ;
{ "CODICE" , {|| CODUM } }, ;
{ "DESCR" , {|| DESCR } } ;
} )
RETURN

// ---------- IVA ----------
STATIC PROCEDURE CreateOrOpen_IVA()
LOCAL a := { ;
{ "CODIVA", "C", 4, 0 }, ;
{ "DESCR" , "C", 40, 0 }, ;
{ "ALIQ" , "N", 5, 2 }, ;
{ "ESENTE", "L", 1, 0 }, ;
{ "NATURA", "C", 2, 0 } ;
}
OpenOrCreateDBF( "iva", a, { ;
{ "CODICE", {|| CODIVA } }, ;
{ "DESCR" , {|| DESCR } }, ;
{ "ALIQ" , {|| STR( ALIQ, 5, 2 ) } } ;
} ) 
STATIC PROCEDURE EnsureIva22()
LOCAL nSel := Select(), lFound
SELECT IVA
ordSetFocus( "CODICE" )
lFound := DBSeek( "22" )
IF ! lFound
APPEND BLANK
REPLACE CODIVA WITH "22"
REPLACE DESCR WITH "IVA ordinaria 22%"
REPLACE ALIQ WITH 22.00
REPLACE ESENTE WITH .F.
REPLACE NATURA WITH ""
DBCommit()
ENDIF
SELECT ( nSel )
RETURN

RETURN

// ---------- Condizioni di pagamento ----------
STATIC PROCEDURE CreateOrOpen_Pagamenti()
LOCAL a := { ;
{ "CODPAG", "C", 4, 0 }, ;
{ "DESCR" , "C", 50, 0 }, ;
{ "RATE" , "N", 2, 0 }, ;
{ "GG1" , "N", 3, 0 }, ;
{ "GG2" , "N", 3, 0 }, ;
{ "FINEME", "L", 1, 0 }, ;
{ "SCASSA", "N", 5, 2 } ;
}
OpenOrCreateDBF( "pag", a, { ;
{ "CODICE", {|| CODPAG } }, ;
{ "DESCR" , {|| DESCR } } ;
} )
RETURN

// ---------- Banche d’appoggio ----------
STATIC PROCEDURE CreateOrOpen_Banche()
LOCAL a := { ;
{ "CODBAN", "C", 5, 0 }, ;
{ "DESCR" , "C", 50, 0 }, ;
{ "IBAN" , "C", 34, 0 }, ;
{ "ABI" , "C", 5, 0 }, ;
{ "CAB" , "C", 5, 0 } ;
}
OpenOrCreateDBF( "banche", a, { ;
{ "CODICE", {|| CODBAN } }, ;
{ "DESCR" , {|| DESCR } } ;
} )
RETURN

// ---------- Agenti ----------
STATIC PROCEDURE CreateOrOpen_Agenti()
LOCAL a := { ;
{ "CODAGE", "C", 5, 0 }, ;
{ "NOME" , "C", 40, 0 }, ;
{ "PERC" , "N", 5, 2 }, ;
{ "TEL" , "C", 20, 0 }, ;
{ "EMAIL" , "C", 60, 0 }, ;
{ "ATTIVO", "L", 1, 0 } ;
}
OpenOrCreateDBF( "agenti", a, { ;
{ "CODICE", {|| CODAGE } }, ;
{ "NOME" , {|| NOME } } ;
} )
RETURN

// ---------- Raggruppamenti (per Articoli/Clienti/Fornitori) ----------
STATIC PROCEDURE CreateOrOpen_Raggruppamenti()
LOCAL a := { ;
{ "CODRAG", "C", 4, 0 }, ;
{ "DESCR" , "C", 40, 0 }, ;
{ "TIPO" , "C", 1, 0 } ; // A=Articoli, C=Clienti, F=Fornitori, K=Conti
}
OpenOrCreateDBF( "raggr", a, { ;
{ "CODICE", {|| CODRAG } }, ;
{ "DESCR" , {|| DESCR } }, ;
{ "TIPO" , {|| TIPO } } ;
} )
RETURN

// ---------- Articoli ----------
STATIC PROCEDURE CreateOrOpen_Articoli()
LOCAL a := { ;
{ "CODART", "C", 15, 0 }, ;
{ "DESCR" , "C", 60, 0 }, ;
{ "UM" , "C", 3, 0 }, ;
{ "GRP" , "C", 4, 0 }, ;
{ "PREZZO", "N", 12, 4 }, ;
{ "COSTO" , "N", 12, 4 }, ;
{ "IVA" , "C", 4, 0 }, ;
{ "SCMIN" , "N", 9, 3 }, ;
{ "ATTIVO", "L", 1, 0 } ;
}
OpenOrCreateDBF( "articoli", a, { ;
{ "CODICE", {|| CODART } }, ;
{ "DESCR" , {|| DESCR } }, ;
{ "GRP" , {|| GRP } } ;
} )
RETURN

// ---------- Clienti ----------
STATIC PROCEDURE CreateOrOpen_Clienti()
LOCAL a := { ;
{ "CODCLI", "C", 6, 0 }, ;
{ "RAGSOC", "C", 60, 0 }, ;
{ "INDIR" , "C", 60, 0 }, ;
{ "CAP" , "C", 5, 0 }, ;
{ "COMUNE", "C", 40, 0 }, ;
{ "PROV" , "C", 2, 0 }, ;
{ "PIVA" , "C", 11, 0 }, ;
{ "CFISC" , "C", 16, 0 }, ;
{ "AGENTE", "C", 5, 0 }, ;
{ "BANCA" , "C", 5, 0 }, ;
{ "PAG" , "C", 4, 0 }, ;
{ "IVA" , "C", 4, 0 }, ;
{ "SCONTO", "N", 5, 2 }, ;
{ "FIDO" , "N", 12, 2 }, ;
{ "TEL" , "C", 20, 0 }, ;
{ "EMAIL" , "C", 60, 0 }, ;
{ "GRP" , "C", 4, 0 } ;
}
OpenOrCreateDBF( "clienti", a, { ;
{ "CODICE", {|| CODCLI } }, ;
{ "RAGSOC", {|| RAGSOC } } ;
} )
RETURN

// ---------- Fornitori ----------
STATIC PROCEDURE CreateOrOpen_Fornitori()
LOCAL a := { ;
{ "CODFOR", "C", 6, 0 }, ;
{ "RAGSOC", "C", 60, 0 }, ;
{ "INDIR" , "C", 60, 0 }, ;
{ "CAP" , "C", 5, 0 }, ;
{ "COMUNE", "C", 40, 0 }, ;
{ "PROV" , "C", 2, 0 }, ;
{ "PIVA" , "C", 11, 0 }, ;
{ "CFISC" , "C", 16, 0 }, ;
{ "BANCA" , "C", 5, 0 }, ;
{ "PAG" , "C", 4, 0 }, ;
{ "IVA" , "C", 4, 0 }, ;
{ "GRP" , "C", 4, 0 }, ;
{ "TEL" , "C", 20, 0 }, ;
{ "EMAIL" , "C", 60, 0 } ;
}
OpenOrCreateDBF( "fornitori", a, { ;
{ "CODICE", {|| CODFOR } }, ;
{ "RAGSOC", {|| RAGSOC } } ;
} )
RETURN

// ---------- Conti (Piano dei conti) ----------
STATIC PROCEDURE CreateOrOpen_Conti()
LOCAL a := { ;
{ "CONTO" , "C", 12, 0 }, ; // es. 100, 100.01, 100.01.001 (separatore opzionale)
{ "DESCR" , "C", 60, 0 }, ;
{ "TIPO" , "C", 1, 0 }, ; // A=Attivo, P=Passivo, C=Costi, R=Ricavi, M=Memor.
{ "LIVELLO","N", 1, 0 }, ;
{ "PADRE" , "C", 12, 0 }, ;
{ "RAGGR" , "C", 4, 0 }, ;
{ "SEZBIL","C", 2, 0 }, ; // SP, CE, FO, ecc.
{ "IVADEF","C", 4, 0 }, ; // default codice IVA
{ "BLOCCO","L", 1, 0 }, ;
{ "DTCREA","D", 8, 0 }, ;
{ "UTECREA","C", 15, 0 } ;
}
OpenOrCreateDBF( "conti", a, { ;
{ "KCONT" , {|| CONTO } }, ;
{ "PADRE" , {|| PADRE } }, ;
{ "DESCR" , {|| DESCR } }, ;
{ "TIPO" , {|| TIPO } } ;
} )

SELECT CONTI
IF LastRec() == 0
SeedPianoConti_ImpresaIndividuale() // <-- nuovo
ENDIF
RETURN
// ---------- Helper generico ----------
STATIC PROCEDURE OpenOrCreateDBF( cName, aStruct, aTags )
LOCAL cDbf := hb_FNameMerge( s_cDataDir, "", Lower( cName ) + ".dbf" )
LOCAL cCdx := hb_FNameExtSet( cDbf, ".cdx" )
LOCAL lNew := .F.
LOCAL i

IF ! File( cDbf )
dbCreate( cDbf, aStruct, "DBFCDX" )
lNew := .T.
ENDIF

USE ( cDbf ) NEW SHARED ALIAS ( Upper( cName ) )
IF lNew .AND. ! File( cCdx )
INDEX ON "" TAG DUMMY TO ( cCdx ) // crea file CDX
ORDCLEAR()
ENDIF

// Crea/aggiorna indici (tag unici per nome)
IF ! Empty( aTags )
FOR i := 1 TO Len( aTags )
ordCreate( hb_FNameName( cCdx ), ;
Upper( aTags[i,1] ), ;
aTags[i,2], ; // codeblock
{ "EXPRESSION" } )
NEXT
ENDIF
RETURN

