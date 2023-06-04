#Porgamm checkt den ggt von Zahlenparen

#(1) r4 <-- 30
#(2) r5 <-- 25
#(3) r2 <-- r5
#(4) if(r4 == 0) goto (10)
#(5) if(r5 == 0) goto (9)
#(6) if(r4 > r5) r4 <-- r4 - r5
#(7) else r5 <-- r5 - r4
#(8) goto (5)
#(9) r2 <-- r4
#(10) goto (10)
.text

	addi $4, $0, 30		#(1) r4 <-- 30				pc		0x00400000	
	addi $5,$0,25		#(2) r5 <-- 25				pc		0x00400004
	add $2,$0,$5		#(3) r2 <-- r5				pc		0x00400008

	beq $4,$0,zehn		#(4) if(r4 == 0) goto (10)		pc		0x0040000c	(BEQ)000100 (rs)00100 (rt)00000 (Offset)0000 0000 0000 1001 / 0x10800009
fünf:
	beq $5,$0, neun		#(5) if(r5 == 0) goto (9)		pc		0x00400010	(BEQ)000100 (rs)00101 (rt)00000 (Offset)0000 0000 0000 0110 / 0x10a00006
	slt $1,$5,$4		#(6) if(r4 > r5) r4 <-- r4 - r5		pc		0x00400014
	beq $1,$0, else		#(7) if $1 == 0 : goto Else		pc		0x00400018	(BEQ)000100 (rs)00001 (rt)00000 (Offset)0000 0000 0000 0010 / 0x10200002
	sub $4,$4,$5		# if  $5 < $4 : $4 = $4 - $5		pc		0x0040001c	
	j fünf							       #pc		0x00400020	(jump)000010 (0)0000 (4)0100 (0)0000 (0)0000 (0)0000 (1)0001 (0->letzten beiden Bits wegstreichen)00 /0x08100004
else: 	
	sub $5,$5,$4		#(7) if $5 >= $4 : $5 = $5 - $4		pc		0x00400024
	j fünf			#(8) goto (5)				pc		0x00400028	(jump)000010 (0)0000 (4)0100 (0)0000 (0)0000 (0)0000 (1)0001 (0->letzten beiden Bits wegstreichen)00 /0x08100004
				
neun: 	
	add $2,$0,$4		#(9) r2 <-- r4				pc		0x0040002c

zehn:  	
	j zehn			#(10) goto (10)				pc		0x00400034	(jump)000010 (0)0000 (4)0100 (0)0000 (0)0000 (0)0000 (3)0011 (4)01 / 0x0810000d
	

#a)?Uberpr ?ufen Sie Ihr Programm anhand folgender Zahlenpaare:
#(25,35)--> 5, (210,28)--> 14, (49,42)--> 7, (17,3)--> 1, (17,51)--> 17
#Einfach die Werte in $4 & $5 ändern


#b) Berechnen Sie die Instruktionsw ?orter der Sprunginstruktionen Ihres Programms mit Hilfe der MIPS Dokumentation ”per Hand“ und 
#vergleichen Sie sie mit den vom Assembler generierten!

#PC: 00-->04-->08-->0C-->10-->14-->18-->1C-->20-->24-->28-->30-->34 Jeweils pro Zeile +4 im PC










