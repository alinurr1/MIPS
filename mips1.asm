.text
La $s0, fib
lw $t0, 0($s0)
lw $t1, 4($s0)
add $t3, $t0, $t1
sw $t3, 8($s0)
lw $t0, 4($s0)
lw $t1, 8($s0)
add $t3, $t0, $t1
sw $t3, 12($s0)
lw $t0, 8($s0)
lw $t1, 12($s0)
add $t3, $t0, $t1
sw $t3, 16($s0)
lw $t0, 12($s0)
lw $t1, 16($s0)
add $t3, $t0, $t1
sw $t3, 20($s0)
lw $t0, 16($s0)
lw $t1, 20($s0)
add $t3, $t0, $t1
sw $t3, 24($s0)
.data
fib : .word 0 1