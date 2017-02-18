.pos 0x100
        ld $a, r0           # r0 = address of a
        ld 12(r0), r1       # r1 = a[3]
        ld $i, r2           # r2 = address of i
        st r1, 0(r2)        # i = a[3]

        ld 0(r2), r1        # r1 = i
        ld (r0, r1, 4), r1  # r1 = a[i]
        st r1, 0(r2)        # i = a[i]

        ld $j, r0           # r0 = address of j
        ld $p, r1           # r1 = address of p
        st r0, 0(r1)        # p = address of j

        ld $4, r2           # r2 = 4
        ld 0(r1), r3        # r3 = address of j
        st r2, 0(r3)        # *p = j = 4

        ld $a, r0           # r0 = address of a
        ld 8(r0), r1        # r1 = a[2]
        ld (r0, r1, 4), r2  # r2 = a[a[2]]
        shl $2, r1          # r1 = 4 * a[2]
        add r1, r0          # r0 = address of a[a[2]]
        ld $p, r2           # r2 = address of p
        st r0, 0(r2)        # p = address of a[a[2]]

        ld $p, r0           # r0 = address of p
        ld 0(r0), r1        # r1 = p = address of a[a[2]]
        ld 0(r1), r2        # r2 = p*
        ld $4, r3           # r3 = 4
        ld $a, r4           # r4 = address of a
        ld (r4, r3, 4), r5  # r5 = a[4]
        add r5, r2          # r2 = p* + a[4]
        st r2, 0(r1)        # a[a[2]] = p* + a[4]
        halt
.pos 0x200
i:               .long 0x0                # i
j:               .long 0x8                # j
p:               .long 0x0                # p
a:               .long 0x0                # a[0]
                 .long 0x0                # a[1]
                 .long 0x3                # a[2]
                 .long 0x5                # a[3]
                 .long 0x9                # a[4]
                 .long 0x7                # a[5]
                 .long 0x0                # a[6]
                 .long 0x0                # a[7]
                 .long 0x0                # a[8]
                 .long 0x0                # a[9]
