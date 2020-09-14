.data

	getInput:	.asciiz "Enter number: "
	message:	.asciiz "\nFactorial: "
	inputNumber:	.word 0
	outputNumber:	.word 0
	
.text

main:
	# print user request	
	la $a0, getInput
	li $v0, 4
	syscall
	
	# get user input
	li $v0, 5
	syscall
	sw $v0, inputNumber
	
	# print calculation message
	la $a0, message
	li $v0, 4
	syscall

	# call factorial function
	lw $a0, inputNumber
	jal factorial
	sw $v0, outputNumber

	# print result
	lw $a0, outputNumber
	li $v0, 1
	syscall
	
	# end programm
	li $v0, 10
	syscall
	
	# ------------------------------------------------------------------------------------------------------------------------------- #
	
factorial:
		subu $sp, $sp, 8
		sw $ra, ($sp)
		sw $s0, 4($sp)
		
		# Base Case
		li $v0, 1
		beq $a0, 0, factorialDone
		
		# find factorial(n-1)
		move $s0, $a0
		sub $a0, $a0, 1
		jal factorial
		
		# the actual calculation happens after stack is popping
		mul $v0, $s0, $v0
		
		factorialDone:
				lw $ra, ($sp)
				lw $s0, 4($sp)
				addu $sp, $sp, 8
				jr $ra
