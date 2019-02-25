# Author: Alejandro Rios
# Exp: is708932
# Date: Feb 25, 2019
# Tower Of Hanoi

.text
	addi $s0, $zero, 8
	addi $s1, $s1, 0x1001
	sll $s1, $s1, 16
	addi $s2, $s1, 0x20
	addi $s3, $s2, 0x20
	add $t0, $s0, $zero
	
	for:
		beq $t0, $zero, end_for
		sw $t0, 0($s1)
		addi $s1, $s1, 4
		addi $t0, $t0, -1
		j for
		end_for:
		
	main:
		add $a0, $s0, $zero
		add $a1, $s1, $zero # Source
		add $a2, $s3, $zero # Destination
		add $a3, $s2, $zero # Spare
		jal move_tower # First call (disk, source, dest, spare)
		j exit # Exit jump
	
	move_tower:
		addi $sp, $sp, -8 # Save space in stack
		sw $ra, 0($sp) # Save return address
		sw $a0, 4($sp) # Save disk
		beq $a0, 1, equal_one # if (disk == 1)
		# Else
		addi $a0, $a0, -1 # Look for a smaller disks (first)
		add $t0, $a2, $zero # temp = dest
		add $a2, $a3, $zero # dest = spare
		add $a3, $t0, $zero # spare = temp
		jal move_tower # First recursive call
		add $t0, $a2, $zero # temp = dest
		add $a2, $a3, $zero # dest = spare
		add $a3, $t0, $zero # spare = temp
		lw $a0, 4($sp) # Get the disk for the general call
		jal move_disk # Move disk from source to dest
		lw $a0, 4($sp) # Get the disk for the general call
		addi $a0, $a0, -1 # Look for a smaller disks (second)
		add $t0, $a1, $zero # temp = source
		add $a1, $a3, $zero # source = spare
		add $a3, $t0, $zero # spare = temp
		jal move_tower # Second recursive call
		add $t0, $a1, $zero # temp = source
		add $a1, $a3, $zero # source = spare
		add $a3, $t0, $zero # spare = temp
		j end_if # End of if statement
		 
	equal_one: # if (disk == 1)
		jal move_disk # Move disk from source to dest (base case)
		
	end_if: # Save stack values
		lw $ra, 0($sp) # Return address
		lw $a0, 4($sp) # Disk
		addi $sp, $sp, 8 # Bring back address in stack pointer
		jr $ra # Return to recursive general
		
	move_disk:
	# pop - push in line *********************************************
	# pop
		addi $a1, $a1, -4
		lw $t0, ($a1) # Get value of element at the top
		sw $zero, ($a1)
	# push
		sw $t0, ($a2)
		addi $a2, $a2, 4
		jr $ra # Return from move_disk
		
	exit: # End
