/* ui_menu.prg */
#include "inkey.ch"

FUNCTION MenuMain( cTitle )
LOCAL aMenu := { ;
"1) TRATTAMENTO ARCHIVI", ;
"2) CONTABILITA'", ;
"3) GESTIONE VENDITE", ;
"4) MAGAZZINO", ;
"5) OBBLIGHI IVA", ;
"6) STATISTICHE", ;
"7) ELENCHI VARI", ;
"0) USCITA" }
LOCAL nSel

CLS
@ 0, 2 SAY cTitle
@ 1, 2 SAY "Menu principale"
@ 3, 2 PROMPT aMenu TO nSel

RETURN IIF( nSel == NIL, 0, nSel )

PROCEDURE MenuTrattamentoArchivi()
LOCAL a := { ;
"1) Anagrafica Clienti", ;
"2) Anagrafica Fornitori", ;
"3) Anagrafica Articoli", ;
"4) Agenti / Rappresentanti", ;
"5) Banche d'appoggio", ;
"6) Condizioni di pagamento", ;
"7) Unita' di misura", ;
"8) Codici IVA", ;
"9) Raggruppamenti", ;
"10) Piano dei Conti", ;
"0) Indietro" }
LOCAL n

DO WHILE .T.
CLS
@ 0,2 SAY "TRATTAMENTO ARCHIVI"
@ 2,2 PROMPT a TO n
IF n == 10
BrowseConti()
ELSEIF n == 0 .OR. LastKey() == K_ESC
EXIT
ELSE
MsgInfo( "Voce non ancora implementata (demo)", "SICOI" )
ENDIF
ENDDO
RETURN

// Sottomenù placeholder (coerenti con videate delle immagini)
PROCEDURE MenuContabilita() ; MsgInfo("Funzioni contabili da collegare (prima nota, scritture, ecc.)","SICOI") ; RETURN
PROCEDURE MenuGestioneVendite(); MsgInfo("Gestione vendite (clienti, documenti, fatture) - scheletro","SICOI") ; RETURN
PROCEDURE MenuMagazzino() ; MsgInfo("Magazzino: carichi/scarichi, movimenti e valorizzazioni - scheletro","SICOI") ; RETURN
PROCEDURE MenuObblighiIVA() ; MsgInfo("Obblighi IVA (registri acquisti/vendite, liquidazione) - scheletro","SICOI") ; RETURN
PROCEDURE MenuStatistiche() ; MsgInfo("Statistiche (per zona/agente/articoli) - scheletro","SICOI") ; RETURN
PROCEDURE MenuElenchiVari() ; MsgInfo("Elenchi vari (clienti, fornitori, articoli) - scheletro","SICOI") ; RETURN
