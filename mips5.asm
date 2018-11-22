.data
   message: .asciiz "Input the double, please\n"
   one: .double 1.0
   
.text
main:
   jal factorial
   li $v0, 10
   syscall

factorial:
   addi $sp, $sp, -44
   swc1 $f0, 40($sp)
   swc1 $f1, 36($sp)
   swc1 $f2, 32($sp)
   swc1 $f3, 28($sp)
   swc1 $f4, 24($sp)
   swc1 $f5, 20($sp)
   swc1 $f6, 16($sp)
   swc1 $f7, 12($sp)
   swc1 $f12, 8($sp)
   swc1 $f13, 4($sp)
   sw $ra, 0($sp)

   input:
        li $v0, 4
        la $a0, message
        syscall
        
        li $v0, 7
        syscall
        
        mov.d $f2, $f0
   	mov.d $f6, $f0
   	ldc1 $f4, one            
   		
   loop:
   	c.le.d $f6, $f4
        bc1t output
   	sub.d $f6, $f6, $f4
   	mul.d $f2, $f2, $f6
   	j loop
   	        
   output:
   	mov.d $f12, $f2
        li $v0, 3
   	syscall
   	
   lw $ra, 0($sp)
   lwc1 $f13, 4($sp)
   lwc1 $f12, 8($sp)
   lwc1 $f7, 12($sp)
   lwc1 $f6, 16($sp)
   lwc1 $f5, 20($sp)
   lwc1 $f4, 24($sp)
   lwc1 $f3, 28($sp)
   lwc1 $f2, 32($sp)
   lwc1 $f1, 36($sp)
   lwc1 $f0, 40($sp)
   addi $sp, $sp, 44
   jr $ra
