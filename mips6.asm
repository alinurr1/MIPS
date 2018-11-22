.data
	DISPLAY: .space 16384
	DISPLAYWIDTH: .word 64
	DISPLAYHEIGHT: .word 64
	
	x: .word 32
	y: .word 32
	r: .word 15
	COLOURS: .word 0xff0000 0xff8c00 0xffff00 0x00ff00 0x0000ff 0x00080 0x800080
	step: .double 0.001
	
.text
j main

set_pixel_color:
	lw $t0, DISPLAYWIDTH
	mul $t0, $t0, $a1
	add $t0,$t0, $a0
	sll $t0, $t0, 2
	la $t1, DISPLAY
	add $t1, $t1, $t0
	sw $a2, ($t1)
	jr $ra
	
main:
	lw $s0, x
	lw $s1, y
	la $s2, COLOURS
	lw $s3, r
	
	li $t5, 7
	move $t2, $s2
	move $t3, $s3
	
	program:	
	
		draw_rainbow:
	
		mtc1.d $s0, $f0
  		cvt.d.w $f0, $f0
  	
		mtc1.d $s1, $f2
  		cvt.d.w $f2, $f2
  	
		mtc1.d $t3, $f4
  		cvt.d.w $f4, $f4
	
		ldc1 $f6, step
		sub.d $f8, $f0, $f4
	
		lw $a2, 0($t2)
	
		loop:
			mul.d $f10, $f4, $f4
			sub.d $f14, $f8, $f0
			mul.d $f16, $f14, $f14
			
			sub.d $f18, $f10, $f16
			sqrt.d $f18, $f18
			add.d $f18, $f18, $f0
		
			cvt.w.d $f20, $f18
			mfc1 $a0, $f20
					
			cvt.w.d $f22,$f8
			mfc1 $a1, $f22
			
			jal set_pixel_color
		
			li $t7, 64
			sub $a0, $t7, $a0
			jal set_pixel_color
		
			add.d $f8, $f8, $f6
			c.lt.d $f8, $f0
			bc1t loop
	
		add $t2, $t2, 4
		sub $t3, $t3, 1
		sub $t5, $t5, 1	
		ble $t5, $zero, exit 
		j program
		
exit:
	li $v0, 10
	syscall
