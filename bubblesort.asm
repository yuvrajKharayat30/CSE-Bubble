# Ashish Meena (210214)
# Yuvraj Kharayat (211208)

main:
	addi $s7, $0, $0                   #s7 stores the memory address of nummbers in datamemory =0
	addi $s0, $0, 0						#initialize counter 1 for loop 1
	addi $s6, $0, 9 					#n - 1 
    addi $s1, $0, 0						#initialize counter 2 for loop 2

loop:
	add $t7, $s7, $s1 				#adding the address of numbers to t7

	lw $t0, 0($t7)  				#load numbers[j]	
	lw $t1, 1($t7) 					#load numbers[j+1]

	slt $t2, $t0, $t1				#if t0 < t1
	bne $t2, $0, 3       

	sw $t1, 0($t7) 					#swap
	sw $t0, 1($t7)

increment:	

	addi $s1, $s1, 1				#increment t1
	sub $s5, $s6, $s0 				#subtract s0 from s6
	bne  $s1, $s5, -9				#if s1 (counter for second loop) does not equal 9, loop
	addi $s0, $s0, 1 				#otherwise add 1 to s0
    addi $s1, $0, 0

	bne  $s0, $s6, -12				# go back through loop with s1 = s1 + 1
	
