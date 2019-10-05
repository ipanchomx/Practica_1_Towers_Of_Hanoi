

.text
	addi $a0, $zero, 3	#a0 = n disks
	
	addi $s0, $zero, 0x1001 #From address 
	sll $s0, $s0, 16	
	add $t0, $zero, $a0

fill:
	sw $t0, 0($s0)		#Creating the disk and filling "from" array 
	addi $t0, $t0, -1
	addi $s0, $s0, 4
	bne $t0, $zero, fill
	
	
	addi $s1, $zero, 0x1001		#AUX address =0x10010020
	sll $s1, $s1, 16
	addi $s1, $s1, 0x20
	
	addi $s2, $zero, 0x1001		#To address = 0x10010040
	sll $s2, $s2, 16
	addi $s2, $s2, 0x40

	jal hanoi
	
hanoi:
	addi $s0, $s0, -4
	add $t0, $t0, $s0
	add $t1, $t1, $s2
	addi $s4, $s4, 4
	jal mov

mov:	#PRARAMETERS:   t0=from, t1=to, t2=temp
	
	lw $t2, 0($t0)
	sw $t2, 0($t1)
	sw $zero, 0($t0)
	
	
	
	

	

	
	
	
	
	
	
