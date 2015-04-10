:userdoc.
:title.Undocumented Features of OS/2 - 31 May 1999
:docprof toc=123456.

:h1 res=1.Overview &amp. Credits
:lm margin=1.
This document is a collection of unofficial information gathered from a variety of sources
about system API functions in OS/2 that are not officially documented for various reasons.
I (Rick Papo, rpapo@msen.com) have built it for my own convenience and have not verified 
every detail for myself with test programs.
This information is subject to change without notice, and under no circumstances will I
assume liability for how this information is used.  
To the best of my knowledge none of the information contained herein was obtained
from confidential IBM documents or against the provisions of non-disclosure agreements.
Use this information totally at your own risk.  
Always test such use thoroughly for suitability in your own application and environment.
:p.
The information in this document was discovered or gathered by the following persons&colon.
:table cols='20 50'.
:row.:c.Carsten Arnold:c.C.Arnold@transnet.de
:row.:c.Samuel Audet:c.guardia@cam.org
:row.:c.Alessandro Cantatore:c.alexcant@tin.it
:row.:c.Scott Garfinkle:c.seg@us.ibm.com
:row.:c.Istvan Kovacs:c.kofa@alarmix.net
:row.:c.Alexander Mai:c.st002279@hrzpub.tu-darmstadt.de
:row.:c.Bob Markle:c.Bob_Markle@compuware.com
:row.:c.Darren McBride:c.dmcbride@globalserve.net
:row.:c.Ferenc Pal:c.fpal@hu.ibm.com
:row.:c.Rick Papo:c.Rick_Papo@compuware.com or rpapo@msen.com
:row.:c.Paul Ratcliffe:c.paulr@orac.clara.co.uk or paul.ratcliffe@bbc.co.uk
:row.:c.Kai Uwe Rommel:c.rommel@ars.de
:row.:c.Marco G. Salvagno:c.whiz@iol.it
:row.:c.Alexey Smirnov:c.??
:row.:c.Uri J. Stern:c.ujstern@ibm.net
:row.:c.Holger Veit:c.Holger.Veit@gmd.de
:etable.

