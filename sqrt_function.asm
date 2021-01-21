# implementation of Square-root of anumber using Newton-Raphson Method
# input double n (The number of which squared root is needed)
# initialize r = n
# initialize Precision = 10^(-10)
# while(1)
#		x = (r/2) + (n/r*2)
#   if( (r - x) < precision ); break
#		r = x
# return r
 .data
 	precision: .double 0.0000000001
 	
.text
 .globl sqrt
 sqrt:
  	l.d $f0, ($sp)  # load the value from stack (n)
  	la $a0, precision  
  	l.d $f2, ($a0)   # load the precision value in $f2
  	li $t0,2
  	mtc1 $t0, $f6
  	cvt.d.w $f6, $f6
  	mov.d $f4, $f0   #copy the value of the number to be squared (r =n)
  	loop:
  	 div.d $f8, $f4, $f6     #calculate r/2 store in $f8
  	 mul.d $f10, $f4, $f6    #calculate r*2 store in $f10 
  	 div.d $f10, $f0, $f10   #calculate (n/r*2) store in $f10
  	 add.d $f10, $f8, $f10   # add (r/2) + (n/r*2) and store in $f10 (x)
  	 sub.d $f12, $f4, $f10  # calculate (r-x) store the value in $f12
  	 c.lt.d $f12,$f2        # comapre to check if( (r - x) < precision )
  	 bc1t loop_done         # If true then branch to loop_done
  	 mov.d $f4, $f10				# else, move x to r
  	 j loop
  	 
  	loop_done:
  		s.d $f10, 8($sp)
  		jr $ra
  	 