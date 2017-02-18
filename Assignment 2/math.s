.pos 0x100
		ld $b, r0		# r0 = address of b
		ld (r0), r1		# r1 = b
		inc r1			# r1 = r1 + 1
		inca r1			# r1 = r1 + 4
		shr $0x1, r1		# r1 = r1 >> 1
		ld (r0), r2		# r2 = b
		and r2, r1		# r1 = r1 & b
		shl $0x2, r1		# r1 = r1 << 2
		ld $a, r3		# r3 = address of a
		st r1, (r3)		# a = r1
                halt                    # halt
.pos 0x1000
a:               .long 0x00000000        # a
.pos 0x2000
b:               .long 0xfffffffa        # b


