#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <sys/errno.h>
#include <assert.h>
#include "uthread.h"
#include "disk.h"

unsigned long sum = 0;

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
 * Read and process num_blocks blocks.
 */
void run (int num_blocks) {
    char buf[8];
    for (int blockno = 0; blockno < num_blocks; blockno++) {
        disk_schedule_read  (buf, sizeof (buf), blockno);
        disk_wait_for_reads ();
        handle_read         (buf, blockno);
    }
}

int main (int argc, char** argv) {
    static const char* usage = "usage: sRead numBlocks";
    int num_blocks = 0;
    
    if (argc == 2)
        num_blocks = strtol (argv [1], NULL, 10);
    if (argc != 2 || (num_blocks == 0 && errno == EINVAL)) {
        printf ("%s\n", usage);
        return EXIT_FAILURE;
    }
    
    uthread_init (1);
    disk_start   (NULL);
    
    run (num_blocks);
    
    printf ("%ld\n", sum);
}
