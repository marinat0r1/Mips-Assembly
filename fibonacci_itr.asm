.data
	user_input:		.asciiz "limit:\n"
	statement_text:		.asciiz "Fibonacci iterative till: "
	
	fib_array:		.word 0:47	# how to get user input in here?
	fib_array_size:		.word 0
	
.text
		### get user input ###
		la $a0, user_input
		li $v0, 4
		syscall
		
		li $v0, 5
		syscall
		
		sw $v0, fib_array_size
		
		la $a0, statement_text				
		li $v0, 4
		syscall
	
		lw $a0, fib_array_size
		li $v0, 1
		syscall
		
		###### register use #####
		# $t0 = adress of fib_array
		# $t1 & $t2 = start of fib calculation, 0 & 1
		# $t3 = copy of fib_aray_size
		# $t4
		# $t5 = array size
		# $t6 = first fib number
		# $t7 = second fib number
		# $t8 = first + second fib number
		
		lw $t5, fib_array_size
	
		la $t0, fib_array
		li $t1, 0
		li $t2, 1
		sw $t1, 0($t0)
		sw $t2, 4($t0)
		addi $t3, $t5, -2		#loop counter
	
fib_loop:	lw $t6, 0($t0)			#works till 47 (bcs 32 bits)
		lw $t7, 4($t0)
		add $t8, $t6, $t7
		sw $t8, 8($t0)
		addi $t0, $t0, 4
		addi $t3, $t3, -1
		bgtz $t3, fib_loop
		
		### preparing registers for print routine ###
		la $a0, fib_array
		lw $a1, fib_array_size
		
		jal print_start

		li $v0, 10
		syscall
	
.data
	print_message:		.asciiz "\nprinting fibs... "
	space:			.ascii " "
	
.text

print_start:	add $t0, $zero, $a0
		add $t1, $zero, $a1
		
		la $a0, print_message
		li $v0, 4
		syscall
		
print_routine:	lw $a0, 0($t0)
		li $v0, 1
		syscall
		
		la $a0, space
		li $v0, 4
		syscall
		
		addi $t0, $t0, 4
		addi $t1, $t1, -1
		bgtz $t1, print_routine
		
		jr $ra