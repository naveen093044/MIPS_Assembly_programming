#functions to print and taking input using MMIO
.data
 minus: .ascii "-"
 one: .ascii "1"
.text  
	.globl input_str
	input_str:
	  # read in address of string into $a0 
  lw $a0, ($sp)
  
  # load address mapping to input/keyboard console
  la $a1, 0xFFFF0000
  add $t2, $t2, 0    #initialize a counter to count the number of characters input
  
  input_loop:
   
   check_ready:
   	lw $t0, ($a1)    #read the control word
   	andi $t0, $t0, 1  #isolate the ready bit
   	beqz $t0, check_ready  # loop back if ready bit is 0
   lbu $t1, 4($a1)          #store the input character into $t1
   add $t2, $t2, 1         #increment the input counter
   beq $t2, 10, input_done   #end loop if input charachter counter has reached 10
   blt $t1,48, wrong_input
   bgt $t1,57, wrong_input
   beq $t1, '\n' , check_counter  #branch to check counter if the user has inputed someting or not
   sb $t1, ($a0)
   addiu $a0, $a0, 1
   b input_loop
   
  check_counter:
  	beqz $t2, wrong_input  #if Input counter is 0 the branch to wrong input
  	b input_done          
   
  wrong_input:
   addi $t2, $t2, -1
   subu $a0, $a0, $t2
   la $a2, minus
   la $a3, one
   lbu $t3, ($a2)
   sb $t3, ($a0)
   lbu $t4, ($a3)
   addiu $a0, $a0, 1
   sb $t4, ($a0)
   
  input_done:
  	jr $ra
  	
   
    
   
   
