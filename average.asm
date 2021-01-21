#program to add two numbers

#Data
.data 
	prompt1: .asciiz "Enter first Number : "
	prompt2: .asciiz "Enter second number: "
	prompt3: .asciiz "Enter the third number: "
	result: .asciiz "The Average of your numbers is: "
	
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
	
	#print out the third prompt
	la $a0, prompt3
	li $v0, 4
	syscall
	
	# read the third input
	li $v0, 5
	syscall
	move $t2, $v0
	
	# Print the result prompt
	la $a0, result
	li $v0, 4
	syscall
	
	#print out the sum
	add $t3, $t0, $t1 # store the sum of the two numbers
	add $t4, $t2, $t3 # add the third number to the previous sum
	li $t5, 3
	div $t4, $t5      #divide the sum of 3 numbers by 3
	mflo $a0					# move the quotient to $a0 to be printed 
	li $v0, 1	 
	syscall
	
	#terminate the program
	li $v0, 10
	syscall
