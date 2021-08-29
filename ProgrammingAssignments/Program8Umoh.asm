;Program 8 Umoh: Floating point quadratic equation calculator
INCLUDE Irvine32.inc

.data

;numbers
A1		REAL4 ?
B1		REAL4 ?
C1		REAL4 ?
root1   REAL4 ?
root2	REAL4 ?
dis		REAL4 ?
four	REAL4 4.0
zero	REAL4 0.0
two		REAL4 2.0
nOne	REAL4 -1.0


;Strings
coA			BYTE	"Coefficient (A) for Ax^2 + Bx + C: ",0
coB			BYTE	"Coefficient (B) for Ax^2 + Bx + C: ",0
coC			BYTE	"Coefficient (C) for Ax^2 + Bx + C: ",0
root1prompt	BYTE	"Root 1: ",0
root2prompt	BYTE	"Root 2: ",0
iroot		BYTE	"This polynomial has an imaginary root",0
err			BYTE	"A cannot be 0. Exiting Program.",0
err1		BYTE	"This polynomial has an imaginary root.",0
err2		BYTE	"Cannot divide by 0. ",0


.code

main PROC
	FINIT

	;print prompt for A and read in A
	mov		edx, OFFSET coA
	call	WriteString
	call	ReadFloat

	;leave program if 0 = A
	fcom zero
	fnstsw	ax
	sahf
	je	on_error

	;store and pop A from stack
	fstp		A1

	;print prompt for B and read in B
	mov		edx, OFFSET coB
	call	WriteString
	call	ReadFloat
	fstp		B1

	;print prompt for C and read in C
	mov		edx, OFFSET coC
	call	WriteString
	call	ReadFloat
	fstp		C1

	call	solve

		exit
	on_error:
		mov		edx, OFFSET err
		call	WriteString

	exit
main ENDP

solve PROC
	;find the discriminant, will be stored in dis
	
	call	discrim
	
	;calculate -b + sqrt(dis)
	fld		B1		;load B1 to st(0)
	FCHS			;change B1 to negative on stack

	fld	   dis		;load dis, st(1) = -B1, st(0) = dis
	fsqrt			;get sqrt of dis

	faddp   St(1), St(0)		;-B + sqrt(dis) = St(0)

	;divide answer by 2a
	fld		two			;st(1) = -B + sqrt(dis), st(0) = 2.0
	fld		A1			;st(2) = -B + sqrt(dis), st(1) = 2.0, st(0) = A1
	fmulp	st(1), st(0)	;st(0) = A1 * 2.0

	fdivp	st(1), st(0)	;perform -B + sqrt(dis) /2a
	fstp    root1
	

	;calculate -b - sqrt(dis)
	fld		B1		;load B1 to st(0)
	FCHS			;change B1 to negative on stack

	fld	   dis		;load dis, st(1) = -B1, st(0) = dis
	fsqrt			;get sqrt of dis

	fsubp  St(1), St(0)		;-B - sqrt(dis) = St(1)

	;divide answer by 2a
	fld		two			;st(1) = -B - sqrt(dis), st(0) = 2.0
	fld		A1			;st(2) = -B - sqrt(dis), st(1) = 2.0, st(0) = A1
	fmulp	st(1), st(0)	;st(0) = A1 * 2.0

	fdivp	st(1), st(0)	;perform -B - sqrt(dis) /2a
	fstp    root2

	;Print out the roots
	call	printRoots

	exit
	on_error1:
		mov		edx, OFFSET err2
		call	WriteString
	exit
solve ENDP

discrim PROC
					;calculate b^2 - 4ac = ans

	;load B onto the stack twice, allows for squaring
	fld	B1			;st(0) = B1
	FMUL St(0), St(0)			;compute B^2

	;store ans in dis
	fstp	dis		;store B^2 in dis, pop off stack so there is no left over
	
	;calculate 4 * a * c
	fld		four	;st(0) = 4
	fld		A1		;st(1) = four, st(0) = A1
	FMUL	st(0), st(1)	;multiply 4 * A1, product = st(0)
	FMUL	 C1		;multiply C1 * (4*A1)

	fld		dis		;load onto stack, st(0) = dis, st(1) = 4ac
	fsub	st(0),st(1)		;perform b^2 - 4ac

	fst	dis			;store b^2 - 4ac into dis, don't pop stack so that you can compare
	 
		
	;if ans > 0, there are 2 solutions
	fcom	zero
	fnstsw	ax
	sahf
	jb		complex
	fstp	dis			;store dis and pop stack (FOR SAFETY, CHECK IF ERROR)

	fcompp	

	;print the imaginary number thing if discriminant less than 0
		ret
	complex:
		mov		edx, OFFSET err1
		call	WriteString
	exit
discrim	ENDP

;print roots
printRoots PROC
;print root 1
	mov		edx, OFFSET root1prompt
	call	WriteString
	fld		root1
	call	WriteFloat
	call	crlf
	

;print root2
	mov		edx, OFFSET root2prompt
	call	WriteString
	fld		root2
	call	WriteFloat

	
	ret
printRoots ENDP

end main