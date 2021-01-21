.data
  prompt: .asciiz "Enter an Integer value : "
  result: .asciiz "The absolute value is:  "
.text
  la $a0, prompt   #load prompt
  li $v0, 4                #print prompt string (syscall 4)
  syscall
  li $v0, 5                 #read integer(syscall 5)
  syscall
  move $t0, $v0     #move integer to $t0
  la $a0, result       # load result prompt
  li $v0, 4                #print result prompt (syscall 4)
  syscall
  bltz $t0, abs     #if integer is negative branch to label abs
  move $a0, $t0    #move $t0 to $a0 for syscall 1
abs:
   neg $t0, $t0
   move $a0, $t0

     li $v0, 1   #print integer
     syscall
    li $v0, 10    #terminate program
    syscall