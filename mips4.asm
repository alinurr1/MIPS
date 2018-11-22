.data
   message: .asciiz "Input the degree, please\n"
   negative: .double 1.0
   nm: .double 1.0
   factorial: .double 1.0
   sum: .double 0.0
   one: .double 1.0
   none: .double -1.0
   pi: .double 3.141592653589793238
   deg: .double 180.0
.text
main:
   input:
        li $v0, 4
        la $a0, message
        syscall
        
        li $v0, 7
        syscall      
   sin:
   	ldc1 $f22, pi
   	ldc1 $f24, deg
        ldc1 $f6, nm
        ldc1 $f8, factorial
        ldc1 $f10, negative
        ldc1 $f14, sum
        ldc1 $f18, one
        ldc1 $f20, none
        
        addi $t0, $t0, 10 # index n 
   	mul.d $f0, $f0, $f22 # conversion from degrees to radians
   	div.d $f0, $f0, $f24
        mov.d $f2, $f0 # xpow here
        mul.d $f4, $f0, $f0 # x^2 here    

        
        loop:
             beqz $t0, output
   	     div.d $f16, $f2, $f8
   	     
   	     c.le.d $f10, $f20
   	     bc1f sumn
   	     
   	     add.d $f14, $f14, $f16
   	     
   	     mul.d $f2, $f2, $f4
   	     
   	     add.d $f6, $f6, $f18
   	     mul.d $f8, $f8, $f6
   	     add.d $f6, $f6, $f18
   	     mul.d $f8, $f8, $f6
   	     
   	     mul.d $f10, $f10, $f20    
   	     subi $t0, $t0, 1
   	     j loop 
   	     
   	sumn:
   	     sub.d $f14, $f14, $f16
   	     
   	     mul.d $f2, $f2, $f4
   	     
             add.d $f6, $f6, $f18
             mul.d $f8, $f8, $f6
   	     add.d $f6, $f6, $f18
   	     mul.d $f8, $f8, $f6
   	     
   	     mul.d $f10, $f10, $f20    
   	     subi $t0, $t0, 1
   	     j loop
   	     
   output:
   	  mov.d $f12, $f14
   	  mul.d $f12, $f12, $f20
   	  li $v0, 3
   	  syscall      
   	    
   end:
        li $v0, 10
        syscall
