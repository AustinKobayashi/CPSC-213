.pos 0x100
start:           ld   $stackBtm, r5       # [01] sp = address of last word of stack
                 inca r5                  # [02] sp = address of word after stack
                 gpc  $6, r6              # [03] ra = pc + 6
                 j    foo                 # [04] call foo()
                 halt

.pos 0x200
foo:             deca r5                  # [05] allocate calle part of foo's frame
                 st   r6, (r5)            # [06] save ra on stack

                 ld   $1, r0              # [07] r0 = 1, value of first arg
                 ld   $2, r1              # [08] r1 = 2, value of second arg

                 gpc  $6, r6              # [09] r6 = pc + 6
                 j    add                 # [10] call add (1,2)

                 ld   $s, r1              # [11] r1 = &s
                 st   r0, (r1)            # [12] s = add (1,2)

                 ld   (r5), r6            # [13] load ra from stack
                 inca r5                  # [14] remove callee part of stack frame

                 j    (r6)                # [15] return

.pos 0x300
add:             add  r1, r0              # [16] return value = a + b
                 j    (r6)                # [17] return

.pos 0x280
s:               .long 0x00000000         # s

.pos 0x1000
stackTop:        .long 0x00000000
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
                 .long 0x00000000         
stackBtm:        .long 0x00000000
