.pos 0x0

#test branch
branch:			br 8
				ld $0, r0
				halt

#test branch if equal (false)
branch_if_eq_F:	ld $2, r0
				beq r0, branch_if_eq_F
				halt	

#test branch if equal (true)
branch_if_eq_T:	ld $0, r0
				beq r0, br
				ld $2, r1
br:				halt	

#test jump
jump:			j j
				ld $0, r0	
j:				ld $1, r0				
				halt

#test get pc
GetPc:			gpc $0, r0
				halt

#test indirect jump
indr_jump:		ld $j1, r0
				j 6(r0)
				ld $0, r1
j1:				ld $0, r1
				halt