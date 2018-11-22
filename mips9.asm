# Nazym Altayeva and Alinur Amangazy
.data 
  buffer: .space 50
  array1: .space 25
  array2: .space 25	
  file: .asciiz "/home/alinur/Desktop/MIPS/file.txt"
  probel: .asciiz " "
  	
.text
  main:
	li   $v0, 13
	la   $a0, file
	li   $a1, 0
	li   $a2, 0
	syscall
	move $s0, $v0 

	li   $v0, 14
	move $a0, $s0
	la   $a1, buffer
	li   $a2, 50
	syscall
	 
	li   $v0, 16
	syscall
	
	move $s0, $a1
	la $s1, array1
	
	li $t0, 0
	li $t1, 0
	li $t8, 0
	li $t9, 0
  	
  	read:	
  		add $t2, $t0, $s0
  		add $t3, $t1, $s1
  		lb $t4, 0($t2)
  		beq $t4, 32, space
  		beq $t4, 59, semicolon
  		
  		add $t6, $t2, 1
  		lb $t7, 0($t6)
  		
  		bne $t7, 32, double
  		
  		single:
  			sub $t4, $t4, 48
  			sb $t4, 0($t3)
  			addi $t0, $t0, 1
  			addi $t1, $t1, 1
  			j read
  		
  		double:
  			sub $t7, $t7, 48		  		
  			sub $t4, $t4, 48
   			mul $t4, $t4, 10 			
  			add $t7, $t4, $t7
  			sb $t7, 0($t3)
  			addi $t0, $t0, 2
  			addi $t1, $t1, 1
  			j read
  			
  		space:
  			addi $t0, $t0, 1
  			j read
  		
  		semicolon:	
  			beq $t9, 0, first
  			beq $t9, 1, second
  			
  			first:
  				addi $t9, $t9, 1
  				addi $t0, $t0, 2
  				move $s2, $t1
  				li $t1, 0
  				la $s1, array2
  				j read	
  				
  			second:
  				move $s3, $t1
  	
  	la $a0, array1
  	la $a1, array2
  	move $a2, $s2
  	move $a3, $s3
  	
  	li $s0, 0
  	li $s1, 0
  	li $s2, 0
  	li $s3, 0
  	jal merge
  	
  	add $s1, $v0, $zero
    	li  $t0, 0
    	print:
    		lb $t1, 0($s1)
    		move $a0, $t1
    		li $v0, 1
    		syscall
    		li $v0, 4
		la $a0, probel
		syscall
    		addi $t0, $t0, 1
    		addi $s1, $s1, 1
    		bne $t0, $s0, print
  	
  	li $v0, 10
  	syscall

  merge:
  	addi $sp, $sp, -4
  	sw $ra, 0($sp)
  	
	add $s0, $a2, $a3 #size3 = size1 + size2
	sll $t1, $s1, 2
	addi $t0, $a0, 0 #preserve a0, because it will be used for heap
	#mul $a0, $s0, 2
	addi $a0, $t1, 0
	li $v0, 9
	syscall #malloc in heap
	addi $s1, $v0, 0
	addi $a0, $t0, 0 #return a0
	
	addi $t0, $zero, 0 # i
	addi $t1, $zero, 0 # j
	addi $t2, $zero, 0 # k
	addi $t9, $zero, 1
	
	while1:
		slt $t3, $t0, $a2
		slt $t4, $t1, $a3
		add $t4, $t4, $t3
		addi $s2, $zero, 2
		bne $t4, $s2, while2 #if both are true
		lb $t5, 0($a0)
		lb $t6, 0($a1)
		slt $t7, $t5, $t6
		beqz $t7, add_from_second
		
		add_from_first:
			sb $t5, 0($s1)
			addi $t0, $t0, 1
			add $a0, $a0, $t9
			j increment_k
		
		add_from_second:
			sb $t6, 0($s1)
			addi $t1, $t1, 1
			add $a1, $a1, $t9
					
		increment_k:
			addi $t2, $t2, 1
			add $s1, $s1, $t9
			jal while1

	while2:
		slt $t3, $t0, $a2
		addi $s2, $zero, 1
		bne $t3, $s1, while3
		lb $t5, 0($a0)
			sb $t5, 0($s1)
			addi $t0, $t0, 1
			add $a0, $a0, $t9
			
			addi $t2, $t2, 1
			add $s1, $s1, $t9
			jal while2		
	while3:
		slt $t4, $t1, $a3
		addi $s2, $zero, 1
		bne $t4, $s2, finish
		lb $t6, 0($a1)
			sb $t6, 0($s1)
			addi $t1, $t1, 1
			add $a1, $a1, $t9
			addi $t2, $t2, 1
			add $s1, $s1, $t9
			jal while3

  finish:
  	lw $ra, 0($sp)
  	addi $sp, $sp, 4
  	jr $ra 	 
	
