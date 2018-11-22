.data
  array: .space 1024
  arrSize: .word 1024
  stepSize: .word 4
  repCount: .word 4
  loopSize: .word 64
.text
   # number of blocks = 1
   # cache block size = 32
   # memory access count = 2052
   # cache hit rate = 100%
   # cache performance metric = 2052 * (100 - 100 + 1) = 2052
     
   main:
   	lw $a0, arrSize
   	lw $a1, stepSize
   	lw $a2, repCount
   	lw $a3, loopSize
   	
   	jal program
   	
   	li $v0, 10
   	syscall
   	
   program:
   	move $s0, $a0
   	move $s1, $a1
   	move $s2, $a2
   	move $s3, $a3
   	
   	div $s0, $s3
   	mflo $t0
   	
   	li $t3, 0 # index
   	li $t4, 0 # repIdx
   	li $t5, 0 # loopIdx
   	
   	loop:
   		blt $t3, $t0, loop1
   		j end
   		loop1:
 			blt $t4, $s2, loop2
 			j loopr
 			loop2:
 				mul $t6, $t3, $s3
 				add $t6, $t6, $t5
 				lw $t2, array($t6)
 				add $t2, $t2, 0x01010101
 				sw $t2, array($t6)
 				add $t5, $t5, 4
 				blt $t5, $s3, loop2
 			
 			add $t4, $t4, 1
 			li $t5, 0
 			j loop1  			
   
	loopr:
		add $t3, $t3, 1
		li $t4, 0
		j loop   	
   	end:
   		jr $ra
