.pos 0x100

    ld $tmp, r0         # r0 = address of tmp
    ld $0, r1           # r1 = 0
    st r1, 0(r0)        # tmp = 0

    ld $tos, r0         # r0 = address of tos
    st r1, 0(r0)        # tos = 0

    ld $a, r2           # r2 = address of a
    ld 0(r2), r3        # r3 = a[0]
    ld $s, r4           # r4 = address of s
    ld 0(r0), r5        # r5 = tos
    st r3, (r4, r5, 4)  # s[tos] = a[0]

    inc r1              # r1 = 1
    st r1, 0(r0)        # tos = 1

    ld 4(r2), r3        # r3 = a[1]
    ld 0(r0), r5        # r5 = tos
    st r3, (r4, r5, 4)  # s[tos] = a[1]

    inc r1              # r1 = 2
    st r1, 0(r0)        # tos = 2

    ld 8(r2), r3        # r3 = a[2]
    ld 0(r0), r5        # r5 = tos
    st r3, (r4, r5, 4)  # s[tos] = a[2]

    inc r1              # r1 = 3
    st r1, 0(r0)        # tos = 3

    dec r1              # r1 = 2
    st r1, 0(r0)        # tos = 2

    ld 0(r0), r2        # r2 = tos
    ld (r4, r2, 4), r3  # r3 = s[tos]
    ld $tmp, r5         # r5 = address of tmp
    st r3, 0(r5)        # tmp = s[tos]

    dec r1              # r1 = 1
    st r1, 0(r0)        # tos = 1

    ld 0(r0), r2        # r2 = tos
    ld (r4, r2, 4), r3  # r3 = s[tos]
    ld $tmp, r5         # r5 = address of tmp
    ld 0(r5), r6        # r6 = tmp
    add r3, r6          # r6 = tmp + s[tos]
    st r6, 0(r5)        # tmp = tmp + s[tos]

    dec r1              # r1 = 0
    st r1, 0(r0)        # tos = 0

    ld 0(r0), r2        # r2 = tos
    ld (r4, r2, 4), r3  # r3 = s[tos]
    ld $tmp, r5         # r5 = address of tmp
    ld 0(r5), r6        # r6 = tmp
    add r3, r6          # r6 = tmp + s[tos]
    st r6, 0(r5)        # tmp = tmp + s[tos]

    halt

.pos 0x200
# Data area

a:  .long 1             # a[0]
    .long 2             # a[1]
    .long 3             # a[2]
s:  .long 0             # s[0]
    .long 0             # s[1]
    .long 0             # s[2]
    .long 0             # s[3]
    .long 0             # s[4]
tos:.long 0             # tos
tmp:.long 0             # tmp

