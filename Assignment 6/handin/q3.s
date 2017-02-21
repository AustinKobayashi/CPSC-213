.pos 0x1000

#calculate average
			ld $s, r0				# r0 = address of s
			ld $0, r1				# r1 = 0 = i
			ld $n, r7				# r7 = address of n
			ld 0(r7), r7			# r7 = n

avg_loop:	mov r1, r2				# r2 = i
			mov r1, r3				# r3 = i
			shl $1, r2				# r2 = i * 2
			shl $2, r3				# r3 = i * 4
			add r3, r2				# r2 = i * 6

			# get grade 0 of student i
			ld $2, r3				# r3 = 2
			add r2, r3				# r3 = 2 + i * 6
			ld (r0, r3, 4), r3		# r3 = grade 0

			# get grade 1 of student i and add it to grade 0
			ld $3, r4				# r4 = 3
			add r2, r4				# r4 = 3 + i * 6
			ld (r0, r4, 4), r4		# r4 = grade 1
			add r4, r3				# r3 = grade 0 + grade 1

			# get grade 2 of student i
			ld $4, r4				# r4 = 4
			add r2, r4				# r4 = 4 + i * 6
			ld (r0, r4, 4), r4		# r4 = grade 2

			# get grade 3 of student i
			ld $5, r5				# r5 = 5
			add r2, r5				# r5 = 5 + i * 6
			ld (r0, r5, 4), r5		# r5 = grade 3

			# sum all of the grades and divide by 4
			add r5, r4				# r4 = grade 2 + grade 3
			add r4, r3				# r3 = grade 0 + grade 1 + grade 2 + grade 3
			shr $2, r3				# r3 = average of grades

			# store the computed avg for student i
			ld $6, r4				# r4 = 6
			add r2, r4				# r4 = 6 + i * 6
			st r3, (r0, r4, 4)		# computed avg = avg

			# check to see whether or not to loop
			inc r1					# r1 = i++
			mov r1, r3				# r3 = i
			not r3					# r3 = -i - 1
			inc r3					# r3 = -i
			add r7, r3				# r3 = n - i
			bgt r3, avg_loop		# jump to avg_loop if n - i > 0
			j sort					# jump to sort
			halt



#sort the list (using i for inner loop and j for outer loop)
sort:		ld $0, r1				# r1 = 0 = i
			ld $n, r2				# r2 = address of n
			ld (r2), r2				# r2 = n
			ld $-1, r3				# r3 = -1
			add r3, r2				# r2 = n - 1 = j
			ld $j, r4				# r4 = address of j
			st r2, 0(r4)			# r2 = j

sort_comp:  j compare				# compare student i and student i + 1

sort_loop:  inc r1					# r1 = i++
			ld $j, r2				# r2 = address of j
			ld 0(r2), r2			# r2 = j
			mov r1, r3				# r3 = i
			not r3					# r3 = -i - 1
			inc r3					# r3 = -i
			add r2, r3				# r3 = j - i
			bgt r3, sort_comp		# jump to sort_comp if j - i > 0

			ld $-1, r3				# r3 = -1
			add r3, r2				# r2 = j--
			ld $j, r4				# r4 = address of j
			st r2, 0(r4)			# r2 = j
			ld $0, r1				# r1 = 0 = i
			bgt r2, sort_comp		# jump to sort_comp if j > 0
			
			j median				# jump to median

			halt
			


#Find median
median:		ld $n, r1				# r1 =  address of n
			ld 0(r1), r1			# r1 = n
			shr $1, r1				# r1 = n/2 if n is odd

			mov r1, r2				# r2 = n/2
			mov r1, r3				# r3 = n/2
			shl $1, r2				# r2 = n/2 * 2
			shl $2, r3				# r3 = n/2 * 4
			add r3, r2				# r2 = n/2 * 6

			ld $1, r3				# r3 = 1
			add r2, r3				# r3 = 1 + n/2 * 6
			ld (r0, r3, 4), r4		# r4 = avg of median student
			
			ld $m, r5				# r5 = address of m
			st r4,  0(r5)			# m = median average

			halt



#compare grades and swap
compare:	mov r1, r2				# r2 = i
			mov r1, r3				# r3 = i
			shl $1, r2				# r2 = i * 2
			shl $2, r3				# r3 = i * 4
			add r3, r2				# r2 = i * 6

			ld $6, r3				# r3 = 6
			ld $12, r5				# r5 = 12

			add r2, r3				# r3 = 6 + i * 6
			add r2, r5				# r5 = 12 + i * 6

			ld (r0, r3, 4), r4		# r4 = avg of student i
			ld (r0, r5, 4), r6		# r6 = avg of student i + 1

			not r6					# r6 = -r6 - 1
			inc r6					# r6 = -avg of student i + 1
			add r6, r4				# r4 = r4 - r6
			bgt r4, swap			# swap if avg of student i > than that of i + 1
			j sort_loop				# else jump back to sort
			halt



#swap adjacent students
swap:		mov r1, r2				# r2 = i
			mov r1, r3				# r3 = i
			shl $1, r2				# r2 = i * 2
			shl $2, r3				# r3 = i * 4
			add r3, r2				# r2 = i * 6

			ld $1, r3				# r3 = 1
			ld $7, r5				# r5 = 7
			ld $7, r7				# r7 = 7
			add r2, r7				# r7 = 7 + i * 6

			add r2, r3				# r3 = 1 + i * 6
			add r2, r5				# r5 = 7 + i * 6

swap_loop:	ld (r0, r3, 4), r4		# r4 = val of student i
			ld (r0, r5, 4), r6		# r6 = val of student i + 1
		
			st r4, (r0, r5, 4)		# val of student i + 1 = val of student i
			st r6, (r0, r3, 4)		# val of student i = val of student i + 1

			inc r3					# r3 ++
			inc r5					# r5 ++
			mov r3, r4				# r4 = r3
			not r4					# r4 = - r3 - 1
			inc r4					# r4 = -r3
			add r7, r4				# r4 = (7 + i * 6) - r3
			bgt r4, swap_loop		# jump to swap_loop if (7 + i * 6)  - r3 > 0

			j sort_loop				# return to sort loop
			halt


			
#Globals
.pos 0x2000
n:			.long 1			# number of students
m:			.long 0			# id of student with median average
s:			.long base0		# dynamic array of n students
base0:		.long 1111		# studend id
			.long 80		# grade 0
			.long 80		# grade 1
			.long 80		# grade 2
			.long 80		# grade 3
			.long 0			# computed average


#local variables
.pos 0x3000
j:			.long 0			# value of j 