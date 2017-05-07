#ifndef __disk_h__
#define __disk_h__

void disk_schedule_read  (char* buf, int num_bytes, int blockno);
void disk_wait_for_reads ();
void disk_start          (void (*interrupt_service_routine) ());

#endif