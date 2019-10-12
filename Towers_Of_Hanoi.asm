#Authors: Andrea Anahi Santana Hernández & Edgar Francisco Medina Rifas
#Exps: is715773 & is715468
#Variables used (in order of use): 
#$s0 = n disks 			   $s1 = first tower (A)	$s2 = second tower (B)	$t7 = $s0
#$s3 = third tower (C)		   $t0 = 1			$t1 = -1		$t2 = 4
.text
main:
	addi $s0,$zero,3 		#n of discs
	addi $s1,$zero,0x1001		#Load 0x1001 first tower
	sll  $s1,$s1,16			#Shift the 0x1001 16 times (4 bytes) to first address of memory
	add $t7,$zero,$s0		#temporal with the number of disks to fill the first tower
	
fill:					#Put n disks in first tower (From)
	sw $t7,0($s1)			#Put disk in tower
	addi $t7,$t7,-1			#Decrement number of disks
	addi $s1,$s1,4			#Next position in tower
	bne $t7,$zero, fill		#n != 0 ---> back to fill

	addi $s1,$zero,0x1001	#Load s1 with the high part of the adrdess of org
	sll  $s1,$s1,16		#Shift the high part 16 times to the left so it goes in its place
	
	addi $s2,$zero,0x1001   #Load s2 with the high part of the address aux
	sll  $s2,$s2,16		#Shift the high part 16 times to the left so it goes in its place
	addi $s2,$s2,0x20	#Load 0x20 in the low part so s2 has the address of aux
	
	addi $s3,$zero,0x1001   #Load s3 with the high part of the address of dst
	sll  $s3,$s3,16		#Shift the high part 16 times to the left so it goes in its place
	addi $s3,$s3,0x40	#Load 0x40 in the low part so s2 has the address of dst
	
	addi $t0,$zero,1		#Register with one to be used in comparisons
	addi $t1,$zero,-1		#Register with negative one to be used in adds to decrement the number of disks
	addi $t2,$zero,4		#Register withe negative four to be used in adds to move the next position in towers
	
	jal hanoi			#Jump to hanoi function
	
	j end				#Jump to end of program
	
hanoi:
	addi $sp,$sp,-20		#Reserve space in the stack for 5 registers
	sw $ra, 0($sp)			#Save ra
	sw $s1, 4($sp)			#Save s1 (A)
	sw $s2, 8($sp)			#Save s2 (B)
	sw $s3, 12($sp)			#Save s3 (C)
	sw $s0, 16($sp)			#Save s0 (number of disks)
	
	bne $s0, $t0, else		# n != 1 go to else of function
	
	sw $s0, 0($s3)			#Move disk from A to C 
	sw $zero, 0($s1)		#Put 0 in that position
	
	j popStack
else:
	#hanoi (a-1, A, C, B)
	add $s0, $s0, $t1		# a -=1
	add $s1, $s1, $t2		# A +=4 Next position (disk) in tower A
	#Swap of addresses
	lw $s2, 12($sp)			#Change address to second tower to third tower
	lw $s3, 8($sp)			#Change address to third tower to second tower		
	
	jal hanoi			#hanoi (a-1, A, C, B)

	#Move A to C (a +=1)
	lw $s3, 12($sp)			#Recover the addres of dest (previous C)
	addi $s1,$s1,-4			#Address tower A -=4
	add $s0, $s0, $t0		#disk +=1
	sw $s0, 0($s3)			#Put disk in third tower
	sw $zero, 0($s1)		#Put 0 in previous A tower
	
	#hanoi (a-1, C, B, A)
	add $s3,$s3,$t2			#Next position of previous C tower (third tower)
	add $s0,$s0,$t1			# a -=1
	
	
	lw $s1, 8($sp)			#Load address of previous B tower in tower A
	lw $s2, 4($sp)			#Load address of previous A tower in tower B

	jal hanoi			#hanoi (a-1, C, B, A)
	
popStack:
	#Reload varibles to back to function
	lw $ra,0($sp)		#Load ra
	lw $s1,4($sp)		#Load s1 (A)
	lw $s2,8($sp)		#Load s2 (B)
	lw $s3,12($sp)		#Load s3 (C)
	lw $s0,16($sp)		#Load s0 (number of disks)
	addi $sp,$sp,20		#Get sp to its position before Hanoi
	jr $ra			#Go to where Hanoi was called
end:
