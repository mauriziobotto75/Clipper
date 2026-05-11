PROCEDURE DbCreateDisegni()

   LOCAL aStru := {
      { "CODPROD"    , "C", 15, 0 },
      { "CLIENTE"    , "C", 20, 0 },
      { "DIMENSIONE" , "C", 10, 0 },
      { "FORMCORCOS", "C", 10, 0 },
      { "NOMEFILE"   , "C", 30, 0 },
      { "ESTENSIONE", "C", 5 , 0 },
      { "DESCRIZIONE","C", 40, 0 },
      { "TIPO"       , "C", 10, 0 },
      { "ATTIVO"     , "L", 1 , 0 }
   }

   DBCREATE( "DATA/DISEGNI.DBF", aStru )
   USE DATA/DISEGNI
   INDEX ON CODPROD TAG CODPROD
   INDEX ON CLIENTE TAG CLIENTE
   INDEX ON DIMENSIONE TAG DIM
   INDEX ON FORMCORCOS TAG FORMA
   USE
RETURN
