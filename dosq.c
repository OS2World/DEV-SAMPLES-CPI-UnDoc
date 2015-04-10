#include <os2.h>
#include <stdio.h>
#include <stdlib.h>
#include "dosqss.h"

extern APIRET APIENTRY DosQuerySysState (ULONG func,
                                ULONG par1, ULONG pid, ULONG _reserved_,
                                PVOID buf,
                                ULONG bufsz);

static void dump_global(PQTOPLEVEL);
static void dump_process(PQTOPLEVEL);
static void dump_sema(PQTOPLEVEL);
static void dump_shrmem(PQTOPLEVEL);
static void dump_module(PQTOPLEVEL);
static void dump_files(PQTOPLEVEL);
static void dump_sema32(PQTOPLEVEL);

main(void)
{
        int i;
        APIRET rc;

#define BUFSIZE 128000l
#define RESERVED 0
        char *buf = malloc(BUFSIZE);
        memset(buf,0,BUFSIZE);

        rc = DosQuerySysState(0x3f, RESERVED, RESERVED, RESERVED, (PCHAR)buf, BUFSIZE);

        if (!rc) {
                PQTOPLEVEL top = (PQTOPLEVEL)buf;
                dump_global(top);
                dump_process(top);
                dump_module(top);
                dump_sema(top);
                dump_shrmem(top);
                dump_sema32(top);
                dump_files(top);
        }
}

static void dump_global(PQTOPLEVEL top)
{
        PQGLOBAL g = top->gbldata;

        printf("\n\n***** Global section: *****\n");
        printf("\t# of processes: %d\n",g->proccnt);
        printf("\t# of threads: %d\n",g->threadcnt);
        printf("\t# of modules: %d\n\n",g->modulecnt);
}

static void dump_process(PQTOPLEVEL top)
{
        PQPROCESS p = top->procdata;
        PQTHREAD t;
        int i;

        printf("\n\n***** Process section: *****\n");

        while (p && p->rectype == 1) {
                printf("\n    PID: %d\n",p->pid);
                printf("\tPPID: %d\n",p->ppid);
                printf("\ttype: %x\n",p->type);
                printf("\tstate: %x\n",p->state);
                printf("\tsession id: %d\n",p->sessid);
                printf("\tmod handle: %x\n",p->hndmod);
                printf("\t# of threads: %d\n",p->threadcnt);

                t = p->threads;
                for (i=0; i<p->threadcnt; i++,t++) {
                        printf("\t    TID: %d\n",t->threadid);
                        printf("\t\tslot: %x\n",t->slotid);
                        printf("\t\tsleepid: %x\n",t->sleepid);
                        printf("\t\tpriority: %x\n",t->priority);
                        printf("\t\tsystime: %d\n",t->systime);
                        printf("\t\tusertime: %d\n",t->usertime);
                        printf("\t\tstate: %d\n",t->state);
                }
                printf("\t# of 16 bit sema: %d\n",p->sem16cnt);
                if (p->sem16cnt) {
                        printf("\t\t");
                        for (i=0; i<p->sem16cnt; i++)
                                printf("%04X ",p->sem16s[i]);
                        printf("\n");
                }
                printf("\t# of dlls: %d\n",p->dllcnt);
                if (p->dllcnt) {
                        printf("\t\t");
                        for (i=0; i<p->dllcnt; i++)
                                printf("%04X ",p->dlls[i]);
                        printf("\n");
                }
                printf("\t# of shrmem: %d\n",p->shrmemcnt);
                if (p->shrmemcnt) {
                        printf("\t\t");
                        for (i=0; i<p->shrmemcnt; i++)
                                printf("%04X ",p->shrmems[i]);
                        printf("\n");
                }
                p = (PQPROCESS)t;
        }
}

static void dump_module(PQTOPLEVEL top)
{
        PQMODULE m = top->moddata;
        int i;

        printf("\n\n***** Module section: *****\n");

        while (m) {
                printf("\thandle: %x\n",m->hndmod);
                printf("\ttype: %d\n",m->type);
                printf("\treference count: %d\n",m->refcnt);
                if (m->refcnt) {
                        printf("\t\t");
                        for (i=0; i<m->refcnt; i++) {
                                printf("%04X ",m->modref[i]);
                        }
                        printf("\n");
                }
                printf("\tsegment count: %d\n",m->segcnt);
                printf("\tname: %s\n",m->name);
                m = m->next;
        }
}

static void dump_sema(PQTOPLEVEL top)
{
        PQSEMSTRUC s = top->semadata;
        PQSEMA p = &s->sema;
        int i;

        printf("\n\n***** Semaphore section: *****\n");
        while (p) {
                printf("\treference count: %d\n",p->refcnt);
                printf("\tflags: %x\n",p->sysflags);
                printf("\tproc count: %x\n",p->sysproccnt);
                printf("\tindex: %x\n",p->index);
                printf("\tname: %s\n",p->name);
                p = p->next;
        }
}

static void dump_shrmem(PQTOPLEVEL top)
{
        PQSHRMEM s = top->shrmemdata;

        printf("\n\n***** Shared Memory section: *****\n");
        while (s) {
                printf("\n    handle: %x\n",s->hndshr);
                printf("\tselector: %d\n",s->selshr);
                printf("\treference count: %d\n",s->refcnt);
                printf("\tname: %s\n",s->name);
                s = s->next;
        }
}

static void dump_files(PQTOPLEVEL top)
{
        PQFILE f = (PQFILE)top->filedata;
        PQFDS fd;

        printf("\n\n***** File data section: *****\n");
        while (f && f->rectype==8) {

                printf("\n    name: %s\n",f->name);
                printf("\topencnt: %d\n",f->opencnt);
                fd = f->filedata;
                printf("\tsfn: %x\n",fd->sfn);
                printf("\trefcnt: %d\n",fd->refcnt);
                printf("\tflags: %x\n",fd->flags);
                printf("\taccmode: %x\n",fd->accmode);
                printf("\tfilesize: %d\n",fd->filesize);
                printf("\tvolhnd: %d\n",fd->volhnd);
                printf("\tattrib: %x\n",fd->attrib);

                f = f->next;
        }
}

static void dump_sema32(PQTOPLEVEL top)
{
        PQSEM32STRUC s3 = (PQSEM32STRUC)top->sem32data;

        printf("\n\n***** SEM32 section: *****\n");
        while (s3) {
                printf("\n    pid: %d\n",s3->evsem.own->pid);
                printf("\towner: %d\n",s3->evsem.own->opencnt);
                printf("\tpid: %d\n",s3->muxsem.own->pid);
                printf("\towner: %d\n",s3->muxsem.own->opencnt);
                printf("\tpid: %d\n",s3->smuxsem.own->pid);
                printf("\towner: %d\n",s3->smuxsem.own->opencnt);

                s3 = s3->next;
        }
}
