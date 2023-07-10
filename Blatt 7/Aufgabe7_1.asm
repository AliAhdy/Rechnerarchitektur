	.data
str:	.space 50			#Space for input string
	.byte 0xff
	.byte 0xff
typeInString:.asciiz "Type a string: "
typeInChar:.asciiz "Type a char: "
amount:.asciiz " occurence("
again: .asciiz "Again?"



	.text
loop:				
	j main
	
ncstr:
	lb $t0, ($a0)
	beqz $t0, endncstring		#End of string if = 0
	beq $t0, $a1, addcount		#If char equal string val, increment add counter
	addi $a0, $a0, 1
	j ncstr

addcount:
	addi $a0, $a0, 1		#Add 1 to counter
	addiu $t1, $t1, 1 		#Increment
	j ncstr
	
endncstring:
	jr $31
		
		

main:
	la $a0, typeInString
	li $v0, 4
	syscall				#print text
	
	la $a0, str
	li $a1, 32
	li $v0, 8
	syscall				#read string
	
	
	la $a0, typeInChar
	li $v0, 4
	syscall				#print text
	
	li $v0, 12
	syscall				#read char
	move $a1, $v0
	
	la $a0, str			#Load and store the string in a0
	li $t1, 0			#Initilize register			
	
	jal ncstr
	
	li $v0, 11
	li $a0, '\n'
	syscall				#Print new Line
	
	li $v0, 1			
	move $a0, $t1			#Get occurence number from t1 and store in a0
	syscall				#Print int
	
	la $a0, amount			#Occurence
	li $v0, 4
	syscall
	
	li $v0, 11
	move $a0, $a1			#Get input char from user
	syscall				#print char
	
	li $v0, 11
	li $a0, 41
	syscall				#Print a ')'
	
	la $a0, again			#Get string from .data
	li $v0, 50			#Dialog window
	syscall
	
	beq $a0, 0, newLine
	bne $a0, 0, end
	
newLine:
	li $v0, 11
	li $a0, '\n'
	syscall				#Print new Line
	j loop
	
end:
	
	
