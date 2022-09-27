
main:
			#last value will be in $v0.
addi $a0, $0 , 3	#Input : N = 3
addi $a1, $0 , 7	#Input : M = 7
jal minTiles
j exit			#to exit
minTiles:

	addi $sp , $sp , -12		#to use stack for storing our value
	
	sw $ra , 0($sp) 
	sw $a1 , 4($sp) 
	sw $a0 , 8($sp) 
	
	

	
	slti $t1, $a0 , 1			#if n < 1 ,$t1 = 1 ,for catching n == 0 or not, if n > 1, $t1 = 1 
	slti $t2, $a1 , 1			#if m < 1 ,$t2 = 1 ,for catching m == 0 or not if m > 1, $t2 = 1
	or $t3 , $t1 , $t2			#if n || m == 0 continue, otherwise stop, both of them should be 0 for continuing
	beq  $t3, $0 , elseif1 		
		
	lw $ra , 0($sp) 			#restore stack
	lw $a1 , 4($sp) 
	lw $a0 , 8($sp)	
	
	
	addi $v0 , $0 , 0 			#return 0
	addi $sp , $sp , 12  			#restore stack
	jr $ra
	
	
elseif1:					# in pyhton, elif n%2 == 0 and m%2 == 0:
	addi $t1, $0 ,2				# taking value 2, to divide n 
	divu $a0, $t1				# taking n / 2, because n%2 will be stored in hi
	mfhi $t1    				# taking n%2 
	addi $t2, $0 ,2     			# taking value 2, to divide m             
	divu $a1, $t2				# taking m / 2, because m%2 will be stored in hi
	mfhi $t2				# taking m%2 
	
	bne $t1,$zero,elseif2     		#n%2 == 0 and m%2 == 0 are correct or not, if not, continue to elseif2
	bne $t2,$zero,elseif2
	
	addi $t1, $0 ,2
	div $a0, $t1               		# taking m / 2, because m/2 will be stored in lo
	mflo $a0				# n / 2
	addi $t2, $0 ,2
	div $a1, $t2 				# taking m / 2, because m/2 will be stored in lo
	mflo $a1				# m / 2
	jal minTiles
	
	lw $ra , 0($sp) 			#restore stack
	lw $a1 , 4($sp) 
	lw $a0 , 8($sp)	
	
	
	addi $sp, $sp, 12
	
	add $v0, $0 , $v0                     #returning value
	jr $ra
	
elseif2:					# in pyhton, elif n % 2 == 0 and m % 2 == 1:
	addi $t1, $0 ,2				# taking value 2, to divide n 
	divu $a0, $t1				# taking n / 2, because n%2 will be stored in hi
	mfhi $t1    				# taking n%2 
	addi $t2, $0 ,2     			# taking value 2, to divide m             
	divu $a1, $t2				# taking m / 2, because m%2 will be stored in hi
	mfhi $t2				# taking m%2 
	
	bne $t1, $zero ,elseif3    		#n%2 == 0 and m%2 == 1 are correct or not, if not, continue to elseif2
	bne $t2, 1 ,elseif3
	
	addi $t1, $0 ,2
	div $a0, $t1               		# taking m / 2, because m/2 will be stored in lo
	mflo $a0				# n / 2
	addi $t2, $0 ,2
	div $a1, $t2 				# taking m / 2, because m/2 will be stored in lo
	mflo $a1				# m / 2
	jal minTiles
	
	lw $ra , 0($sp) 			#restore stack
	lw $a1 , 4($sp) 
	lw $a0 , 8($sp)	
	
	
	addi $sp, $sp, 12
	
	add $v0, $a0 , $v0			# return value while adding n
	jr $ra
	
elseif3:					# in pyhton, elif n % 2 == 1 and m % 2 == 0, If n is odd and m is even

	addi $t1, $0 ,2				# taking value 2, to divide n 
	divu $a0, $t1				# taking n / 2, because n%2 will be stored in hi
	mfhi $t1    				# taking n%2 
	addi $t2, $0 ,2     			# taking value 2, to divide m             
	divu $a1, $t2				# taking m / 2, because m%2 will be stored in hi
	mfhi $t2				# taking m%2 
	
	bne $t1, 1 , else    			#n%2 == 1 and m%2 == 0 are correct or not, if not, continue to elseif2
	bne $t2, $zero ,else
	
	addi $t1, $0 ,2
	div $a0, $t1               		# taking m / 2, because m/2 will be stored in lo
	mflo $a0				# n / 2
	addi $t2, $0 ,2
	div $a1, $t2 				# taking m / 2, because m/2 will be stored in lo
	mflo $a1				# m / 2
	
	jal minTiles
	
	lw $ra , 0($sp) 			#restore stack
	lw $a1 , 4($sp) 
	lw $a0 , 8($sp)	
	
	
	
	addi $sp, $sp, 12
	
	add $v0, $a1 , $v0			# return value while adding m
	jr $ra
else:						# If n and m are odd add
						# row + column number of tiles
						
	addi $t1, $0 ,2				# taking value 2, to divide n 
	divu $a0, $t1				# taking n / 2, because n%2 will be stored in hi
	mfhi $t1    				# taking n%2 
	addi $t2, $0 ,2     			# taking value 2, to divide m             
	divu $a1, $t2				# taking m / 2, because m%2 will be stored in hi
	mfhi $t2				# taking m%2 
	
	addi $t1, $0 ,2
	div $a0, $t1               		# taking m / 2, because m/2 will be stored in lo
	mflo $a0				# n / 2
	addi $t2, $0 ,2
	div $a1, $t2 				# taking m / 2, because m/2 will be stored in lo
	mflo $a1				# m / 2
	
	jal minTiles
	
	lw $ra , 0($sp) 			#restore stack
	lw $a1 , 4($sp) 
	lw $a0 , 8($sp)	
	
	
	addi $sp, $sp, 12
	
	add $v0, $a1 , $v0
	add $v0, $a0 , $v0			# return value while adding m and n, also adding -1
	add $v0, $v0 , -1
	jr $ra
exit:
	add $a0,$v0,$zero			#to write solution from $v0 to screen
	li $v0,1
	syscall

	li $v0,10				# it will be wrtie 12 as being solution
	syscall
