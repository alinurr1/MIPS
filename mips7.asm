.data
   array: .space 1024
.text

   #------------------------------------------------------------------------------------------
   # Number of blocks: 1
   # Cache block size: 32
   # Metric score: 6144
   #------------------------------------------------------------------------------------------
   # Reasons for opItimization:
   # 1. I took word as 4 bytes, it was efficently to take 4 bytes as a word and increment the
   # 	word a whole and the store it again as a word. This way I reduced the number of 
   #	memory accesses and therefore improved the metrics.
   #------------------------------------------------------------------------------------------
   # 2. For the configurations of cache parameters I chose cache block size to be equal to 32. 
   #	In general, the bigger the cache block size, the less miss you will get. 
   #	Increasing the cache block size is common solution when we are dealing 
   #    with spatial and temporal localities. That is if something is accessed once, it will
   #	probably be accessed again(temporal locality) and if something is accessed, the nearby
   #	element is probably also going to be accessed(spatial locality). Since we were limited
   # 	to cache size of 128, the relation 32 cache block size to 1 block was chosen.
   #	The goal was to maximize the cache block size at all means, in order to reduce misses.
   #-------------------------------------------------------------------------------------------
   
   li $a0, 1024 # Array size
   li $a1, 4 # Step size
   
   move $t0, $a0
   move $t1, $a1
   
   li $t2, 0
   li $t3, 0x01010101
   
   main:
      	blez $t0, end
   	lw $t4, array($t2)
   	add $t4, $t4, $t3
    	sw $t4, array($t2)
   	add $t2, $t2, $t1
        sub $t0, $t0, $t1
   	j main
   	
   end:
   	li $v0, 10
   	syscall