:h1 res=10.DosDumpProcess
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET APIENTRY DosDumpProcess ( ULONG Action, ULONG Drive, PID Pid ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS DosDumpProcess = DOSCALLS.113
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.ULONG Action:font facename=default.  Operation to perform (see comments).
:li.:font facename=Courier size=13x8.ULONG Drive :font facename=default.  Dump drive ('A'=A: and so on).
:li.:font facename=Courier size=13x8.PID Pid     :font facename=default.  Process ID of process to be dumped.
:esl.:lm margin=1.:p.
:hp5.Comments&colon.:ehp5.:p.
The Action parameter can take the following values&colon.
:lm margin=6.:sl compact.
:li.00000000 - Disable Process Dumps
:li.00000001 - Set Dump Drive
:li.00000002 - Dump Process Data
:esl.:lm margin=1.:p.

:h1 res=20.DosForceSystemDump
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET APIENTRY DosForceSystemDump ( ULONG ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS DosForceSystemDump = DOSCALLS.444
:lm margin=1.:font facename=default.:p.

:h1 res=30.DosProfile
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET APIENTRY Dos32Profile ( ULONG func, PID pid, PRFCMD *profcmd, PRFRET *profret ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS Dos32Profile = DOSCALLS.377
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.ULONG func     :font facename=default.  Function to perform.  See notes.
:li.:font facename=Courier size=13x8.PID pid        :font facename=default.  Process ID to be profiled.  Zero selects the kernel.
:li.:font facename=Courier size=13x8.PRFCMD *profcmd:font facename=default.  Address of command buffer.  See notes.
:li.:font facename=Courier size=13x8.PRFRET *profret:font facename=default.  Address of results buffer.  See notes.
:esl.:lm margin=1.:p.
:hp5.Return Codes&colon.:ehp5.
:lm margin=6.:sl compact.
:li.  0  NO ERROR - Ok.
:li.  8  NOT_ENOUGH_MEMORY - Couldn't allocate profile structures.
:li. 87  INVALID_PARAMETER - Some parameter not ok.
:li.111  BUFFER_OVERFLOW - Not enough size in return buffer.
:li.115  PROTECTION_VIOLATION - Invalid return buffer data.
:li.126  MOD_NOT_FOUND - Requested module data not available.
:li.303  INVALID_PROCID - Parameter 2 is not a valid PID.
:li.328  SYS_INTERNAL - Profile data structure corrupted.
:li.543  PRF_NOT_INITIALIZED - Profiling was not initialized.
:li.544  PRF_ALREADY_INITIALIZED - Profiling is already initialized.
:li.545  PRF_NOT_STARTED - Cannot stop profiling without start.
:li.546  PRF_ALREADY_STARTED - Profiling is already started.
:li.547  PRF_TIMER_OUT_OF_RANGE - Invalid timer frequency.
:li.548  PRF_TIMER_RESET - Re-initialized with different timer.
:esl.:lm margin=1.:p.
:hp5.Notes&colon.:ehp5.:p.
(1) The :hp2.func:ehp2. parameter can have the following values&colon.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.PRF_CM_INIT  (0):font facename=default.  Initialize.  :hp2.pid:ehp2. and :hp2.profcmd:ehp2. must be specified.
:li.:font facename=Courier size=13x8.PRF_CM_START (1):font facename=default.  Start profiling.  :hp2.pid:ehp2. must be specified.
:li.:font facename=Courier size=13x8.PRF_CM_STOP  (2):font facename=default.  Stop profiling.  :hp2.pid:ehp2. must be specified.
:li.:font facename=Courier size=13x8.PRF_CM_CLEAR (3):font facename=default.  Clear profile counters.  :hp2.pid:ehp2. must be specified.
:li.:font facename=Courier size=13x8.PRF_CM_DUMP  (4):font facename=default.  Read out profile data.  :hp2.pid:ehp2. and :hp2.profret:ehp2. must be specified.
:li.:font facename=Courier size=13x8.PRF_CM_EXIT  (5):font facename=default.  Exit profiling.  Discard profiling structures.
:esl.:lm margin=1.:p.
(2) The :hp2.profcmd:ehp2. structure is as follows&colon.:lm margin=4.:font facename=Courier size=13x8.:xmp.
struct {
   PRFSLOT *cm_slots ;              /* Virtual address slots */
   USHORT   cm_nslots ;             /* # of VA slots < 256 (!) */
   USHORT   cm_flags ;              /* command */
      #define PRF_PROCESS_MT 0      /* profile proc+threads */
      #define PRF_PROCESS_ST 1      /* profile proc only */
      #define PRF_KERNEL     2      /* profile kernel */
      #define PRF_VADETAIL   0      /* create detailed page counters */
      #define PRF_VAHIT      4      /* create hit table */
      #define PRF_VATOTAL    8      /* create total count for VA only */
      #define PRF_FLGBITS    0x40   /*  has a flgbits structure (?) */
      #define PRF_WRAP       0x80   /* don't use: if hit table full, wrap */
                                    /* there is a bug in kernel, which */
                                    /* prevents this from correct working! */
      /* status bits, don't ever set these (won't work, not masked, bug!) */
      #define PRFS_RUNNING   0x100  /* profiling is active */
      #define PRFS_THRDS     0x200  /* also profiling threads */
      #define PRFS_HITOVFL   0x800  /* overflow in hit buffer */
      #define PRFS_HEADER    0x1000 /* internally used */

   ULONG    cm_bufsz ;              /* reserve # of bytes for buffers */
                                    /* e.g. for hit buffer or detailed */
                                    /* counters */
   USHORT   cm_timval ;             /* timer resolution */
                                    /* if 0, use default == 1000 */
   /* valid if PRF_FLAGBITS set */
   PUCHAR   cm_flgbits ;            /* vector of flag bits (?) */
   UCHAR    cm_nflgs ;              /* # of flag bits >= 2 if present */
} PRFCMD; /* 19 bytes */

typedef struct {
   ULONG sl_vaddr; /* start of VA segment to profile */
   ULONG sl_size;  /* length of VA segment */
   ULONG sl_mode;  /* !=0 use PRF_VA* flags, */
                   /* =0, simple count */
} PRFSLOT;
:exmp.:lm margin=1.:font facename=default.:p.
(3) The :hp2.profret:ehp2. structure is as follows&colon.:lm margin=4.:font facename=Courier size=13x8.:xmp.
typedef struct {
   UCHAR us_cmd ;                /* command */
      #define PRF_RET_GLOBAL   0 /* return global data */
                                 /* set us_thrdno for specific thread */
                                 /* us_buf = struct PRFRET0 */
      #define PRF_RET_VASLOTS  1 /* return VA slot data (PRFRET1) */
      #define PRF_RET_VAHITS   2 /* return hit table (PRFRET2) */
      #define PRF_RET_VADETAIL 3 /* return detailed counters (PRFRET3) */
                                 /* specify us_vaddr */
   USHORT us_thrdno ;            /* thread requested for cmd=0 */
   ULONG us_vaddr ;              /* VA for cmd=3*/
   ULONG us_bufsz ;              /* length of return buffer */
   VOID *us_buf ;                /* return buffer */
} PRFRET ; /* 15 bytes */

typedef struct {
   USHORT r0_flags ;             /* profile flags */
                                 /* see PRF_* defines */
   USHORT r0_shift ;             /* shift factor */
                                 /* 2^N = length of a segment for */
                                 /* detailed counters */
   ULONG  r0_idle ;              /* count if process is idle */
   ULONG  r0_vm86 ;              /* count if process is in VM mode */
   ULONG  r0_kernel ;            /* count if process is in kernel */
   ULONG  r0_shrmem ;            /* count if process is in shr mem */
   ULONG  r0_unknown ;           /* count if process is elsewhere */
   ULONG  r0_nhitbufs ;          /* # of dwords in hitbufs */
   ULONG  r0_hitbufcnt ;         /* # of entries in hit table */
   ULONG  r0_reserved1 ;         /* internally used */
   ULONG  r0_reserved2 ;         /* internally used */
   USHORT r0_timval ;            /* timer resolution */
   UCHAR  r0_errcnt ;            /* error count */
   USHORT r0_nstruc1 ;           /* # of add structures 1 (?) */
   USHORT r0_nstruc2 ;           /* # of add structures 2 (?) */
} PRFRET0 ;

typedef struct {
   UCHAR r1_nslots ;             /* # of slots (bug: prevents */
                                 /* correct # if #slots >255) */
   PRFVA r1_slots[1] ;           /* slots */
} PRFRET1 ;

typedef struct {
   ULONG r2_nhits ;              /* # of entries in table */
   ULONG r2_hits[1] ;            /* hit table */
} PRFRET2 ;

typedef struct {
   ULONG r3_size ;               /* size of segment */
   ULONG r3_ncnts ;              /* # of entries in table */
   ULONG r3_cnts[1] ;            /* counters */
} PRFRET3;

typedef struct {
   ULONG va_vaddr ;              /* virtual address of segment */
   ULONG va_size ;               /* length of segment */
   ULONG va_flags ;              /* == 8, va_cnt is valid */
   ULONG va_reserved ;           /* internally used */
   ULONG va_cnt ;                /* profile count */
} PRFVA;
:exmp.:lm margin=1.:font facename=default.:p.
(4) Profiling is based on VA (virtual address) segments. The profiler
can operate in the following modes&colon.
:sl compact.
:li.&sqbul.Simple counting&colon. will increment a counter if a VA range is found.
:li.&sqbul.Hit tracing&colon. will store the detailed VA in the hit buffer if
an address is found in a range to be profiled. If the buffer is full
with VAs, this type of logging stops, since the wrap function
has a bug.
:li.&sqbul.Detailed counting&colon. first all segments are added. Assuming cm_bufsz/4
ULONGs are available, calculate the finest page granularity that
will use most space of the counter buffer. Allocate sufficient
counters for each VA range. If a page is hit, increment the
corresponding counter.
:esl.:lm margin=1.:p.
(5) All structures are byte aligned and packed.:p.
(6) Several bugs in the logic seem to prevent certain functions.:p.
(7) Apparently only one process may be profiled at a time, due to a 
difficulty of sharing the global internal _pmb structure.:p.
(8) The flgbits structure seems to be a strange kind of clock divider&colon.
if there are flgbits, the profiling routine is only called from the
profile interrupt, if the one of the bytes decrements to 0, e.g.
flgbits[] = { 5,6,7,8 } profiling data will be accumulated after
tick 8, 15, 21, 26, 34, 41, 47, 52,... I have no idea why this is
available.

:h1 res=40.DosQProcStat
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET16 APIENTRY16 DosQProcStatus ( PULONG buffer, USHORT buffer_size ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS DOSQPROCSTATUS = DOSCALL1.154
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.PULONG buffer     :font facename=default.  Address of buffer for results.  See :link reftype=hd res=41.DQPS.H:elink. for the layout.
:li.:font facename=Courier size=13x8.USHORT buffer_size:font facename=default.  Size of result buffer.
:esl.:lm margin=1.:p.
:hp5.Comments&colon.:ehp5.:p.
This function is a slightly altered version of the function of the same name that was present
in OS/2 1.x, and which formed the basis of the PSTAT program.  Though it remains a 16-bit
function call, returning data formatted for a 16-bit application, it is nonetheless different
from the original OS/2 1.x function in that the data structure returned is much more complete
and is easier to use.
:note.Because this function remains a 16-bit version, the data buffer provided to it must
be allocated with the OBJ_TILED attribute and cannot exceed 64K in size.  There are times
when 64K is not enough for the entire data structure, in which case the structure is truncated.
This can lead to memory access violations upon trying to scan the structure.  To avoid this
problem you might want to use the :link reftype=hd res=70.DosQuerySysState:elink. function
instead.

:h2 res=41.DQPS.H
:lm margin=1.:font facename=Courier size=13x8.:xmp.
.im dqps.h
:exmp.:lm margin=1.:font facename=default.

:h1 res=50.DosQueryMemState
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET APIENTRY DosQueryMemState ( PVOID addr, PULONG psize, PULONG pflags ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS DOSQUERYMEMSTATE = DOSCALL1.307
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.PVOID addr    :font facename=default.  Base address of pages to be queried.
:li.:font facename=Courier size=13x8.PULONG psize  :font facename=default.  Pointer to location in user space that contains the requested size of the region to query.
:li.:font facename=Courier size=13x8.PULONG pflags :font facename=default.  Pointer to location in user space that will receive the attribute flags describing the region.
:esl.:lm margin=1.:p.
:hp5.Comments&colon.:ehp5.:p.
This function returns zero if successful.  The attribute flags are defined as follows&colon.
:table cols='20 10 40'.
:row.:c.PAG_NPOUT      :c.0x00000000:c.Page is not present, not in core.
:row.:c.PAG_PRESENT    :c.0x00000001:c.Page is present.
:row.:c.PAG_NPIN       :c.0x00000002:c.Page is not present, but in core.
:row.:c.PAG_PRESMASK   :c.0x00000003:c.Present state mask.
:row.:c.PAG_RESIDENT   :c.0x00000010:c.Page is resident (non-swappable).
:row.:c.PAG_SWAPPABLE  :c.0x00000020:c.Page is swappable.
:row.:c.PAG_DISCARDABLE:c.0x00000030:c.Page is discardable.
:etable.
The information returned by this function is extremely volatile, and decisions based upon it should reflect that volatility.

:h1 res=60.DosQueryModFromEIP
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET APIENTRY DosQueryModFromEIP ( HMODULE *phMod, ULONG *pObjNum, ULONG BuffLen, PCHAR pBuff, ULONG *pOffset, PVOID Address ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS DOSQUERYMODFROMEIP = DOSCALL1.360
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.HMODULE *phMod:font facename=default.  The address into which to store the address&apos.s module handle.
:li.:font facename=Courier size=13x8.ULONG *pObjNum:font facename=default.  The address into which to store the module&apos.s object/segment number.
:li.:font facename=Courier size=13x8.ULONG BuffLen :font facename=default.  The size of the buffer into which the module name will be stored.
:li.:font facename=Courier size=13x8.PCHAR pBuff   :font facename=default.  The address of the buffer into which the module name will be stored.
:li.:font facename=Courier size=13x8.ULONG *pOffset:font facename=default.  The address into which the offset into the module segment will be stored.
:li.:font facename=Courier size=13x8.PVOID Address :font facename=default.  The address to be analyzed.
:esl.:lm margin=1.:p.
:hp5.Comments&colon.:ehp5.:p.
This function may be used to get a program module name, segment number and offset within the
segment if you have an absolute address within the calling program.  This can be useful when
trying to build an exception handler for debugging.:p.
:hp5.Example&colon.:ehp5.:p.
In this code fragment, :hp2.pContextRecord:ehp2. is one of the parameters passed to an OS/2 exception handler.
:font facename=Courier size=13x8.:lm margin=6.:p.
HMODULE hModule ( 0 ) ;
.br
ULONG ObjectNumber ( 0 ), Offset ( 0 ) ;
.br
char ModuleName [ CCHMAXPATH + 1 ] = { 0 } ;
.br
DosQueryModFromEIP ( &amp.hModule, &amp.ObjectNumber, sizeof(ModuleName), ModuleName,
.br
   &amp.Offset, (PVOID)pContextRecord->ctx_RegEip ) ;
.br
printf ( "Exception occurred in module '%s', segment %i, offset %08X.\n",
.br
   ModuleName, ObjectNumber, Offset ) ;
:lm margin=1.:font facename=default.

:h1 res=70.DosQuerySysState
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET APIENTRY DosQuerySysState ( ULONG func, ULONG arg1, ULONG pid, ULONG _res_, PVOID buf, ULONG bufsz ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS Dos32QuerySysState = DOSCALLS.368
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.ULONG func :font facename=default.  Bit flag indicating which data is being requested.
:li.:font facename=Courier size=13x8.ULONG arg1 :font facename=default.  Reserved.  Set to zero :hp1.always:ehp1..
:li.:font facename=Courier size=13x8.ULONG pid  :font facename=default.  Process ID.  See notes.
:li.:font facename=Courier size=13x8.ULONG _res_:font facename=default.  Reserved.
:li.:font facename=Courier size=13x8.ULONG buf  :font facename=default.  Address of buffer for results.  See :link reftype=hd res=71.DOSQSS.H:elink. for the layout.
:li.:font facename=Courier size=13x8.ULONG bufsz:font facename=default.  Size of result buffer.
:esl.:lm margin=1.:p.
:hp5.Comments&colon.:ehp5.:p.
This function performs almost exactly the same function as the older :link reftype=hd res=40.DosQProcStat:elink.,
except that the 64K limit on buffer size has been removed, all addresses are in 0&colon.32 format, and
some more information has been added.:p.
The :hp2.func:ehp2. parameter is a bit array, with the following meanings&colon.
:lm margin=6.:sl compact.
:li.00000001 Process Data
:li.00000002 Process Semaphores (16-bit only?)
:li.00000004 Module Data
:li.00000008 File Data (see notes)
:li.00000010 Named Shared Memory
:esl.:lm margin=1.:p.
:hp5.Notes&colon.:ehp5.:p.
(1) The :hp2.pid:ehp2. parameter allows you to request information for a single process (if non-zero),
or for all processes on the system.  NOTE: Selection of a single process caused system hangs prior to
Warp 3.0 Fixpack 18.:p.
(2) The :hp2.arg1:ehp2. parameter :hp1.must:ehp1. be set to zero, or it may cause a system crash.
IBM has reported this problem fixed in APAR PJ21195.:p.
(3) File data is only supported from Warp 3.0 Fixpack 18 onwards.:p.
:hp5.Examples&colon.:ehp5.:sl compact.
:li.:link reftype=hd res=72.DOSQ - Query Processes:elink.
:li.:link reftype=hd res=73.LSOF - List Open Files:elink.
:esl.

:h2 res=71.DOSQSS.H
:lm margin=1.:font facename=Courier size=13x8.:xmp.
.im dosqss.h
:exmp.:lm margin=1.:font facename=default.

:h2 res=72.DOSQ.C - Query Processes (Example)
:lm margin=1.:font facename=Courier size=13x8.:xmp.
.im dosq.c
:exmp.:lm margin=1.:font facename=default.

:h2 res=73.LSOF.C - List Open Files (Example)
:lm margin=1.:font facename=Courier size=13x8.:xmp.
.im lsof.c
:exmp.:lm margin=1.:font facename=default.

:h1 res=80.DosReplaceModule
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET APIENTRY DosReplaceModule ( PSZ pszOldModule, PSZ pszNewModule, PSZ pszBackupModule ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS DosReplaceModule = DOSCALLS.417
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.PSZ pszOldModule   :font facename=default.  The name of the module being replaced.
:li.:font facename=Courier size=13x8.PSZ pszNewModule   :font facename=default.  The name of the replacement module. 
:li.:font facename=Courier size=13x8.PSZ pszBackupModule:font facename=default.  The new name of the old module.
:esl.:lm margin=1.:p.
:hp5.Comments&colon.:ehp5.:p.
When a DLL or EXE file is in use by the system, the file is locked.  
It can not therefore be replaced on the hard disk by a newer copy.
This API is to allow the replacement on the disk of the new module 
whilst the system continues to run the old module.
The contents of the file &apos.pszOldModule&apos. are cached by the system 
and the file is closed.  A backup copy of the file is created
as &apos.pszBackupModule&apos. for recovery purposes should the install
program fail.
The new module &apos.pszNewModule&apos. takes the place of the original
module on the disk.
:note.The system will continue to use the cached old module until all
references to it are released.  The next reference to the module will cause
a reload from the new module on disk.
:note.Only protect mode executable files can be replaced by this API.
This cannot be used for DOS/Windows programs, or for data files.
:note.pszNewModule and pszBackupModule may be NULL pointers.
:note.This API uses the swap file to cache the old module.  This API is
expensive in terms of disk space usage.
:note.Unlike some of the other undocumented APIs, this function IS defined
in os2386.lib, so you probably will not have to import it in your DEF file.
:p.:lm margin=1.
:hp5.Example&colon.:ehp5.:font facename=Courier size=13x8.:lm margin=6.:xmp.
int main ( int argc, char *argv[] ) {
   APIRET rc ;
   if ( argc != 4 ) {
      printf ( "Usage: <OldDll> <NewDll> <BackupDll>\n" ) ;
      return ( 1 ) ;
   }
   rc = DosReplaceModule ( argv[1], argv[2], argv[3] ) ;
   if ( rc ) {
      printf ( "Error %d.\n", rc ) ;
   }
   return ( rc ) ;
}
:exmp.:lm margin=1.:font facename=default.

:h1 res=90.DosSuppressPopUps
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET APIENTRY DosSuppressPopUps ( ULONG Flags, ULONG Drive ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS DosSuppressPopUps = DOSCALLS.114
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.ULONG Flags:font facename=default.  Option flags (see comments).
:li.:font facename=Courier size=13x8.ULONG Drive:font facename=default.  Logging drive ('A'=A: and so on), or zero to disable.
:esl.:lm margin=1.:p.
:hp5.Comments&colon.:ehp5.:p.
The option flag has two bits of interest&colon.
:lm margin=6.:sl compact.
:li.00000001 - Disable Popups (otherwise enable them)
:li.00000002 - Ignore drive parameter (otherwise use it)
:esl.:lm margin=1.:p.
:note.If the Ignore Drive bit of the Flags parameter is set, the Drive parameter :hp1.must:ehp1. be zero.

:h1 res=100.The Color Selection Control
:lm margin=1.:artwork name='clrwheel.bmp' align=center.
The color wheel control used by the Solid and Mixed Color Palette object is a publicly registered
window class within OS/2, but is undocumented.  The following notes are all that is
necessary to use this control class&colon.:p.
(1) You must load the module WPCONFIG.DLL so that the publicly registered window
message processor (ColorSelectWndProc) can be used without an addressing violation.:p.
(2) Create your control window with WinCreateWindow or through a dialog template,
using the window class name &odq.ColorSelectClass&cdq..:p.
(3) If you used WinCreateWindow you will need to reposition the control window each
time the parent window is resized, as otherwise the control will reposition itself
out of view.  Dialogs seem to handle this automatically.:p.
(4) The only control message defined -to- the control is 0x0602
under OS/2 Warp 4 or later, or (by some reports) 0x1384 on older versions of OS/2.
Message parameter one must contain the RGB value to which the color wheel will be set.:p.
(5) The only control message defined -from- the control is 0x0601
under OS/2 Warp 4 or later, or (by some reports) 0x130C on older versions of OS/2.
Message parameter one will contain the RGB value to which the color wheel has been set.:p.
(6) The control can only be sized at creation, and should be sized so that its height is
approximately 60% of its width.

:h1 res=110.HPFS Large Disk Access
DosRead/Write in direct-access mode will normally fail if the partition is greater than four
gigabytes in size.  If you wish to write an HPFS editor or other tool, you will need to know
the &odq.secret password&cdq. that unlocks the big disks.  After you use DosOpen to get 
a handle to that volume, use FSCTL FSC_SECTORIO (0x9014) and in the parameter list, put a 
pointer to 0xDEADFACE.  Doing so will put the handle in &odq.sector&cdq. mode.  All offsets
and sizes will refer to sectors instead of bytes, allowing you to address 64Gb.

:h1 res=120.Undocumented extensions to Event Semaphores
It is possible to do a post that releases one thread at a time as of fixpack 29 for Warp 3
and fixpack 4 for Warp 4.
:font facename=Courier size=13x8.:lm margin=6.:sl compact.
:li.#define DCE_AUTORESET 0x1000 // Auto-reset event semaphore
:li.#define DCE_POSTONE   0x0800 // Post one flag
:esl.:lm margin=1.:font facename=default.:p.
This feature only slightly changes the API of DosCreateEventSem.  Other APIs for
event semaphores are kept the same, although their behaviors are changed.
:p.
:hp5.DosCreateEventSem&colon.:ehp5.:p.
The flags argument can specify the new behaviors of the event semaphore&colon.
DCE_AUTORESET means the event automatically resets itself after a thread
obtains it through DosWaitEventSem, and DCE_POSTONE means that DosPostEventSem 
only wakes up one waiting thread if there is any.  
When DCE_POSTONE is specified, the event always automatically resets even
if DCE_AUTORESET is not specified.  We can define three types of events
with these two flags&colon.
:p.Neither DCE_AUTORESET nor DCE_POSTONE set&colon.  The event has default behavior,
which needs manual resets and wakes up all waiters when posted.
:p.DCE_AUTORESET set but not DCE_POSTONE&colon. The event resets it after a wait is
successfully executed.  It wakes up all waiters when posted.
:p.DCE_POSTONE set&colon. The event resets it automatically after a wait is successfully executed.  
But it only wakes up one waiter when posted.
:p.
:hp5.DosWaitEventSem&colon.:ehp5.:p.
For an AUTORESET event, it automatically resets itself after this is successfully executed.  
Otherwise, it leaves the event in signalled (posted) state.
:p.
:hp5.DosPostEventSem&colon.:ehp5.:p.
For a POSTONE event, it wakes up only one waiter if there is any thread
waiting for the event.  Otherwise, it wakes up all events.

:h1 res=130.How to reset the Physical Palette
Getting the 256-color mode palette manager to set itself up is not too hard, but
getting it to reset itself to the default palette is not documented well.
In the header file &apos.DIVE.H&apos. is a nice piece of explanation&colon.
:font facename=Courier size=13x8.:lm margin=6.:xmp.
Neither DiveSetSourcePalette nor DiveSetDestinationPalette API's will set
the physical palette.  If your application MUST set the PHYSICAL palette,
try using no more than 236 entries (the middle 236: 10-245, thus leaving
the top and bottom 10 entries for the Workplace Shell).  If your
application MUST use ALL 256 entries, it must do so as a full-screen
(i.e. maximized) application.  Remember, No WM_REALIZEPALETTE message
will be sent to other running applications, meaning they will not redraw
and their colors will be all wrong.  It is not recommended that a
developer use these commands:

To set physical palette, do the following:

   hps = WinGetPS ( HWND_DESKTOP );
   hdc = GpiQueryDevice ( hps );
   GpiCreateLogColorTable ( hps, LCOL_PURECOLOR | LCOL_REALIZABLE,
      LCOLF_CONSECRGB, 0, 256, (PLONG)plRGB2Entries );
   DiveSetPhysicalPalette ( hDiveInst, hdc );
   GreRealizeColorTable ( hdc ) ;
   WinInvalidateRect ( HWND_DESKTOP, (PRECTL)NULL, TRUE );
   WinReleasePS ( hps );

To reset physical palette, do the following:

   hps = WinGetPS ( HWND_DESKTOP ) ;
   hdc = GpiQueryDevice ( hps ) ;
   GreUnrealizeColorTable ( hdc ) ;
   WinInvalidateRect ( HWND_DESKTOP, (PRECTL)NULL, TRUE );
   WinReleasePS ( hps ) ;
:exmp.:lm margin=1.:font facename=default.
.br
I have altered these examples slightly for clarity, replacing the Gre32Entry3 
function calls with macros defined in &apos.PMDDIM.H&apos..

:h1 res=140.Extensions to WinQuerySysValue and WinSetSysValue
Several new system values have been defined in the Warp 4.0 (and possibly
in the newer fixpacks to Warp 3.0.  They are&colon.
:font facename=Courier size=13x8.:lm margin=6.:sl compact.
:li.#define SV_FULLWINDOWDRAG          99      /* FullWindowDrag            */
:li.#define SV_ALTTABSWITCHWIN        100      /* Alt-Tab Switching windows */ 
:li.#define SV_VIOMOUSEACTIONS        101      /* VIO mouse actions         */ 
:li.#define SV_ASYNCFOCUSCHANGE       102      /* Asynchronus focus change  */ 
:li.#define SV_FOCUSCHANGESENS        103      /* Focus Change sensivity    */
:esl.:lm margin=1.:font facename=default.:p.
The definition names given here are not official, and are not included in 
PMWIN.H.

:h1 res=150.Extensions to WinDrawBorder
There are at least two undocumented option flags for the WinDrawBorder function
which appear to have been provided to help in drawing pushbutton controls.
They are&colon.
:font facename=Courier size=13x8.:lm margin=6.:sl compact.
:li.#define DB_RAISED    0x0400 /* Draw 3-d border giving the window a raised appearance. */
:li.#define DB_DEPRESSED 0x0800 /* Draw 3-d border giving the window a sunken appearance. */
:esl.:lm margin=1.:font facename=default.:p.
The definition names given here are not official, and are not included in 
PMWIN.H.

:h1 res=160.WinSetTitle
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET16 APIENTRY16 WinSetTitle ( PSZ szTitle ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS WinSetTitle = PMSHAPI.93
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.PSZ szTitle:font facename=default.  New window title text.
:esl.:lm margin=1.:p.
:hp5.Comments&colon.:ehp5.:p.
This function is for VIO programs, and allows them to set their containing window's title text.
I have found that the Workplace Shell has a tendency to override this function.:p.
:hp5.Example Code&colon.:ehp5.:sl compact.
:li.:link reftype=hd res=161.WinSetTitle.c - Example code:elink.
:li.:link reftype=hd res=162.WinSetTitle.def - Linkage definitions:elink.
:esl.

:h2 res=161.WinSetTitle.c
:lm margin=1.:font facename=Courier size=13x8.:xmp.
.im WinSetTitle.c
:exmp.:lm margin=1.:font facename=default.

:h2 res=162.WinSetTitle.def
:lm margin=1.:font facename=Courier size=13x8.:xmp.
.im WinSetTitle.def
:exmp.:lm margin=1.:font facename=default.

:h1 res=170.WinSetTitleAndIcon
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
APIRET16 APIENTRY16 WinSetTitleAndIcon ( PSZ szTitle, PSZ szIconPath ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS WinSetTitleAndIcon = PMSHAPI.97
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.PSZ szTitle:font facename=default.  New window title text.
:li.:font facename=Courier size=13x8.PSZ szIconPath:font facename=default.  New window icon file name (full path).
:esl.:lm margin=1.:p.
:hp5.Comments&colon.:ehp5.:p.
This function is for VIO programs, and allows them to set their containing window's title text and icon.
I have found that the Workplace Shell has a tendency to override this function.:p.
:hp5.Example Code&colon.:ehp5.:sl compact.
:li.:link reftype=hd res=171.WinSetTitleAndIcon.c - Example code:elink.
:li.:link reftype=hd res=172.WinSetTitleAndIcon.def - Linkage definitions:elink.
:esl.

:h2 res=171.WinSetTitleAndIcon.c
:lm margin=1.:font facename=Courier size=13x8.:xmp.
.im WinSetTitleAndIcon.c
:exmp.:lm margin=1.:font facename=default.

:h2 res=172.WinSetTitleAndIcon.def
:lm margin=1.:font facename=Courier size=13x8.:xmp.
.im WinSetTitleAndIcon.def
:exmp.:lm margin=1.:font facename=default.

:h1 res=180.WinHSwitchFromHapp
:lm margin=1.
:hp5.Prototype&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
HSWITCH APIENTRY16 WinHSwitchFromHapp ( HAPP hApp ) ;
:lm margin=1.:font facename=default.:p.
:hp5.Linkage Definition&colon.:ehp5.:p.:font facename=Courier size=13x8.:lm margin=6.
IMPORTS WinHSwitchFromHapp = PMSHAPI.209
:lm margin=1.:font facename=default.:p.
:hp5.Parameters&colon.:ehp5.
:lm margin=6.:sl compact.
:li.:font facename=Courier size=13x8.HAPP hApp:font facename=default.  Application / Window Handle (see comments)
:esl.:lm margin=1.:p.
:hp5.Comments&colon.:ehp5.:p.
This function returns the system task list switch handle for an application, given that
application&apos.s handle.  In the case of WPS/SOM applications, however, the application
handle is really the window handle, so please use that in those cases.

:h1 res=190.Environment Variables
There are a number of undocumented environment variables that change the
behavior of the system.  These are a few of them&colon.
:lm margin=6.:sl.
:li.&sqbul.:font facename=Courier size=13x8.COPYFROMFLOPPY=1:font facename=default. - 
You have replaced one or more of the files on the installation floppies, and you have successfully booted
the installer in spite of your strange hardware.  The installation proceeds, but it pulls in replacements
to what you just replaced from either the later compressed diskettes, or from the CD.  When the first
phase of installation completes and the system reboots from the hard drive, you find that you no longer
are using the replacement drivers.  If you add this line to the CONFIG.SYS on install diskette 1 (before Warp 4.0)
or on install diskette 2 (Warp 4.0 or later), then the installer will reload the replacement files from the
early floppies before rebooting.
:li.&sqbul.:font facename=Courier size=13x8.KILLFEATUREENABLED=ON:font facename=default. -
This enables the display of the full process list from WarpCenter by clicking on the task list button
while pressing the Control key.  Selecting a program from the list pops up a message box to confirm
the killing of the process.
:li.&sqbul.:font facename=Courier size=13x8.MENUSFOLLOWPOINTER=ON:font facename=default. -
This makes the WarpCenter menus (but no others) behave more like the Start menu of Windows, 
in that once you open the menu, the menu selection will follow the mouse without your 
needing to keep the mouse button pressed down.  Submenus will automatically open as you
move the mouse pointer over them.  This function only works on Warp 4.0 with fixpack 5 or later.
:li.&sqbul.:font facename=Courier size=13x8.SCCANBENUKED=ON:font facename=default. -
Allows the WarpCenter to have a Delete option on its context menu.
:li.&sqbul.:font facename=Courier size=13x8.SCFINDUTILITY=c&colon.&bsl.os2&bsl.apps&bsl.pmseek.exe:font facename=default. -
This changes the function of the Find button on the WarpCenter to use PMSEEK instead of the limited-function default 
file finder.
:li.&sqbul.:font facename=Courier size=13x8.SCKILLCONFIRMDISABLED=ON:font facename=default. - ??
:li.&sqbul.:font facename=Courier size=13x8.SCKILLFEATUREENABLED=ON:font facename=default. -
This is the same as :font facename=Courier size=13x8.KILLFEATUREENABLED=ON:font facename=default..
:li.&sqbul.:font facename=Courier size=13x8.SCPRETTYCLOCK=1:font facename=default. -
This changes the appearance of the WarpCenter clock, giving it a fancier border,
a black background and green numbers.
:li.&sqbul.:font facename=Courier size=13x8.SHELLHANDLESINC=:font facename=default. -
This environment variable increments the number of file handles available to the Shell process (protshell).
Users who need more file handles can add this statement to CONFIG.SYS.  The maximum file handles will be
incremented by the amount specified in the statement.  The system defaults to 20 file handles in the Shell
process.  Therefore, if the statement specifies a 10, then the total would be incremented to 30.
:esl.:lm margin=1.

:euserdoc.
