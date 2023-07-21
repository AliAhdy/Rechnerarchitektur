	.data
pPrint:		.asciiz "p>"
qPrint:		.asciiz "q>"
zeroSolPrint:	.asciiz "0 solution(s)"
oneSolPrint:	.asciiz "1 solution(s) \n"
twoSolPrint:	.asciiz "2 solution(s) \n"
sol1:		.asciiz "solution 1: "
sol2:		.asciiz "\nsolution 2: "
vier:		.double 4
zwei:		.double -2
	.text
	
	j main
	
quadsolve:
	
	mul.d $f10, $f12, $f12	
	l.d $f8, vier
	div.d $f10, $f10, $f8
	sub.d $f10, $f10, $f14
	
	c.lt.d $f10, $f28 
	bc1t noSol
	
	c.eq.d $f10, $f28
	bc1t oneSol
	
	bc1f twoSol	
			
	
				
							
noSol:
	la $a0, zeroSolPrint
	li $v0, 4
	syscall	
	jr $31
	

oneSol:
	l.d $f8, zwei
	div.d $f12, $f12, $f8
	
	la $a0, oneSolPrint
	li $v0, 4
	syscall
	
	la $a0, sol1
	li $v0, 4
	syscall
	
	li $v0, 3
	syscall
	
	jr $ra
	
twoSol:	
		
	l.d $f8, zwei
	div.d $f12, $f12, $f8
	sqrt.d $f10, $f10
	sub.d $f0, $f12, $f10
	add.d $f2, $f12, $f10
	
	
	la $a0, sol1
	li $v0, 4
	syscall
	
	mov.d $f12, $f0
	li $v0, 3
	syscall
	
	la $a0, sol2
	li $v0, 4
	syscall
	
	mov.d $f12, $f2
	li $v0, 3
	syscall

	jr $31
														
main:
	li $v0, 4
	la $a0, pPrint
	syscall	
	
	li $v0, 7
	syscall
	mov.d $f12, $f0
	
	li $v0, 4
	la $a0, qPrint
	syscall	
	
	li $v0, 7
	syscall
	mov.d $f14, $f0
	
	jal quadsolve
	
	
end: