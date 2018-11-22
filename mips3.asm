.data
   message: .space 6
   answer: .space 6
   stop:  .byte '-'
   space: .asciiz " "
.text
main:
   lb $s0, stop
   
   input:
        la $a0, message
        li $a1, 6
        li $v0, 8
        syscall
        
        lb $t0, 0($a0)
        beq $t0, $s0, end
        
        j size

   size:
        li $t0, 0
        li $t1, 0
        li $t2, 0
        j size_loop
        
   size_loop:
        add $t0, $a0, $t2
        lb  $t1, 0($t0)
        beqz  $t1, size_stop
        add   $t2, $t2, 1
        j size_loop   
        
   size_stop:
        li $s1, 0
        add $s1, $t2, -1  
        j change
		  
   change:
	li $t0, 0
	li $t1, 0
	li $t2, 0
	addi $t2, $s1, 0
	j change_loop
	
   change_loop:	
	add 	$t1, $a0, $t0
	lb 	$t4, 0($t1)
	beqz 	$t4, output
	sb 	$t4, answer($t2)
	sub 	$t2, $t2, 1
	add 	$t0, $t0, 1
	j 	change_loop		  
		  
   output: 
        la $a0, answer
        li $v0, 4
        syscall
        
        la $a0, space
        li $v0, 4
        syscall
        
        j input
   end:
        li $v0, 10
        syscall
   
   
       


