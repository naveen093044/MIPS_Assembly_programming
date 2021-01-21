# Program to find the square root of a number

.data
	prompt1: .asciiz "\n Enter a positive number: "
	result1 : .asciiz "\n The sqaure root of the number is : "
	prompt2: .asciiz "\n \n Enter another positive number: "
	result2: .asciiz "\n The natural log of the number is : "
	overflow_prompt: .asciiz "Overflow has occured, the result shown may not be correct."
	
.text
	main:
#square root impelementaion

	  #print the prompt 
	 input_loop:
	  li $v0, 4
	  la $a0, prompt1
	  syscall
	  
	  #read the input number
	   li $v0, 7
	   syscall
	   
	   # check if the input is less than zero
	   li $t0, 0
	   mtc1 $t0, $f2
	   cvt.d.w $f2,$f2
	   c.lt.d $f0,$f2
	   bc1t input_loop
	   
	 addiu $sp, $sp, -20 # allocate space on the stack
	 s.d $f0, ($sp)       #store the number on stack
	 sw $ra, 16($sp)      #sore the return address on the stack
	 jal sqrt
	 l.d $f12, 8($sp)     #store the square root value in $f12 for print
	 lw $ra, 16($sp)      #store the return address back in $ra
	 addiu $sp, $sp, 20   #deallocate the space on stack
	 
	 print_sqrt:
  	li $v0, 4
  	la $a0, result1
  	syscall
  	
  	li $v0, 3
  	syscall
  	
  	
# ln(x) implementation Using Pade's Approximation

	#print the prompt 
	log_input:
	  li $v0, 4
	  la $a0, prompt1
	  syscall
	  
	 #read the input number
	  li $v0, 7
	  syscall
	  
	 # check if the input is less than zero
	   li $t0, 0
	   mtc1 $t0, $f2
	   cvt.d.w $f2,$f2
	   c.lt.d $f0,$f2
	   bc1t log_input
	  
	 addiu $sp, $sp, -20 # allocate space on the stack
	 s.d $f0, ($sp)       #store the number on stack
	 sw $ra, 16($sp)      #sore the return address on the stack
	 jal lnx
	 l.d $f12, 8($sp)     #store the square root value in $f12 for print
	 lw $ra, 16($sp)      #store the return address back in $ra
	 addiu $sp, $sp, 20   #deallocate the space on stack
	 
	 print_lnx:
  	li $v0, 4
  	la $a0, result2
  	syscall
  	
  	li $v0, 3
  	syscall
  	
#terminate program
	terminate:
  	li $v0, 10
  	syscall
  	
 
 # data for exception handler
.kdata 
   save_a0: .word 0
   saved_registers: .space 128  
  
# exception handler
.ktext 0x80000180
  move $k1, $at  # save the intermediate context within macro instruction
  # save the context of the user program
  sw $a0, save_a0 # save $a0 first so that I can use it to address the array above
  la $a0, saved_registers # save other registers to this array
  sw $t0, ($a0)
  sw $t1, 4($a0)
  
  # get the exception code
  mfc0 $k0, $13    # move the value in cause register to $k0
  srl $k0, $k0, 2   # right shift 2 bits
  andi $k0, $k0, 0xf  # extract the exception code
  bne $k0, 12, done   # if exception code is arithmatic overflow then branch to done
  la $a0, overflow_prompt
  li $v0, 4
  syscall
  la $k0, terminate
  mtc0 $k0, $14
  
done:
  mtc0 $zero, $13        # clear the cause register 
  mfc0 $k0, $12 
  andi $k0, $k0, 0xFFFD  # clears the 'interrupt present' bit 
  ori $k0, $k0, 1        # re-enable interrupts by setting the 'enabled' bit
  mtc0 $k0, $12          # update the status register
  # restore our original context 
  lw $t0, ($a1)
  lw $t1, 4($a1)
  lw $a0, save_a0
  move $at, $k1 
  eret
  	
	 
	   	
	  
	   
