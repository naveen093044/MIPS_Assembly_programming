#print function
.text

.globl print_str
print_str:
  # read in address of string into $a0 
  lw $a0, ($sp)
  
  # load address mapping to display console
  la $a1, 0xFFFF0008
      
	print_loop:
  	lb $t0, ($a0) 
  	beqz $t0, print_done
  		print_ready:
    		lw $t1, ($a1)     # read control word
    		andi $t1, $t1, 1  # isolate ready bit
    		beqz $t1, print_ready  # loop back if ready bit is 0
  	sw $t0, 4($a1)  # write character to console 
  	addi $a0, $a0, 1 
  	b print_loop
  
	print_done:
  	jr $ra
