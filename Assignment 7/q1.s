.pos 0x0                                # main
                 ld   $sb, r5           # [01] sp = address of last word of stack
                 inca r5                # [02] sp = address of word after stack
                 gpc  $6, r6            # [03] ra = pc + 6
                 j    0x300             # [04] jump to 0x300
                 halt                     
.pos 0x100
                 .long 0x00001000         
.pos 0x200
                 ld   0x0(r5), r0       # [20],[38] r0 = arg3
                 ld   0x4(r5), r1       # [21],[39] r1 = arg4
                 ld   $0x100, r2        # [22],[40] r2 = 0x100
                 ld   0x0(r2), r2       # [23],[41] r2 = 0x1000 = address of arr
                 ld   (r2, r1, 4), r3   # [24],[42] r3 = arr[arg1]    
                 add  r3, r0            # [25],[43] r0 = arr[arg1] + arg0
                 st   r0, (r2, r1, 4)   # [26],[44] arr[arg1] = arr[arg1] + arg0
                 j    0x0(r6)           # [27],[45] return

.pos 0x300                              # foo()
                 ld   $0xfffffff4, r0   # [05] r0 = -12 = -(size of callee part of foo's frame)
                 add  r0, r5            # [06] allocate calle part of foo's frame
                 st   r6, 0x8(r5)       # [07] save ra on stack 
                 ld   $0x1, r0          # [08] r0 = 1, the value of arg0
                 st   r0, 0x0(r5)       # [09] save arg0 on stack
                 ld   $0x2, r0          # [10] r0 = 2, the value of arg1
                 st   r0, 0x4(r5)       # [11] save arg1 on stack

                 ld   $0xfffffff8, r0   # [12] r0 = -8 = -(size of caller part of 0x200 frame)
                 add  r0, r5            # [13] allocate caller part of 0x200 frame
                 ld   $0x3, r0          # [14] r0 = 3, value of arg3
                 st   r0, 0x0(r5)       # [15] save arg3 to stack
                 ld   $0x4, r0          # [16] r0 = 4, value of arg4
                 st   r0, 0x4(r5)       # [17] save arg4 to stack
                 gpc  $6, r6            # [18] r6 = pc + 6
                 j    0x200             # [19] jump to 0x200

                 ld   $0x8, r0          # [28] r0 = 8 = size of caller part of 0x200 frame
                 add  r0, r5            # [29] deallocate caller part of 0x200 frame
                 ld   0x0(r5), r1       # [30] r1 = arg0
                 ld   0x4(r5), r2       # [31] r2 = arg1

                 ld   $0xfffffff8, r0   # [32] r0 = -8 = -(size of caller part of 0x200 frame)
                 add  r0, r5            # [33] allocate caller part of 0x200 frame 
                 st   r1, 0x0(r5)       # [34] save arg0 to stack
                 st   r2, 0x4(r5)       # [35] save arg1 to stack
                 gpc  $6, r6            # [36] r6 = pc + 6
                 j    0x200             # [37] jump to 0x200

                 ld   $0x8, r0          # [46] r0 = 8 = size of caller part of 0x200 frame
                 add  r0, r5            # [47] deallocate caller part of 0x200 frame
                 ld   0x8(r5), r6       # [48] load ra from stack
                 ld   $0xc, r0          # [49] r0 = 12 = size of calle part of foo's frame
                 add  r0, r5            # [50] remove callee part of stack frame
                 j    0x0(r6)           # [51] return


.pos 0x1000
                 .long 0x00000000       #arr[0]
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
.pos 0x8000
# These are here so you can see (some of) the stack contents.
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
    .long 0
sb: .long 0
