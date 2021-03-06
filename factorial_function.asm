.data
	prompt_for_input: .asciiz "Please enter a number that is GREATER than 0, and is LESS than 12:\n"
	input_error: .asciiz "\nYou did not input a number that is GREATER than 0 and is LESS than 12, start over.\n"
	factorial_result: .asciiz "The factorial of your input is: "
	newLine: .asciiz "\n"
.text
	main:
	
	#TAKE INPUT THAT IS 0 < N < 12
	#Prompt user for input
	li $v0, 4
	la $a0, prompt_for_input
	syscall
	
	#Take input from user
	li $v0, 5
	syscall
	
	#Place input on a new register
	add $t2, $zero, $v0
	add $t7, $zero, $v0
	addi $t3, $zero, 1
	
	#Check if input is less than zero and greater than 12
	blt $t2, $zero, invalid_input
	addi $t1, $zero, 12
	bgt $t2, $t1, invalid_input
	
	#Loop for performing factorial function
	factorial_loop:
		beq $t2, $t3, exit #check if t2(input) is one
		sub $t4, $t2, $t3 #subtract input by 1		
		bne $t2, $t7, after_input #if t2 is not equal to initial input, jump to multiplying product to t2
		mul $t5, $t2, $t4 #multiply input by number before it
		beq $t2, $t7, next_digit
		after_input:
		mul $t5, $t5, $t4
		next_digit:
		sub $t2, $t2, $t2 #change t2 to zero
		add $t2, $t2, $t4 #replace t2 with the number that's lower than it
		
		j factorial_loop
	
	exit:

	#new line
	li $v0, 4
	la $a0, newLine
	syscall	
			
	#Result of factorial function
	li $v0, 4
	la $a0, factorial_result
	syscall
	
	#Display factorial result
	li $v0, 1
	add $a0, $zero, $t5
	syscall
	
	blt $t7, $t1, exit_confirm
	bgt $t7, $zero, exit_confirm
	
	#User placed the inappropriate input
	invalid_input:
	li $v0, 4
	la $a0, input_error
	syscall
	
	exit_confirm:
	
	#EXIT PROGRAM
	li $v0, 10
	syscall
