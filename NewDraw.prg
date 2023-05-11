FUNCTION FnzNewDraw
PARAMETERS TipoDraw
PRIVATE FileCount, FileArray, TmpFileArray, LenArray         ,;
        x0Draw, y0Draw, x1Draw, y1Draw                       ,;
        x0Selez, y0Selez, x1Selez, y1Selez                   ,;
        wScelta, Titolo, TipoFiles, TipoExt                  ,;
        OldDbfActive, wDirLavCopy                            ,;
        wDescr, wSottoTitolo                                 ,;
        Tmp1, Tmp2, Tmp3, TmpProd1, TmpProd2                 ,;
        wUnita                                               ,;
        wDirectory                                           ,;
        wSubUnita                                            ,;
        wSubDir                                              ,;
        wNomeDbf                                             ,;
        wExt                                                 ,;
        ActiveHelp                                           ,;
        Selez                                                ,;
        
ActiveHelp = 500

*****------------------------------------------------------------
*****Memorizzo il nome dell'archivio attivo
*****------------------------------------------------------------
OldDbfActive = ALIAS()

*****------------------------------------------------------------
*****Memorizzo directory di lavoro del file  attivo
*****------------------------------------------------------------
NomiDbf(OldDbfActive, "1")

*****------------------------------------------------------------
*****Compongo il nome della directory in cui fare la copia del file(s)
*****------------------------------------------------------------
wDirLavCopy = wSubUnita + "\" + ALLTRIM(wSubDir)

*****------------------------------------------------------------
*****Flag per continuare dopo la scelta dell'archivio disegni ***
*****------------------------------------------------------------
Continuo = .T.
IF TipoDraw = "1"              && Inserimento da Dir. Temp.
   OKTab = .F.
   OldColor = SETCOLOR()
   
   DO CASE 
      CASE READVAR() = "WSOTTOTIPO"
           **** Indica che al campo chiamante è accoppiata una tabella
           OkTab = .T.
           
           SELE TabDis
           SET ORDER TO 2
           IF DbfActive = "SCHEDA"
              jIndice = "TipoDis + CodDis"
              jKey1 = "SCHEDA " + MinTipo 
              jKey2 = "SCHEDA " + MaxTipo 
              jKeyFor = {|| CodDis  >= MinTipo .AND. CodDis <= MaxTipo}   
           ELSE
              jIndice = "TipoDis"
              jKey1 = DbfActive
              jKey2 = DbfActive
              jKeyWhile =  {|| TipoDis = DbfActive}   
              jKeyFor =  {||  .T.}   
           ENDIF
                
           TitTab = "Tabella Tipi Disegni"
           
           *****------------------------------------------------------------
           *****Coordinate della dbrowse() ***
           *****------------------------------------------------------------
           x0Tab = 11
           y0Tab = 02
           x1Tab = x0Tab + 13
           y1Tab = y0Tab + 60
           
             *****------------------------------------------------------------
           *****Dichiarazione campi dell'archivio da visualizzare
           *****------------------------------------------------------------
           Campi :=  {
                  {"Tipo"          ,"CodDis"         ,.F.VERDE      },;
                  {"Descrizione"       ,"Descr"         ,.F.CIANO    };
                  
            }
           CASE READVAR() = "WDASELE" .OR. READVAR() ="WASELE"
            *****Indica che al campo chiamante è accoppiata una tabella
            OkTab = .T.
            TitTab = "Tabella"
            jKey1 = .T.
            jKey2 = .T.
            jKeyWhile =  {|| .T.}
            jKeyFor   =  {|| .T.}
             {"Descrizione" , "Descr" , 35, CIANO};
             }
             
           CASE ALLTRIM(WNCampo) = "Rester/Ascii"
             SET ORDER TO 7 
             *****Dichiarazione campi dell'archivio da visualizzare **********
             Campi :=  {
                     {"Rester/Ascii"  ,"Tipo"   , F., VERDE     }
                       {"Descrizione" , "Descr" , 35, CIANO};
                          }
           ENDCASE 
           
           OTHERWHISE 
             DO CASE
                CASE ALLTRIM(WNCampo) = "Codice OCLAP"
                  SET ORDER TO 1
                   *****Dichiarazione campi dell'archivio da visualizzare **********
                   Campi :=  {
                                {"Codice OCLAP", "Prodotto",.F., VERDE      },;
                                 {"Descrizione" , "Descr" , 35, CIANO};
                                 }
                 CASE ALLTRIM(WNCampo) = "Nome File" 
                  SET ORDER TO 2
                  *****Dichiarazione campi dell'archivio da visualizzare **********
                  Campi :=  {
                                {"Codice OCLAP", "Prodotto",.F., VERDE      },;
                                 {"Descrizione" , "Descr" , 35, CIANO};
                                 }
                   CASE ALLTRIM(WNCampo) = "Estensione" 
                  SET ORDER TO 5
                  *****Dichiarazione campi dell'archivio da visualizzare **********
                  Campi :=  {
                                {"Codice OCLAP", "Prodotto",.F., VERDE      },;
                                 {"Descrizione" , "Descr" , 35, CIANO};
                                 }
                    CASE ALLTRIM(WNCampo) = "Descrizione" 
                  SET ORDER TO 4
                  *****Dichiarazione campi dell'archivio da visualizzare **********
                  Campi :=  {
                                {"Codice OCLAP", "Prodotto",.F., VERDE      },;
                                 {"Descrizione" , "Descr" , 35, CIANO};
                                 }       
                   CASE ALLTRIM(WNCampo) = "Tipo Disegno" 
                  SET ORDER TO 3
                  *****Dichiarazione campi dell'archivio da visualizzare **********
                  Campi :=  {
                                {"Codice OCLAP", "Prodotto",.F., VERDE      },;
                                 {"Descrizione" , "Descr" , 35, CIANO};
                                 }   
                  ENDCASE
               ENDCASE
            ENDCASE
            
            IF OkTab
               DbBrowse( 1                                       ,;  &&Cornice
               ColBrow                                           ,;  &&Colore finestra
               ColTasBrow                                        ,;  &&Colore Tasti Finestra
               TitTab                                            ,;  &&Titolo finestra
               "ESC-Uscita" + CHR(17)+CHR(217)+"-Scelta"         ,;  &&Tasti  finestra
               .F.                                               ,;  &&Ombra finestra
               jKey1                                             ,;  &&Chiave iniziale
               jKey2                                             ,;  &&Chiave finale 
               jKeyWhile                                         ,;  &&While
               jKeyFor                                           ,;  &&For
               x0Tab+1                                           ,;  &&Coordinate
               y0Tab+1                                           ,;  &&Coordinate
               x1Tab-1                                           ,;  &&Coordinate
               Campi                                             ,;  &&Campi da visualizzare
               "FnzUtTab"                                        ,;  &&Funzione utente
               2                                                 ,;  &&Numero colonne da bloccare
               1                                                 ,;  &&Posizione del puntatore all'inizio
               .F.                                               ,;  &&Colore sfondo
               )
               
             SET COLOR TO &OldColor
           
           ENDIF
           
           SET KEY -6 TO FnzAiuto()
           *****Chiudo l'archivio delle tabelle **********
           IF OkTab
              IF ALIAS() = "TABDIS"
                 SET ORDER TO 1
              ENDIF
           ENDIF
     *****------------------------------------------------------------
     *****Riseleziono l'archivio attivo prima della selezione
     *****------------------------------------------------------------    
     SELE &DbfActive
     
     RETURN .T.
     *****------------------------------------------------------------
     *****Fine definizione FnzAiuto
     *****------------------------------------------------------------    
           
