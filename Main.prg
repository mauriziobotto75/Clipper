Private wAriosto, wCorcos, wTitolo, wPwdOk, wNomeUtente   ,;
Counter, Opz                                              ,;
Colmenu, ColTasMenu                                       ,;
ColBrow, ColTasBrow                                       ,;
ColRecIns, ColInsTasRec                                   ,;
ColRecVar, ColVarTasRec                                   ,;
ColRecVis, ColVisTasRec                                   ,;
ColMess,    ColTasMess                                    ,;
ColMess2,   ColTas2Mess                                   ,;
ColMess3,   ColTas3Mess                                   ,;
ColErrMess, ColErrTassMess                                ,;
ColView,    ColViewTas                                    ,;
ColRecCan,  ColCanTasRec                                  ,;
FlagTipoVisual                                            ,;
wDirLav                                                   ,;
ActiveHelp                                                ,;

SET KEY 28 TO FnzHelp
ActiveHelp := 1

*****____________________________________________________*****
*****Flag per sapere la tipologia di visualizzazione del disegno  ******
*****   2(= visualizzazione da sopra)                             ******
*****Per default $1 (=visualizzazione da sotto)                   ******
*****____________________________________________________******
FlagTipoVisual := 1

*****____________________________________________________******
***** Setta Vari                                         ******
*****____________________________________________________******
SET DATE BRITISH                                         && sotto la data nel formato GG/MM/AAAA
SET SCOREBOARD OFF                                       && per non visualizzare messaggi su riga 0
SET DELETED ON                                           && per non visualizzare i record cancellati
SET STATUS OFF
SET TALK   OFF
SET EXACT OFF
SET BELL  OFF
SET WRAP  ON
SET MESSAGE TO 24
*****____________________________________________________******
*****        PULIZIA SCHERMO                             ******
*****____________________________________________________******
CLEAR

*****----------------------------------------------------******
*****Scritte di intestazione                             ******
*****----------------------------------------------------******
wAriosto := "Ariosto & Sardonico"
wTitolo  := "Gestione Cartellina Elettronica"

IF .NOT. OKPass("INS")
         Pop_Mes("La password Attiva non PERMETTE Modifiche ",;
                 "  Premere un tasto.                       ",;
                 0)
ELSE
    FnzGesProd("I)
    Ritorno = .T.
ENDIF


