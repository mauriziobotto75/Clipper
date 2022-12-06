 *********************** STAMPA NOLEGGIO AUTOMOBILI ****************************
**********                     STA_NOL                                *********
**                                                                          ***
*                                                                             *
*                                                                             *
SET BELL OFF
SET ECHO OFF
SET TALK OFF
SELECT 1
USE AUTO  INDEX AUTOX
SELECT 2
USE NOLEGGI INDEX NOLEGGIX
@2,10 SAY DATE()
SW_NOLEGGI=0
DO GIOR_MES
SELECT 2
DO NOL_SCR2
@7,48 GET W_TARG_AUTO PICTURE "!!!!!!!!!!"
READ
      IF W_TARG_AUTO=0
         RETURN
      ENDIF
SEEK W_TARG_AUTO
           DO WHILE W_TARG_AUTO#SPACE(10)
           @10,48 GET W_DAT_REST
           @13,48 GET W_KM_ARR
           @16,48 GET W_COD_AUT
           @19,48 GET W_CIL_AUT
           @21,48 GET W_MOD_AUT
           @22,48 GET W_VERS_AUT
           W_GG_NOL=W_DAT_REST-DAT_NOL
           W_KM_PERC=W_KM_ARR-W_KM_PART
           SELECT 1
           USE AUTO INDEX AUTX
           SEEK CHIAVE
           NUM_AUT=NUM_AUT+1
           TARIFF_AUT=TAR_AUT*W_GG_NOL+KM_LIT*W_KM_PERC
           IF DAY(DATE())=ULT_GIOR_MES
                  DO STA_STAT
                  TOT_GG_NOL=0
                  TOT_STA_SOC_NOL=0
                  TOT_SEX_NOL=0
                  TOT_TAR_AUT=0
                       ELSE
                       TOT_GG_NOL=TOT_GG_NOL+W_GG_NOL
                       TOT_STA_SOC_NOL=TOT_STA_SOC_NOL+1
                       TOT_SEX_NOL=TOT_SEX_NOL+1
                       TOT_TAR_AUT=TOT_TAR_AUT+TARIFF_AUT
                       KM_PERC=W_KM_PERC+KM_PERC
           ENDIF
           SELECT 2
           SET DEVICE TO PRINT
           @4,30 SAY "STAMPA RICEVUTA NOLEGGIO"
           CODICE=STR(W_COD_AUT,W_CIL_AUT)
           SEEK CODICE
           NUM_AUT=NUM_AUT+1
           W_TARIFF_AUT=TAR_AUT*W_GG_NOL+KM_LIT*W_KM_PERC
           GG_NOL=W_GG_NOL+GG_NOL
           W_KM_PERC=W_KM_ARR-W_KM_PART
           @PROW()+1,10 SAY NOM_NOL
           @PROW(),30 SAY IND_NOL
           @PROW(),40 SAY W_DAT_REST
           @PROW(),50 SAY W_GG_NOL
           @PROW(),55 SAY W_TARIFF_AUT
           DELETE
           SW_NOLEGGI=1
           DO NOL_SCR2
           @7,48 GET W_TARG_AUTO PICTURE "!!!!!!!!!!"
           READ
           IF W_TARG_AUTO#0
                  LOOP
                    ELSE
                    RETURN
           ENDIF
               IF SW_NOLEGGI=1
                   PACK
               ENDIF
ENDDO
CLOSE DATA
RETURN
