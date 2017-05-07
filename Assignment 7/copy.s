.pos 0x100
main:           ld   $stackBtm, r5       # sp = address of last word of stack
                inca r5                  # sp = address of word after stack

                gpc  $0x6, r6            # r6 = pc + 6
                j    copy                # call copy()

                halt

.pos 0x200
copy:           ld $-12, r0             # r0 = -12 = -(size of callee part of copy's frame)
                add r0, r5              # allocate callee part of copy's frame
                st r6, 0x8(r5)          # save return address on the stack

                ld $0, r0               # r0 = 0 = i

                ld $src, r1             # r1 = address of src

loop:           ld (r1, r0, 4), r3      # r3 = src[i]
                beq r3, end_copy        # if(src[i] == 0) goto end_copy

                st r3, (r5, r0, 4)      # dst[i] = src[i]
                inc r0                  # i++

                br loop                 # goto loop

end_copy:       ld $0, r4               # r4 = 0
                st r4, (r5, r0, 4)      # dst[i] = 0

                ld 0x8(r5), r6          # load return address from stack 
                ld $12, r0              # r0 = 12 = size of callee part of copy's frame
                add r0, r5              # deallocate callee part of copy's frame
                j 0x0(r6)               # return


.pos 0x1000
src:            .long 0x800c            # src
                .long 0x800c
                .long 0x800c
                .long 0X0000ffff
                .long 0Xffff6001
                .long 0x60026003
                .long 0x60046005
                .long 0x60066007
                .long 0xf000000
                .long 0




.pos 0x8000
stackTop:       .long 0x0
                .long 0x0
stackBtm:       .long 0x0










