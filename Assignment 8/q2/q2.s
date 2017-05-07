.pos 0x0
                 ld   $0x1028, r5           # initialize the stack pointer
                 ld   $0xfffffff4, r0       # r0 = -12 = -(size of caller part of q2's frame)
                 add  r0, r5                # allocate caller part of q2's frame
                 ld   $0x200, r0            # r0 = address of arr[0]
                 ld   0x0(r0), r0           # r0 = arr[0]
                 st   r0, 0x0(r5)           # save arr[0] on stack
                 ld   $0x204, r0            # r0 = address of arr[1]
                 ld   0x0(r0), r0           # r0 = arr[1]
                 st   r0, 0x4(r5)           # save arr[1] on stack
                 ld   $0x208, r0            # r0 = address of arr[2]
                 ld   0x0(r0), r0           # r0 = arr[2]
                 st   r0, 0x8(r5)           # save arr[2] on stack
                 gpc  $6, r6                # ra = pc + 6
                 j    0x300                 # jump to foo()
                 ld   $0x20c, r1            # r1 = arr[3]
                 st   r0, 0x0(r1)           # arr[3] = arg2
                 halt                     
.pos 0x200
                 .long 0x00000001           # arr[0]
                 .long 0x00000002           # arr[1]
                 .long 0x00000003           # arr[2]
                 .long 0x00000004           # arr[3]

.pos 0x300                                  # q2
                 ld   0x0(r5), r0           # r0 = arg0
                 ld   0x4(r5), r1           # r1 = arg1
                 ld   0x8(r5), r2           # r2 = arg2
                 ld   $0xfffffff6, r3       # r3 = -10
                 add  r3, r0                # r0 = arg0 - 10
                 mov  r0, r3                # r3 = arg0 - 10
                 not  r3                    # r3 = 10 - arg0 - 1
                 inc  r3                    # r3 = 10 - arg0
                 bgt  r3, L6                # if(arg0 < 10) goto L6
                 mov  r0, r3                # r3 = arg0 - 10
                 ld   $0xfffffff8, r4       # r4 = -8
                 add  r4, r3                # r3 = arg0 - 18
                 bgt  r3, L6                # if (arg0 > 18) goto L6
                 ld   $0x400, r3            # r3 = address of jump table
                 j    *(r3, r0, 4)          # jump to 0x400[arg0 - 10]
.pos 0x330
                 add  r1, r2                # arg2 = arg2 + arg1
                 br   L7                    # goto L7
                 not  r2                    # r2 = -arg2 - 1
                 inc  r2                    # r2 = -arg2
                 add  r1, r2                # arg2 = arg1 - arg2
                 br   L7                    # goto L7
                 not  r2                    # r2 = -arg2 - 1
                 inc  r2                    # r2 = -arg2
                 add  r1, r2                # r2 = arg1 - arg2
                 bgt  r2, L0                # if (arg1 > arg2) goto L0
                 ld   $0x0, r2              # arg2 = 0
                 br   L1                    # goto L1
L0:              ld   $0x1, r2              # arg1 = 1
L1:              br   L7                    # goto L7
                 not  r1                    # r1 = -arg1 - 1
                 inc  r1                    # r1 = -arg1
                 add  r2, r1                # r1 = arg2 - arg1
                 bgt  r1, L2                # if (arg2 > arg1) 
                 ld   $0x0, r2              # arg2 = 0
                 br   L3                    # goto L3
L2:              ld   $0x1, r2              # arg2 = 1
L3:              br   L7                    # goto L7
                 not  r2                    # r2 = -arg2 - 1
                 inc  r2                    # r2 = -arg2
                 add  r1, r2                # r2 = arg1 - arg2
                 beq  r2, L4                # if (arg1 == arg2) goto L4
                 ld   $0x0, r2              # r2 = 0
                 br   L5                    # goto L5
L4:              ld   $0x1, r2              # arg2 = 1
L5:              br   L7                    # goto L7
L6:              ld   $0x0, r2              # r2 = 0
                 br   L7                    # goto L7
L7:              mov  r2, r0                # arg2 = return value
                 j    0x0(r6)               # return

.pos 0x400                                  # jump table
                 .long 0x00000330           # J330
                 .long 0x00000384           # J384
                 .long 0x00000334           # J334
                 .long 0x00000384           # J384
                 .long 0x0000033c           # J33C
                 .long 0x00000384           # J384
                 .long 0x00000354           # J354
                 .long 0x00000384           # J384
                 .long 0x0000036c           # J36C

.pos 0x1000                                 # stack
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
