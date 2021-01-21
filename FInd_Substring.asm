#Program to print the substring 

.data
	prompt1: .asciiz "Enter the first string (Max length 50): "
	prompt2: .asciiz "Enter the second string (Max Length 50): "
	string1: .space 50
	string2: .space 50
	endofstring: .asciiz "\n"
	
.text
	#Print the first prompt
	la $a0, prompt1
	li $v0, 4  			#Print string (syscall 4)
	syscall
	
	#read string1 
	la $a0, string1     # load address of string1
	li $a1, 50					#Number of characters to be read
	li $v0, 8    # Read string (syscall 8)
	syscall
	
	# Print the second prompt
	la $a0, prompt2
	li $v0, 4						#Print string (syscall 4)
	syscall
	 
	#read string2 
	la $a0, string2     # load address of string1
	li $a1, 50					#Number of characters to be read
	li $v0, 8    # Read string (syscall 8)
	syscall
	
	la $a0, string1  #load string1 address in $a0
	la $a1, string2  #load string2 address in $a1
	li $t0, 0        #initiallize the first counter(i) of the loop1 to 0
	lb $t6, endofstring

	
	loop1: 
			add $t8, $a0, $t0 #point to the next character in the string
			lb $t1, 0($t8) #load the character at the start of address $a0 into $t1
			beq $t1, $t6 return  #if the value at $t1 is end of string then branch to label "return"
			li $t2, 0       #intialize the second counter(j) of the loop2 to 0
			
	loop2: 
			add $t3, $t0, $t2    # find i+j
			add $t7, $a0, $t3    #point $a0 to address string1[i+j]
			lb $t4, 0($t7)       #load value at string1[i+j] into $t4
			add $t9, $a1, $t2    #point $a1 to address string2[j]
			lb $t5, 0($t9)       #load value at string2[j] into $t5
			beq $t5, $t6 loop2done #branch to label lloop2done if value $t5 is the end of string
			bne $t4, $t5 break1     #If string1[i+j]!= string2[j] then branch to label break1
			addi $t2, $t2, 1				#increment the counter j by 1
			j loop2                #jump to loop2
			
	break1:
			addi $t0 $t0,1       #increament the counter i by 1
			j loop1              #jump to loop 1
			
	loop2done: 
			blt $t2, 1 return    # if value of $t2 less than 1 barnch to label return
			bge $t2, 1 loop1done  # if value of $t2 less than 1 barnch to label loop1done
			
	loop1done: 
			move $a0,$t0         #set the valu of $a0 to the index i for print integer (syscall 1)
			j print
			
	return:
			li $a0, -1					#set the valu of $a0 to -1 for print integer (syscall 1)
			
	print: 
			li $v0, 1						# load $v0 with 1 (syscall 1 for print integer)
			syscall
			
			
			li $v0, 10					# terminate program syscall 10 
			syscall
			
			
		 
			
	
	