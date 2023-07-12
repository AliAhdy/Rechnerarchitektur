	.data
str1: 	.asciiz "Lager"
str2: 	.asciiz "Regal"
str3: 	.space 10
	.byte 	0xff
	.byte 	0xff


	.text
	addi $20, $0, 64
	addi $21, $0, 91
	
	j main

#a.)	
strtolower:
	lb $5, ($2)			#Load byte into $5
	beqz $5, end1			#if = /0 end of String
	bgt $5, $20, greater64		#check if it is a letter or not
	j increment1
	
greater64:
	blt $5, $21, tolower		#A-Z -- tolower
	
increment1:
	addiu $2, $2, 1			#go to next char of the string
	j strtolower
	
tolower:
	addi $5, $5, 32			#upper to lower
	sb $5, ($2)			#store result in exact spot of the string
	
end1:
	jr $31
	

#b.)
strturnaround:
	addu $3, $0, $2			#Copy address into $3
	
counter:
	lb $4, ($3)			#Load bytes into $4
	beqz $4, preturnaround		#Determing the end of the String
	addiu $3,$3,1			#get next byte
	j counter

preturnaround:
	addiu $3, $3, -1		#To get last byte of string
	
turnaround:
	bleu $3, $2, end2		#if $3 <= $2 then end2
	lb $4, ($2)			#load char from $2*(start) into $4
	lb $5, ($3)			#load char from $5(end) into $5
	
	sb $5, ($2)			#store in switched positions
	sb $4, ($3)			#same
	
	addiu $2, $2, 1			#add 1 to start address
	addiu $3, $3, -1		#sub 1 from end address
	
	j turnaround
	
end2:
	jr $31
	
			
#c.)
strispalindrom:
	addu $3, $0, $2			#Kopie von addresse 
	
counter2:
	lb $4, ($3)			#Load byte into $4
	beqz $4, prepalindrom		#If byte = /0 to endcounter
	addiu $3, $3, 1			#increment next byte
	j counter2
	
prepalindrom:
	subiu $3, $3, 1
	
palindrom:
	bleu $3, $2, end3		#if $3 <= $2 then end3
	
	lb $4, ($2)			#Load char from $2(start) into $4
	lb $5, ($3)			#load char from $5(end) into $5
	
	seq $6, $4, $5			#if $4=$5 -> $6=1 else $6=0
	beq $6, $0, end3		#if $6=0 (string is not palidnrom) jump to end
	
	addiu $2, $2, 1			#add 1 to start address
	addiu $3, $3, -1		#subtract 1 from end address
	j palindrom
	
end3:
	add $v0,$0, $6			#Result 0 or 1 stored in $v0
	jr $31

			
#d.)
strcat:
catstr1:
	lb $5, ($2) 			#get first byte of str1
	beqz $5, catstr2		#Check if equal 0 --> next string
	sb  $5, ($4)			#Store byte in $4
	
	addiu $2, $2, 1			#Increment str
	addiu $4, $4, 1			#increment store place
	
	j catstr1
	
catstr2:
	lb $6, ($3)			#Same as before
	lb $6, ($3)
	beqz $6, end4			#If equal 0 --> str2 end 
	sb $6, ($4)			#Store in $4
	
	addiu $3, $3, 1			#Increment
	addiu $4, $4, 1
	
	j catstr2

end4:
	sb $0, ($4)
	jr $31

			
main:
#a.)
	la $2, str1			#Load string into $2
	jal strtolower
	
	la $2, str2
	jal strtolower
#b.)	
	la $2, str1
	jal strturnaround
	
	la $2, str2
	jal strturnaround
#d.)	
	la $2, str1
	la $3, str2
	la $4, str3
	jal strcat
#c.)	
	la $2, str3
	jal strispalindrom
