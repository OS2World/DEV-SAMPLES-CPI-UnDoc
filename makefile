All : os2undoc.inf dosq.exe lsof.exe WinSetTitle.exe WinSetTitleAndIcon.exe

os2undoc.inf : os2undoc.ipf dqps.h dosqss.h dosq.c lsof.c WinSetTitle.c WinSetTitle.def WinSetTitleAndIcon.c WinSetTitleAndIcon.def
   ipfc /inf os2undoc.ipf

dosq.exe : dosq.c dosq.def dosqss.h
   icc dosq.c dosq.def

lsof.exe : lsof.c lsof.def dosqss.h
   icc lsof.c lsof.def

WinSetTitle.exe : WinSetTitle.c WinSetTitle.def
   icc WinSetTitle.c WinSetTitle.def

WinSetTitleAndIcon.exe : WinSetTitleAndIcon.c WinSetTitleAndIcon.def
   icc WinSetTitleAndIcon.c WinSetTitleAndIcon.def

