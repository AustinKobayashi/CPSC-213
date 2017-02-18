#ifndef __refcount_h__
#define __refcount_h__

void* rc_malloc   (int nbytes);
void  rc_keep_ref (void* p);
void  rc_free_ref (void* p);
void  rc_print    (void* p);

#endif /*__refcount_h__*/
