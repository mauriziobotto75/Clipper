PROCEDURE Main()
  CLS

  cTime := TIME()

  nKey := 0

  DO WHILE nKey = 0
    @ 0,70 SAY cTime
    DO WHILE cTime = TIME()
    ENDDO
    cTime := TIME()
    nKey := INKEY()
  ENDDO 

RETURN // Main()
