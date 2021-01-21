# Program to find the length of a string
#input: String (max length 50)
#output: length of the string

.data
	prompt1: .asciiz "Enter the string (Max length 50): \n"
	result: .asciiz "THe lenght of the string is:  \n"
	string: .space 50
.text

 # Print the string prompt
	la $a0, prompt1
	li $v0, 4  			#Print string (syscall 4)
	syscall
	
	#read string 
	la $a0, string     # load address of string
	li $a1, 50					#Number of characters to be read
	li $v0, 8    # Read string (syscall 8)
	syscall
	
	# Print the result prompt
	la $a0, result
	li $v0, 4						#Print string (syscall 4)
	syscall
	
	#addiu $sp, $sp, -50  #allocate space for the string on the stack
	#lw $a0, (
	add $t0, $t0, 0    #initalize the value of counter for string length 
	la $a0, string  #load the string in $a0
	move $a1, $a0     #save the original string in $a1
	jal strlen        # call the function strlen
	move $a0, $t0     #move the string length in $a0 for print (sycall 1)
	li $v0, 1         #load $v0 with 1 to print the integer string length 
	syscall
		
	li $v0,10        #terminate program (syscall 10)
	syscall
	
	
	strlen: 
		loop:
			lbu $t1, 0($a0)     #load the character at the address pointed by $a0 in $t1
			beqz $t1, return    #if the character is 0 then branch to label return
			beq $t1, '\n' return  #if the character in newline(\n) then branch to label return
			addi $t0, $t0, 1      #increament the counter by 1
			addi $a0, $a0, 1      #increament the pointer by 1
			b loop
		
		return:
		  jr $ra                #jump to the address stored in register $ra
		