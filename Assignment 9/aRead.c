#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/errno.h>
#include <assert.h>
#include "uthread.h"
#include "queue.h"
#include "disk.h"

unsigned long sum = 0;

/**
 * Queue of pending reads
 */
queue_t prq;

/**
 * Layout of pending read struct that stores information about reads
 * that have been requested but have not yet completed.
 */
struct pending_read {
    char* buf;
    int   blockno;
    void  (*handler) (char*, int);
};

/**
 * Initialize pending_read struct
 */
void init_pending_read (struct pending_read* pr, char* buf, int blockno, void (*handler)(char*,int)) {
    pr->buf     = buf;
    pr->blockno = blockno;
    pr->handler = handler;
}

/**
 * Called automatically when an interrupt occurs to signal that a read has completed.
 */
void interrupt_service_routine() {

    struct pending_read* pr;
    pr = queue_dequeue(&prq);
    pr->handler (pr->buf, pr->blockno);
}

/**
 * Handle read by ensuring the buffer stores the correct data by
 *  (1) asserting that the first 4 bytes store the correct blockno; and
 *  (2) summing the value in the next 4 bytes as indicated
 * Marking is based partially on having the right value of sum when the
 * program completes.  Note that value written in the second 4 bytes may
 * be different when the assignment is marked.
 */
void handle_read (char* buf, int blockno) {
    assert (*((int*) buf) == blockno);
    sum = sum * 1.1 + *(((int*) buf) + 1);
}

/**
 * Read a count of num_blocks and wait for all reads to complete
 */
void run (int num_blocks) {
    
    char buf [num_blocks] [8];
    struct pending_read pr [num_blocks];
    
    for (int blockno = 0; blockno < num_blocks; blockno++) {
        init_pending_read(&pr[blockno], buf[blockno], blockno, handle_read);
        queue_enqueue(&prq, &pr[blockno]);
        disk_schedule_read (buf[blockno], sizeof(buf[blockno]), blockno);
    }
    disk_wait_for_reads();
}

int main (int argc, char** argv) {
    
    static const char* usage = "usage: aRead numBlocks";
    int num_blocks = 0;
    
    if (argc == 2)
        num_blocks = strtol (argv [1], NULL, 10);
    if (argc != 2 || (num_blocks == 0 && errno == EINVAL)) {
        printf ("%s\n", usage);
        return EXIT_FAILURE;
    }
    
    uthread_init (1);
    disk_start   (interrupt_service_routine);
    queue_init   (&prq);
    
    run (num_blocks);
    
    printf ("%ld\n", sum);
}
