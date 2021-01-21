#implementation of natural log using Pade's Approximation
#ln( 1+x ) = x*(6 + 0.7662x)/(5.9897 + 3.7658x) where, ln(1) = 0
#max error = 4.3E-4 ( < 0.1 % )

.data
	# initialize constatnts used in the approximation
	num1: .double 0.7662
	num2: .double 5.99897
	num3: .double 3.7658
	num4: .double 6.0
	num5: .double 1.0
	
	
.text
.globl lnx
	lnx:
		l.d $f0, ($sp)  # load the value (x) from stack
		l.d $f2, num1   # load first  constatnt in $f2
		l.d $f4, num2		 # load the second constant in $f4
		l.d $f6, num3   # load the third constatn in $f6
		l.d $f8, num4   # load the fourth constant in $f8
		l.d $f14, num5  # load the fifth constant in $f14
		sub.d $f0, $f0, $f14
		mul.d $f10, $f0, $f2   # calculate 0.7662x
		add.d $f10, $f10, $f8  # calculate 6 + 0.7662x
		mul.d $f10, $f0, $f10  # calculate x*(6 + 0.7662x)
		mul.d $f12, $f6, $f0   # calculate 3.7658x
		add.d $f12, $f4, $f12  # calculate (5.9897 + 3.7658x)
		div.d $f12, $f10, $f12 # calculate x*(6 + 0.7662x)/(5.9897 + 3.7658x)
		s.d $f12, 8($sp)       # load the log value on the stack
		jr $ra
		
		

		