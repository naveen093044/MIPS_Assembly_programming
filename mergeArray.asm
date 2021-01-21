#program to merge two arrays in a single sorted array
.data
	array1: .word 4,5,9,10,16,21
	array2: .word 1,2,3,6,19,22 
	arraylength: .word 6
	result: .space 60
	delimeter: .asciiz ","
	
.text
	addiu $sp, $sp, -20   #allocate space on the stack
	la $a0, array1				#load the address of array1 
	la $a1, array2				#load the address of array2
	lw $a2, arraylength  #load aaraylength
	la $a3, result       #load the address of the result variable (output of the function)
	sw $a0, 0($sp)       #store the array1 on the stack
	sw $a1, 4($sp)       #store array2 on the stack
	sw $a2, 8($sp)       #store array lenght on the stack
	sw $a3, 12($sp)      #store the result pointer on the stack
	sw $ra, 16($sp)      #store the current return address on the stack
	
	jal merge            #call function merge
	lw $ra, 16($sp)      #load the return address from the stack
	addiu $sp, $sp, 20   #deallocate the space on the stack
  li $v0, 10          #terminate program
  syscall
	
	merge:
		lw $t0, 8($sp)   			#load the arraylength in $t0
		add $t0, $t0, $t0    #double the arraylength for counter (i)
		lw $a1, 12($sp)      #load the result address in $a1
		lw $a2, 0($sp)       #load address of array1 in $a2
		lw $a3, 4($sp)				#load address of array2 in $a3
		addi $t3, $t3, 0     #intialize the counter for array2  (j)
		addi $t4, $t4, 0     #initialize the counter for array1 (k)
	
		
		loop:
			blez $t0 loopdone    #if counter is zero the branch to loopdone
			lw $t1, 0($a2)       #load the element from array1 into $t1 
			lw $t2, 0($a3)       #load the element from array2 into $t1
			blt $t1, $t2 assign   #if array1[i]<array2[i] then branch to assign
			beq $t3, 6 assign1    #if array2 counter is equal to array2 lenght(i==6) then branch to assign1
			sw $t2,($a1)          #store value result[i]= array2[i]
			addi $a1, $a1, 4      #increase the result pointer
			addi $t0, $t0, -1     #decrement the counter i by 1 (i--)
			addi $t3, $t3, 1      #increament array2 counter by 1 (j++)
			addi $a3, $a3, 4      #increment the array2 pointer to point to the next element in array2
			move $a0, $t2         #move the value of array2[i] in $a0 for print
			li $v0, 1
			syscall
			blez $t0 loopdone
			la $a0, delimeter
			li $v0, 4
			syscall
			b loop
			
			assign:
			beq $t4, 6, assign2  #if array1 counter is equal to array1 length (j==6) then branch to assign2
			sw $t1,($a1)         #assign result=array1[i]
			addi $a1, $a1, 4
			addi $t0, $t0, -1
			addi $t4, $t4, 1
			addi $a2, $a2, 4
			move $a0, $t1
			li $v0, 1
			syscall
			blez $t0 loopdone
			la $a0, delimeter
			li $v0, 4
			syscall
			b loop				
			
				assign1:
			sw $t1, ($a1)
			addi $t0, $t0, -1
			move $a0, $t1
			li $v0, 1
			syscall
			blez $t0 loopdone
			la $a0, delimeter
			li $v0, 4
			syscall
			beq $t4, 6, loopdone
			addi $t4, $t4, 1
			addi $a1, $a1, 4
			addi $a2, $a2, 4
			lw $t1, ($a2)			
			b assign1
			
			assign2:
			sw $t2, ($a1)
			addi $t0, $t0, -1
			move $a0, $t2
			li $v0, 1
			syscall
			blez $t0 loopdone
			la $a0, delimeter
			li $v0, 4
			syscall
			beq $t3, 6, loopdone
			addi $t3, $t3, 1
			addi $a1, $a1, 4
			addi $a3, $a3, 4
			lw $t1, ($a2)			
			b assign2
			
		loopdone:
		  jr $ra
		
		
