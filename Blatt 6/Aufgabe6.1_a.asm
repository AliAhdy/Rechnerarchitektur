#void strtolower(char *str)
#Die Routine soll in einem C-String an der Adresse str alle Groﬂbuchstaben in Kleinbuchstaben verwandeln.

	.data
str1: 	.asciiz "Lager"
str2: 	.asciiz "Regal"
str3: 	.space 10		#Reserviert Speicher im Data Segment
	.byte 0xff
	.byte 0xff
	
	.text
	la $a0, str1		#Abspeichern der String Addresse str1
	jal strtolower
	j ende
	
strtolower:
	lb $t0, ($a0)		#l‰dt das Zeichen worauf die Addresse gerade zeigt, gespeichert in $t0
	beqz $t0, back 		#schaut ob das Zeichen =0, Bedeutet Ende des eingelesenden Wortes
#Wenn das Zeichen kleiner als 97 (=a), dann kein Kleinbuchstabe!
	blt $t0, 97, tolower	#d.h. Groﬂbuchstabe wird zu Kleinbuchstabe
	addi $a0, $0, 1		#Wenn es schon ein Kleinbuchstabe ist wird die n‰chste Addresse genommen
	j strtolower

tolower:
	addi $t0, $t0, 32	#+32 Addiert zur Addresse
	sb $t0, ($a0)		#Wert in $t0 wird in den String, der in $a0 gespeichert wurde, geschrieben (vgl. L.9)
	addi $a0, $a0, 1	#N‰chste Addresse wird genommen
	j strtolower
	
back:
	jr $ra
	
ende:
	