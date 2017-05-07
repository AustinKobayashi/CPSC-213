## This is the solution to CPSC 213 Assignment 6
## Do not distribute any part of this file to anyone for any reason
## Do not remove this comment

.pos 0x1000

# compute average
average:
    ld    $n, r0      # r0 = &n
    ld    (r0), r0    # r0 = n = n'
    ld    $s, r1      # r1 = &s
    ld    (r1), r1    # r1 = s = s'
    ld    $24, r2     # r2 = 24 = sizeof(struct Student)
A0: beq   r0, sort    # goto sort if n' == 0
    ld    4(r1), r3   # r3 = s'->grade[0]
    ld    8(r1), r4   # r4 = s'->grade[1]
    add   r4, r3      # r3 = s'->grade[0] + s-'grade[1]
    ld    12(r1), r4  # r4 = s'->grade[2]
    add   r4, r3      # r3 = s'->grade[0] + s-'grade[1] + s'->grade[2]
    ld    16(r1), r4  # r4 = s'->grade[3]
    add   r4, r3      # r3 = s'->grade[0] + s-'grade[1] + s'->grade[2] + s'->grade[3]
    shr   $2, r3      # r3 = (s'->grade[0] + s-'grade[1] + s'->grade[2] + s'->grade[3]) / 4
    st    r3, 20(r1)  # s'->average = (s'->grade[0] + s-'grade[1] + s'->grade[2] + s'->grade[3]) / 4
    add   r2, r1      # s' ++
    dec   r0          # n'--
    br    A0          # goto A0

# sort
sort:
    ld    $n, r0      # r0 = &n
    ld    (r0), r0    # r0 = n = n'
    ld    $s, r7      # r7 = &s
    ld    (r7), r7    # r7 = s

    # outer loop
    dec   r0          # n'--
B0: beq   r0, B9      # goto B9 if n' == 0
    ld    $1, r1      # r1 = j' = 1

    # inner loop
C0: mov   r0, r3      # r3 = n'
    not   r3
    inc   r3          # r3 = -n'
    add   r1, r3      # r3 = j' - n'
    bgt   r3, C9      # goto C9 if j' == 'n

    # compare ...
    mov   r1, r2      # r2 = j'
    mov   r1, r3      # r3 = j'
    shl   $4, r2      # r2 = j' * 16
    shl   $3, r3      # r3 = j' * 8
    add   r3, r2      # r2 = j' * 24
    add   r7, r2      # r2 = &s[j']
    mov   r2, r3      # r3 = &s[j']
    ld    $-24, r4    # r3 = -24 = - sizeof (struct Student)
    add   r4, r2      # r2 = &s[j'-1]]
    ld    20(r2), r4  # r4 = s[j'-1].average
    ld    20(r3), r5  # r5 = s[j'].average
    not   r4
    inc   r4          # r5 = -s[j'-1].average
    add   r5, r4      # r4 = s[j'].average - s[j'-1].average
    bgt   r4, C1      # goto C1 if s[j'-1].average < s[j'].average
    beq   r4, C1      # goto C1 if s[j'-1].average == s[j'].average
    # ... compare

    # swap ...        # if if s[j'-1].average > s[j'].average; int *a' = &s[j'-1], *b' = &s[j']
    ld    $6, r4      # r4 = 6 = sizeof (struct Student) / 4 = k'
D0: beq   r4, C1      # goto C1 if k' == 0
    ld    (r2), r5    # r5  = *a'
    ld    (r3), r6    # r6  = *b'
    st    r6, (r2)    # *a' = *b'
    st    r5, (r3)    # *b' = *a'
    inca  r2          # a'++
    inca  r3          # b'++
    dec   r4          # k'--
    br    D0          # goto D0
    # ... swap

    # inner loop back to start
C1: inc   r1          # j'++
    br    C0          # goto C0

    # outer loop back to start
C9: dec   r0          # n'--
    br    B0          # goto B0

# median
B9: ld    $n, r0      # r0 = &n
    ld    (r0), r0    # r0 = n
    shr   $1, r0      # r0 = n/2
    mov   r0, r1      # r1 = n/2
    shl   $4, r0      # r0 = (n/2) * 16
    shl   $3, r1      # r1 = (n/2) * 8
    add   r1, r0      # r0 = (n/2) * 24
    ld    $s, r1      # r1 = &s
    ld    (r1), r1    # r1 = s
    add   r1, r0      # r0 = &s[n/2]
    ld    (r0), r0    # r0 = s[n/2].sid
    ld    $m, r1      # r1 = &m
    st    r0, (r1)    # m  = s[n/2].sid
    halt

.pos 0x2000
n:    .long 7     # just one student
m:    .long 0     # put the answer here
s:    .long base  # address of the array
base:
.long 1
.long 80
.long 60
.long 78
.long 90
.long 0

.long 2
.long 20
.long 18
.long 12
.long 20
.long 0

.long 3
.long 90
.long 50
.long 30
.long 10
.long 0

.long 4
.long 10
.long 20
.long 80
.long 90
.long 0

.long 5
.long 60
.long 61
.long 62
.long 63
.long 0

.long 6
.long 50
.long 10
.long 70
.long 10
.long 0

.long 7
.long 21
.long 22
.long 23
.long 24
.long 0

