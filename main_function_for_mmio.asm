#Main function calling the mmimo functions
.data
	input_prompt: .asciiz "Enter integer input(max 10 digits): "
	str: .space 11
	
.text
.globl main
main:
 # print the input prompt
 la $a0, input_prompt
 li $v0, 4
 syscall
 
 #call the fucntion input
 addiu $sp, $sp, -8   #allocate space on the stack
 la $a0, str        #load the address of input array into $a0
 sw $a0, ($sp)        #store address of the input array on stack
 sw $ra, 4($sp)       #store the return address on the stack
 jal input_str            #call the function
 lw $a0, ($sp)        #load the address of the input array back to $a0
 lw $ra, 4($sp)       #load the return address back to $ra
 addiu $sp, $sp, 8    #deallocate the space on the stack
 
 #call the print function
 
 addiu $sp, $sp, -8   #allocate space on the stack
 sw $a0, ($sp)        #store address of the input array on stack
 sw $ra, 4($sp)       #store the return address on the stack
 jal print_str           #call the function
 lw $a0, ($sp)        #load the address of the input array back to $a0
 lw $ra, 4($sp)       #load the return address back to $ra
 addiu $sp, $sp, 8    #deallocate the space on the stack
 
 #terminate program
 li $v0, 10
 syscall
 