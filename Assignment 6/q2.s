.pos 0x1000
		ld $i, r0			# r0 = address of i
		ld $0, r1			# r1 = 0
		ld $a, r2			# r2 = address of a
		ld $s, r4			# r4 = address of s
		ld $5, r6			# r6 = 5
		st r1, 0(r0)		# i = 0

loop:	ld 0(r0), r1		# r1 = i
		ld (r2, r1, 4), r3	# r3 = a[i]
		bgt r3, true		# if r3 > 0 jump to true
		j false				# if r3 <= 0 jump to false

true:   ld 0(r4), r5		# r5 = s
		add r3, r5			# r5 =  a[i] + s
		st r5, 0(r4)		# s = a[i] + s

false: 	inc r1				# r1 = 1
		st r1, 0(r0)		# i = 0
		ld 0(r0), r1		# r1 = i
		not r1				# r1 = -i - 1
		inc r1				# r1 = -i
		add r6, r1			# r1 = 5 - i
		bgt r1, loop		# if i < 5 jump to loop
		halt

#Globals
.pos 0x2000
i:		.long 10
a:		.long 10
		.long 0xFFFFFFE2
		.long 0xFFFFFFF4
		.long 4
		.long 8
s:		.long 0