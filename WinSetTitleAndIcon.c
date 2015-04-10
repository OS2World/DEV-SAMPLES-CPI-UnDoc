#define INCL_BASE
#include <os2.h>

#include <conio.h>
#include <stdlib.h>

APIRET16 APIENTRY16 WinSetTitleAndIcon ( PSZ szTitle, PSZ szIconPath ) ;

void main ( void ) {

   char IconPath [ _MAX_PATH ] ;
   _fullpath ( IconPath, "WinSetTitleAndIcon.ico", sizeof(IconPath) ) ;

   WinSetTitleAndIcon ( "Test of WinSetTitleAndIcon", IconPath ) ;

   getch ( ) ;
}
