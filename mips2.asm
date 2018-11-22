.data
   array: .word 21 20 51 83 20 20
   length: .word 6
   x: .word 20
   y: .word 5
   space: .asciiz " "
.text
   main:
   lw $s4, x
   lw $s5, y
   lw $s6, length                                
   mul $s7, $s6, 4
   addi $t0, $zero, 0
   
   replace:
      beq $t0, $s7, end_replace
      
      lw $t1, array($t0)
      
      beq $t1, $s4, replacer
      
      addi $t0, $t0, 4
      
      j replace
   replacer:
      sw $s5, array($t0)
      addi $t0, $t0, 4
      j replace
   end_replace:
   
   addi $t0, $zero, 0
   
   print:
      beq $t0, $s7, end_print
      
      lw $t1, array($t0)
      
      addi $t0, $t0, 4

      li $v0, 1
      move $a0, $t1
      syscall
      
      li $v0, 4
      la $a0, space
      syscall

      j print
   end_print:
