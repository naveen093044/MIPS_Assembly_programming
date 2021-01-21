#program to add two numbers

#Data
.data 
	prompt1: .asciiz "Enter first Number : "
	prompt2: .asciiz "Enter second number: "
	result: .asciiz "The sum of your numbers is: "
	
# Program
.text 
	#print the first prompt
	la $a0, prompt1
	li $v0, 4
	syscall
	
	# Read input from the user
	li $v0, 5
	syscall
	move $t0, $v0
	
	#print out the second prompt
	la $a0, prompt2
	li $v0, 4
	syscall
	
	# read the second input
	li $v0, 5
	syscall
	move $t1, $v0
	
	# Print the result prompt
	la $a0, result
	li $v0, 4
	syscall
	
	#print out the sum
	add $a0, $t0, $t1 # must use $a0 for print integer (syscall 1)
	li $v0, 1
	syscall
	
	#terminate the program
	li $v0, 10
	syscall