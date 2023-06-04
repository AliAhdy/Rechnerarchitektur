	.text

 	addi $4, $0, 30     # (1) r4 <-- 30 to the subroutine/function
 	addi $5, $0, 25     # (2) r5 <-- 25 to the subroutine/function
 	add $29, $0, $31    # (3) r2 <-- r5
 	jal ggt             # Call the gcd subroutine
	add $31, $0, $29    # Restore return address from stack pointer (only if stack is not used elsewhere)
	
	 addi $4, $0, 25     # (1) r4 <-- 30 to the subroutine/function
 	addi $5, $0, 35     # (2) r5 <-- 25 to the subroutine/function
 	add $29, $0, $31    # (3) r2 <-- r5
 	jal ggt             # Call the gcd subroutine
	add $31, $0, $29    # Restore return address from stack pointer (only if stack is not used elsewhere)
	
	 addi $4, $0, 210     # (1) r4 <-- 30 to the subroutine/function
 	addi $5, $0, 28     # (2) r5 <-- 25 to the subroutine/function
 	add $29, $0, $31    # (3) r2 <-- r5
 	jal ggt             # Call the gcd subroutine
	add $31, $0, $29    # Restore return address from stack pointer (only if stack is not used elsewhere)
	
	 addi $4, $0, 49     # (1) r4 <-- 30 to the subroutine/function
 	addi $5, $0, 42     # (2) r5 <-- 25 to the subroutine/function
 	add $29, $0, $31    # (3) r2 <-- r5
 	jal ggt             # Call the gcd subroutine
	add $31, $0, $29    # Restore return address from stack pointer (only if stack is not used elsewhere)
	
	 addi $4, $0, 17     # (1) r4 <-- 30 to the subroutine/function
 	addi $5, $0, 3     # (2) r5 <-- 25 to the subroutine/function
 	add $29, $0, $31    # (3) r2 <-- r5
 	jal ggt             # Call the gcd subroutine
	add $31, $0, $29    # Restore return address from stack pointer (only if stack is not used elsewhere)

 	addi $4, $0, 17     # (1) r4 <-- 30 to the subroutine/function
 	addi $5, $0, 51     # (2) r5 <-- 25 to the subroutine/function
 	add $29, $0, $31    # (3) r2 <-- r5
 	jal ggt             # Call the gcd subroutine
	add $31, $0, $29    # Restore return address from stack pointer (only if stack is not used elsewhere)

ggt:
	add $2,$0,$5        # Initialize r2 <-- r5
	beq $4,$0,exit      # if(r4 == 0) return
loop:
	beq $5,$0, finish   # if(r5 == 0) return
	slt $1,$5,$4        # if(r4 > r5) r1 <-- 1 else r1 <-- 0
	beq $1,$0, else     # if $1 == 0 : goto Else
	sub $4,$4,$5        # if  $5 < $4 : $4 = $4 - $5
	j loop
else:   
	sub $5,$5,$4        # if $5 >= $4 : $5 = $5 - $4
	j loop
finish:   
	add $2,$0,$4        # r2 <-- r4
exit:
	jr $31              # return to the calling routine
