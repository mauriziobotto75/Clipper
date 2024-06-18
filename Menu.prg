// Menu.prg -- Display a menu and process a menu choice
// Manifest constant definitions
#define ONE 1
#define TWO 2
#define THREE 3
// File-wide variable declarations go here
PROCEDURE Main
// Local variable declarations

 LOCAL nChoice

 // Continous loop redisplays menu after each function return

 DO WHILE .T.

 // Function call to display main menu

 nChoice := MainMenu()

 // CASE structure to make function call 
 // based on return value of MainMenu()

 DO CASE

 // Function called in CASE structure are defined
 // in Database.prg, included at the end of this file

 CASE nChoice = ONE
 AddRecs()
CASE nChoice = TWO
 EditRecs() 

 CASE nChoice = THREE
 Reports() 

 OTHERWISE
 EXIT // Break out of continuos loop 

 ENDCASE

 ENDDO

RETURN // Main()

FUNCTION MainMenu( MenuChoice )
 CLEAR
 SET WRAP ON
 SET MESSAGE TO 23 CENTER

 @ 6, 10 PROMPT "Add" MESSAGE "New Account"
 @ 7, 10 PROMPT "Edit" MESSAGE "Change Account"
 @ 8, 10 PROMPT "Reports" MESSAGE "Print Account Reports"
 @ 10, 10 PROMPT "Quit" MESSAGE "Return to DOS"

 MENU TO MenuCoice

 CLEAR

RETURN MenuCoice // MainMenu() 

#include "Database.prg" // Contains generic database functions
