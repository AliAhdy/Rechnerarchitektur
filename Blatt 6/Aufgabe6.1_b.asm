#void strturnaround(char *str)
#Die Routine soll in einem C-String an der Adresse str die Reihenfolge der Zeichen „in situ“ umkehren,
#es darf also kein weiterer Speicher im .data Bereich benutzt werden.
	.data
str1: .asciiz "Lager"

	.text
	la $a0, str1
	li $t1, 0			#Counter 
	jal strturnaround		#Funktionsaufruf
	j end				#Ende des Programs
	
	
	
strturnaround:
	countLength:
	lb $t0, ($a0)			#Einlesen des Strings
	beqz $t0, reduce		
	addi $a0, $a0, 1		#Hochzählen des Strings
	addi $t1, $t1, 1		#Hochzählen ders Counters
	j countLength
	
	reduce:				#Abspeichern des ersten und letzten char des Strings in $a0 & $a1
	move $a1, $a0			#Abspeichern der Addresse (97 --> 0-Terminator)
	subi $a1, $a1, 1		#Muss gemacht sonst wird der 0-Terminator vertauscht (97-1=96 -->Letztes Zeichen des Strings)
	sub $a0, $a0, $t1		#Zurücksetzten auf Anfangsadresse 92
	
	loop:
	lb $t2, ($a0)			#Laden der Addresse nach $t2
	bge $a0, $a1, back		#Programm beenden wenn beide Zeiger auf gleiche Addresse zeigen(Ungerade Länge) und vermeiden das Zeiger überlappen
	
	lb $t3, ($a1)			#Lädt Addresse in $t3
	sb $t3, ($a0)			#Speichern des letzten Zeichen an den Anfang der Addresse
	sb $t2, ($a1)			#Speichern des ersten Zeichen am Ende der Addresse
	
	addi $a0, $a0, 1		#Erhöhen der Anfangsaddresse
	subi $a1, $a1, 1		#Verminderung der Endadresse
	j loop
	
	back:
	jr $ra


end:
	