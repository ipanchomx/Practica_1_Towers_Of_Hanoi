.data
	#Dimensionar los 3 arreglos que utilizaremos.
	from: .space 32
	aux:  .space 32
	to:   .space 32
	
.text
	addi $a0, $zero, 16	#a0 = n disks
	addi $s0, $zero, 0x1001
	sll $s0, $s0, 16
	add $t0, $zero, $a0

fill:
	sw $t0, 0($s0)
	addi $t0, $t0, -1
	addi $s0, $s0, 4
	bne $t0, $zero, fill
	
	
	addi $s0, $zero, 0x1001
	sll $s0, $s0, 16
	
	addi $s1, $zero, 0x1001
	sll $s1, $s1, 16
	addi $s1, $s1, 0x20
	
	addi $s2, $zero, 0x1001
	sll $s2, $s2, 16
	addi $s2, $s2, 0x40
	
	
	
	
	
	