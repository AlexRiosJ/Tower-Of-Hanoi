# Author: Alejandro Rios
# Exp: is708932
# Date: Feb 25, 2019
# Tower Of Hanoi
 
.data 
	towerA: .word 8 7 6 5 4 3 2 1 # 8 Disks
	towerB: .word 0 0 0 0 0 0 0 0 # 0 means no disk
	towerC: .word 0 0 0 0 0 0 0 0 # 0 means no disk
	
.text
	main:
		la $s0, towerA # Tower A memory address
		la $s1, towerB # Tower B memory address
		la $s2, towerC # Tower C memory address
		lw $a0, 0($s0) # Biggest disk
		add $a1, $s0, $zero # Source
		add $a2, $s2, $zero # Destination
		add $a3, $s1, $zero # Spare
		jal move_tower # First call (disk, source, dest, spare)
		j exit # Exit jump
	
	move_tower:
		addi $sp, $sp, -20 # Save space in stack
		sw $ra, 0($sp) # Save return address
		sw $a0, 4($sp) # Save disk
		sw $a1, 8($sp) # Save source
		sw $a2, 12($sp) # Save destination
		sw $a3, 16($sp) # Save spare
		beq $a0, 1, equal_one # if (disk == 1)
		# Else
		addi $a0, $a0, -1 # Look for the smaller disks (first)
		add $a1, $a1, $zero # source = source
		add $t0, $a2, $zero # temp = dest
		add $a2, $a3, $zero # dest = spare
		add $a3, $t0, $zero # spare = temp
		jal move_tower # First recursive call
		lw $a0, 4($sp) # Get the disk for the general call
		lw $a1, 8($sp) # Get the source for the general call
		lw $a2, 12($sp) # Get the destination for the general call
		jal move_disk # Move disk from source to dest
		lw $a0, 4($sp) # Get the disk for the general call
		lw $a1, 8($sp) # Get the source for the general call
		lw $a2, 12($sp) # Get the destination for the general call
		lw $a3, 16($sp) # Get the spare for the general call
		addi $a0, $a0, -1 # Look for the smaller disks (second)
		add $t0, $a1, $zero # temp = source
		add $a1, $a3, $zero # source = spare
		add $a2, $a2, $zero # dest = dest
		add $a3, $t0, $zero # spare = temp
		jal move_tower # Second recursive call
		j end_if # End of if statement
		 
	equal_one: # if (disk == 1)
		jal move_disk # Move disk from source to dest (base case)
		
	end_if: # Save stack values
		lw $ra, 0($sp) # Return address
		lw $a0, 4($sp) # Disk
		lw $a1, 8($sp) # Source
		lw $a2, 12($sp) # Destination
		lw $a3, 16($sp) # Spare
		addi $sp, $sp, 20 # Bring back address in stack pointer
		jr $ra # Return to recursive general
		
	move_disk:
	# pop - push in line ********************************************
	pop:
		addi $a1, $a1, 28 # (NUMBER_OF_DISKS * 4) - 1
		while_pop: # while
		lw $t0, ($a1) # Get value of element at the top
		beq $t0, $zero, end_if_pop # if (element == 0) continue
		add $v0, $t0, $zero # temp = source[i]
		sw $zero, ($a1)   # source[i] = 0
		j end_while_pop # break
		end_if_pop:
		addi $a1, $a1, -4 # i = i - 1
		j while_pop
		end_while_pop:
	push:
		while_push:
		lw $t0, ($a2) # element = dest[i]
		bne $t0, $zero, end_if_push # if (element != 0) continue
		sw $v0, ($a2) # else dest[i] = pop value
		j end_while_push # Break while
		end_if_push:
		addi $a2, $a2, 4 # dest[i ++]
		j while_push
		end_while_push:
		jr $ra # Return from move_disk
		
	exit: # End