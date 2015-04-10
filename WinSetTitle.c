#define INCL_BASE
#include <os2.h>

#include <conio.h>

APIRET16 APIENTRY16 WinSetTitle ( PSZ szTitle ) ;

void main ( void ) {

   WinSetTitle ( "Test of WinSetTitle" ) ;

   getch ( ) ;
}
