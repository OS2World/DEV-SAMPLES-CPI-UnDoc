#include <os2.h>

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "dosqss.h"

extern APIRET APIENTRY DosQuerySysState (ULONG func, 
                                ULONG par1, ULONG pid, ULONG _reserved_,
                                PVOID buf,
                                ULONG bufsz);

static void dump_files(PQTOPLEVEL);

extern void main ( void )
{
        APIRET rc;

#define BUFSIZE 128000l
#define RESERVED 0
        char *buf = malloc(BUFSIZE);
        memset(buf,0,BUFSIZE);

        rc = DosQuerySysState(0x1f, RESERVED, RESERVED, RESERVED, (PCHAR)buf, BUFSIZE);

        if (!rc) {
                PQTOPLEVEL top = (PQTOPLEVEL)buf;
                dump_files(top);
        }
}

static void dump_files(PQTOPLEVEL top)
{
        PQFILE f = (PQFILE)top->filedata;
        PQFDS fd;

        printf("SFN   Opncnt  Flags   Accmode    Size   Volhnd Attrib Name\n");
        printf("----- ------ -------- -------- -------- ------ ------ ----------------\n");

        while (f && f->rectype == 8) {
                fd = f->filedata;
                printf("%5x %6d %08x %08x %8d %05x ",
                        fd->sfn,
                        f->opencnt,
                        fd->flags,
                        fd->accmode,
                        fd->filesize,
                        fd->volhnd);
                putchar((fd->attrib & 0x20) ? 'A' : '-');
                putchar((fd->attrib & 0x10) ? 'D' : '-');
                putchar((fd->attrib & 0x08) ? 'L' : '-');
                putchar((fd->attrib & 0x04) ? 'S' : '-');
                putchar((fd->attrib & 0x02) ? 'H' : '-');
                putchar((fd->attrib & 0x01) ? 'R' : '-');
                printf(" %s\n",f->name);
                f = f->next;
        }
}

