### This programm fills an Array with user-input, then prints the Array ###
.data

	num_arr: 		.word 0 : 10
	num_arr_size:		.word 10
	text:	.asciiz "Fill Array (10): " 
	
.text

		la $a0, text
		li $v0, 4
		syscall
	
		la $t1, num_arr
		lw $t5, num_arr_size
	
		add $t2, $zero, $t5
	
fill_array:	li $v0, 5
		syscall
		sw $v0, ($t1)
		addi $t1, $t1, 4	
		addi $t2, $t2, -1
		bgtz $t2, fill_array
		
		la $a0, num_arr
		add $a1, $zero, $t5
		
		jal print_arr
		
		li $v0, 10
		syscall
	
.data

	print_message:	.asciiz "Array: "
	space:		.ascii " "
	
.text

print_arr:	add $t1, $zero, $a0
		addi $t2, $a1, -1

		la $a0, print_message
		li $v0, 4
		syscall
		
print_loop:	lw $a0, 0($t1)
		li $v0, 1
		syscall
		
		la $a0, space
		li $v0, 4
		syscall
		
		addi $t1, $t1, 4
		addi $t2, $t2, -1
		
		bgez $t2, print_loop
		
		jr $ra
		
		
	
