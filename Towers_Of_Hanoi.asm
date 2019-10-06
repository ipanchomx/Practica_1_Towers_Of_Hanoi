.text
	addi $a0, $zero, 3		#a0 = n disks
	
	addi $s0, $zero, 0x1001 	#From address 
	sll $s0, $s0, 16	
	add $t0, $zero, $a0
	
	addi $s3, $zero, 1
	

fill:
	
	sw $t0, 0($s0)			#Creating the disk and filling "from" array 
	addi $t0, $t0, -1
	addi $s0, $s0, 4
	bne $t0, $zero, fill
	
	addi $s0, $zero, 0x1001		#Reset FROM adrres to 0x10010000
	sll $s0, $s0, 16
	
	addi $s1, $zero, 0x1001		#AUX address =0x10010020
	sll $s1, $s1, 16
	addi $s1, $s1, 0x20
	
	addi $s2, $zero, 0x1001		#TO address = 0x10010040
	sll $s2, $s2, 16
	addi $s2, $s2, 0x40
	


	jal hanoi
	j end
hanoi:

	beq $a0,1, casoBase
	addi $sp, $sp, -20
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $s0, 8($sp)
	sw $s1, 12($sp)
	sw $s2, 16($sp)	
	
	addi $a0, $a0, -1		#hanoi( a0-1, from+4, to, aux)
	addi $s0, $s0, 4	
	add $t1, $zero, $s1	
	add $s1, $zero, $s2
	add $s2, $zero, $t1
	jal hanoi	
	
	lw $t1, 0($s0)			#move FROM to TO
	sw $t1, 0($s2)
	sw $zero, 0($s0)
	
	addi $a0, $a0, -1
	addi $s2, $s2, 4
	add $t1, $zero, $s0		# hanoi( a0-1, aux, from, to+4)
	add $s0, $zero, $s1
	add $s1, $zero, $t1
	jal hanoi
	
	lw $a0, 4($sp)	#03
	lw $s0, 8($sp)	#0000
	lw $s1, 12($sp)	#0020
	lw $s2, 16($sp)	#0040
	jr $ra
	
casoBase:
	lw $t1, 0($s0)			#move FROM to TO
	sw $t1, 0($s2)
	sw $zero, 0($s0)
	j exitHanoi
	
exitHanoi:
	#Alinea el stack pointer

	lw $ra, 0($sp)  		#ra
	lw $a0, 4($sp)			#0004
	lw $s0, 8($sp)			#0040
	lw $s1, 12($sp)			#0040
	lw $s2, 16($sp)	
	addi $sp, $sp, 20	
	jr $ra				#Regresa a la función que la llamó.
	
end:
