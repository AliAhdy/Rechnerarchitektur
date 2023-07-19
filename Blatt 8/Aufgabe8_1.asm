	.data
z1: 		.word 0
n1: 		.word 0
strNenner:	.asciiz "Nenner:"
strZaehler:	.asciiz "Zaehler:"
redDarstellung:	.asciiz "Reduzierte Darstellung: "
weiBerechnung:	.asciiz "Weitere Berechnung:"
fehler:		.asciiz "Fehler: Nenner=0"
printggT:	.asciiz " , ggT: "	
printNeustart:	.asciiz "\nProgramm erneut ausführen? (NEIN : '0') "

		
	.text
	
	j main
	
euklid:
	beqz $t0, nullteiler		#Check if Nenner=0
	beqz $t1, nullteiler		#Check if Zaehler=0
	
	bgtz $t0, switch		#Check if Nenner>0
	
algo:
	div $t0,$t1
	move $t0,$t1
	mfhi $t1
	beqz $t1,euklidEnde
	j algo
	
switch:
	move $t2, $t0			#Move Nenner into $t2   
	move $t0, $t1			#Move Zaehler into $t1   
	move $t1, $t2 			
	j algo
	
nullteiler:
	jr $31
	
euklidEnde:
	move $t2, $t0
	jr $31
		
reduce_fraction:
	move $t5, $ra			#Jump addresse 
	move $t3, $t0			#Save Zaehler for ggt div
	move $t4, $t1			#Save Nenner for ggt div
	
	jal euklid	
	
	beqz $t2,reducefractionEnde	
	div $t0,$t3,$t2			
	sw $t0,z1
	div $t1,$t4,$t2
	sw $t1,n1
	
reducefractionEnde:
	jr $t5
	
main:
	la $a0, strZaehler		#Print String Zaehler
	li $v0, 4
	syscall
	
	la $v0, 5			#Read Zaehler 
	syscall
	move $t0, $v0			#Save Zaehler into $t0
	
	la $a0, strNenner		#Print String Nenner
	li $v0, 4
	syscall
	
	la $v0, 5			#Read Nenner 
	syscall
	move $t1, $v0			#Save Nenner in $t1
	
	beqz $t1, OutputFalse		#Check if Nenner=0
	
	jal reduce_fraction
	
	la $a0,redDarstellung		#Print 
	li $v0,4
	syscall
	
	move $a0, $t0			#Store Reduced Zaehler into $a0
	li $v0, 1
	syscall
	
	addi $a0,$0,47			#Char "/"
	li $v0, 11			#print char
	syscall
			
	move $a0,$t1			#Store Reduced Nenner into $a0
	li $v0, 1
	syscall
			
	la $a0,printggT			#Print " ggt: "
	li $v0, 4
	syscall
			
	move $a0,$t2			#Print ggt
	li $v0, 1
	syscall
	
	
neustart:	
	la $a0,printNeustart		#Print Restart string
	li $v0, 4
	syscall
			
	li $v0, 5			#Read int 0 or 1 
	syscall
	beqz $v0,end			#If $v0 = 0--> end
	j main				#Restart
			
OutputFalse:
	la $a0, fehler			#Print string
	li $v0, 4
	Syscall
	j neustart
	
end: