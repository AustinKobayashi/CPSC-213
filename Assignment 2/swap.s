.pos 0x100
                 ld $array, r0          # r0 = address of array[0]
                 ld (r0), r1		        # r1 = array[0]
                 ld $t, r2              # r2 = address of t
                 st r1, (r2)		        # t = array[0]
                 ld $array, r0          # r0 = address of array[0]
                 ld 0x4(r0), r1		      # r1 = array[1]
                 st r1, (r0)		        # array[0] = array[1]
                 ld $t, r0              # r0 = address of t
                 ld (r0), r1		        # r1 = t
                 ld $array, r2          # r2 = address of array
                 st r1, 0x4(r2)		      # array[1] = t
                 halt                   # halt
.pos 0x1000
t:               .long 0x00000000         # t
.pos 0x2000
array:           .long 0xac123457         # array[0]
                 .long 0xffffffff         # array[1]
