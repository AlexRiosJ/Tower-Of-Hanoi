# Author: Alejandro Rios
# Exp: is708932
# Date: Feb 21, 2019
# Tower Of Hanoi
 
.data 
	towerA: .word 8 7 6 5 4 3 2 1
	towerB: .word 0 0 0 0 0 0 0 0
	towerC: .word 0 0 0 0 0 0 0 0
	
.text
	main:
		la $s0, towerA # Direccion de memoria de TowerA
		la $s1, towerB # Direccion de memoria de TowerB
		la $s2, towerC # Direccion de memoria de TowerC
		lw $a0, 0($s0) # Valor del primer elemento de TowerA (Disco más grande)
		add $a1, $s0, $zero # Source 
		add $a2, $s2, $zero # Destiny
		add $a3, $s1, $zero # Spare
		jal move_tower
		j exit
	
	move_tower:
		addi $sp, $sp, -20
		sw $ra, 0($sp)
		sw $a0, 4($sp) # disk
		sw $a1, 8($sp) # source
		sw $a2, 12($sp) # dest
		sw $a3, 16($sp) # spare
		
		beq $a0, 1, equal_one # if (disk == 1)
		addi $a0, $a0, -1
		add $a1, $a1, $zero # source = source
		add $t1, $a2, $zero # temp = dest
		add $a2, $a3, $zero # dest = spare
		add $a3, $t1, $zero # spare = temp
		jal move_tower
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 12($sp)
		add $t8, $a1, $zero
		add $t9, $a2, $zero
		jal move_disk
		lw $a0, 4($sp)
		lw $a1, 8($sp)
		lw $a2, 12($sp)
		lw $a3, 16($sp)
		addi $a0, $a0, -1
		add $t1, $a1, $zero # temp = source
		add $a1, $a3, $zero # source = spare
		add $a2, $a2, $zero # dest = dest
		add $a3, $t1, $zero # spare = temp
		jal move_tower
		j end_if
		 
	
	equal_one:
		add $t8, $a1, $zero
		add $t9, $a2, $zero
		jal move_disk
		
		
	end_if:
		lw $ra, 0($sp)
		lw $a0, 4($sp) # disk
		lw $a1, 8($sp) # source
		lw $a2, 12($sp) # dest
		lw $a3, 16($sp) # spare
		addi $sp, $sp, 20
		jr $ra
		
	move_disk:
		addi $sp, $sp, -4
		sw $ra, 0($sp)
		jal pop
		jal push
		lw $ra, 0($sp)
		addi $sp, $sp, 4
		jr $ra
		
	pop:
		add $t0, $zero, $zero # temp = 0
		addi $t8, $t8, 28
		while_pop: # while
		lw $t2, ($t8)
		beq $t2, -1, end_while_pop
		beq $t2, $zero, end_if_pop
		add $v0, $t2, $zero # temp = source[i]
		sw $zero, ($t8)   # source[i] = 0
		j end_while_pop # break
		end_if_pop:
		addi $t8, $t8, -4
		j while_pop
		end_while_pop:
		jr $ra
		
	push:
		addi $t3, $zero, 0
		while_push:
		add $t9, $t9, $t3
		add $t3, $zero, $zero
		lw $t2, ($t9) # temp = dest[i]
		beq $t3, 32, end_while_push
		bne $t2, $zero, end_if_push
		sw $v0, ($t9)
		j end_while_push
		end_if_push:
		addi $t3, $t3, 4
		j while_push
		end_while_push:
		jr $ra
		
				
	exit: # Fin
