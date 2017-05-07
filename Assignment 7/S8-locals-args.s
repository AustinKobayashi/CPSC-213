.pos 0x100
start:           ld   $stackBtm, r5       # [01] sp = address of last word of stack
                 inca r5                  # [02] sp = address of word after stack
                 gpc  $0x6, r6            # [03] r6 = pc + 6
                 j    foo                 # [04] call foo()
                 halt

.pos 0x200
foo:             deca r5                  # [05] allocate callee part of foo's frame
                 st   r6, 0x0(r5)         # [06] save ra on stack

                 ld   $0xfffffff8, r0     # [07] r0 = -8 = -(size of caller part of b's frame)
                 add  r0, r5              # [08] allocate caller part of b's frame
                 ld   $0x0, r0            # [09] r0 = 0 = value of a0
                 st   r0, 0x0(r5)         # [00] save value of a0 to stack
                 ld   $0x1, r0            # [11] r0 = 1 = value of a1
                 st   r0, 0x4(r5)         # [12] store value of a1 to stack

                 gpc  $0x6, r6            # [13] set return address
                 j    b                   # [14] b (0, 1)

                 ld   $0x8, r0            # [15] r0 = 8 = size of caller part of b's frame
                 add  r0, r5              # [16] deallocate caller part of b's frame

                 ld   0x0(r5), r6         # [17] load return address from stack
                 inca r5                  # [18] deallocate callee part of foo's frame
                 j    0x0(r6)             # [19] return

.pos 0x400
b:               ld   $0xfffffff4, r0     # [20] r0 = -12 = -(size of callee part of b's frame)
                 add  r0, r5              # [21] allocate callee part of b's frame
                 st   r6, 0x8(r5)         # [22] store return address to stack

                 ld   0xc(r5), r0         # [23] r0 = a0
                 st   r0, 0x0(r5)         # [24] l0 = a0

                 ld   0x10(r5), r0        # [25] r0 = a1
                 st   r0, 0x4(r5)         # [26] l1 = a1

                 gpc  $0x6, r6            # [27] set return address
                 j    c                   # [28] c()

                 ld   0x8(r5), r6         # [29] load return address from stack
                 ld   $0xc, r0            # [30] r0 = 12 = size of callee part of b's frame
                 add  r0, r5              # [31] deallocate callee parts of b's frame
                 j    0x0(r6)             # [32] return

.pos 0x600
c:               j    0x0(r6)             # [01] return

.pos 0x1000
stackTop:        .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0                
                 .long 0x0
                 .long 0x0
                 .long 0x0                
                 .long 0x0
stackBtm:        .long 0x0
