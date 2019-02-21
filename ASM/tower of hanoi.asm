# Author: Alejandro Rios
# Exp: is708932
# Date: Feb 21, 2019
# Tower Of Hanoi

.data 
	towerA: .word 4 3 2 1
	towerB: .word 0 0 0 0
	towerC: .word 0 0 0 0
	
.text
	main:
		la $s0, towerA # Direccion de memoria de TowerA
		la $s1, towerB # Direccion de memoria de TowerB
		la $s2, towerC # Direccion de memoria de TowerC
		lw $a0, 0($s0) # Valor del primer elemento de TowerA (Disco más grande)
		add $a1, $s0, $zero 
		add $a2, $s2, $zero
		add $a3, $s1, $zero
		jal move_tower
		j exit
	
	move_tower:
		addi $sp, $sp, -20
		sw $ra, 16($sp)
		sw $a0, 12($sp)
		sw $a1, 8($sp)
		sw $a2, 4($sp)	
		sw $a3, 0($sp)
		beq $a0, 1, equal_one # if (disk == 1)
		
		addi $a0, $a0, -1
		add $a1, $a1, $zero
		add $t1, $a2, $zero
		add $a2, $a3, $zero
		add $a3, $t1, $zero
		jal move_tower
		 
	
	equal_one:
		jal move_disk
	
	end_if:
		
	move_disk:
		addi $sp, $sp, -12
		sw $ra, 8($sp)
		sw $a1, 4($sp)
		sw $a2, 0($sp)
		
		
		
		
		
				
	exit: # Fin
