;TITLE: Program 5 Umoh

;DESCRIPTION: Calculates the mean and standard deviation of a internally defined signed integer list 

INCLUDE Irvine32.inc

.data

scoreList		SDWORD -255,-200,-100,-50,0,25,50,75,100,255			;list of signed ints
scoreSize		= ($-scoreList)/4												;size of scoreList

sum				SDWORD 0
mean			SDWORD 0
stdDev1			SDWORD 0						;stores the standard dev
a				SDWORD 1							;starting point of square root
b				SDWORD 0							;ending point of square root
root			SDWORD 0	
square			SDWORD 0
x				SDWORD 0

;Strings
intro			BYTE "CPSC 232 - Stats Computer", 0
listIs			BYTE "The list is ", 0
listMean		BYTE "The list mean is: ",0
listSTD			BYTE "The list standard deviation is: ",0
comma			BYTE ",",0

noDivide		BYTE "Cannot divide by 0. ",0
noZero			BYTE "List is 0. Cannot compute. ",0


.code

main PROC
	printIntro:
		mov		edx, OFFSET intro
		call	WriteString
		call	Crlf
		call	Crlf

	printScoreList:
		call	printList

	printMean:
		mov		edx, OFFSET listMean
		call	WriteString

		call	calculateMean
		call	Crlf

	printStdDev:
		mov		edx, OFFSET listSTD
		call	WriteString

		call	calculateSTD
		
		call	Crlf
	
exit
main ENDP


;Procedure used to calculate mean
calculateMean PROC
	mov		esi, 0
	mov		ecx, scoreSize

	L1:
		mov		eax, [scoreList+esi]
		add		sum, eax
		add		esi, 4

	loop	L1

	;Perform Signed Division between sum and scoreSize
	mov		eax, sum
	cdq

	;Sign extend sum to get ready for division
	mov		ebx, scoreSize

	;no divide by 0
	cmp		ebx, 0
	je		On_Error

	idiv	ebx

	;store mean in listMean
	call	WriteInt
	mov		mean, eax
	
	mov		sum, 0

	ret

	On_Error:
		mov		edx, OFFSET noDivide
		call	WriteString

	exit
calculateMean ENDP


;Procedure used to calculate Standard deviation
calculateSTD PROC

	mov		esi, 0
	mov		ecx, scoreSize

	L1:
		;move x to eax
		mov		eax, [scoreList+esi]
		
		;subtract x - mean
		sub		eax, mean
		
		;square eax: (x-mean)^2
		imul	eax

		;run a SUM of (x-mean)^2
		add		sum, eax
		
		;Increment esi
		add		esi, 4

	loop	L1

	;Do Sum/n
	mov		eax, sum
	cdq

	mov		ebx, scoreSize

	;no divide by 0
	cmp		ebx, 0
	je		On_Error

	;divide
	idiv	ebx

	;store the result of Sum/n
	push	eax

	;store eax in b to find square root
	pop		b

	push	eax
	pop		x
	
	;Square root eax
	mov		ebx, 0

	;fin square root
	call	findSquareRoot
	
	ret

	On_Error:
		mov		edx, OFFSET noDivide
		call	WriteString

	ret
calculateSTD ENDP


findSquareRoot PROC 
	
	;jump to condition
	jmp		L1

	find_Square:
		;Implement (b+a)/2
		mov		eax, b
		add		eax, a
		shr		eax, 1

		;cmp		eax, 0
		;je		On_Error

		;call	crlf
		;call	WriteInt
		;call	crlf

		;store root
		mov		root, eax

		;square eax
		mul		eax
		
		;compare the number and x, if the square < x, set A, else, set B
		cmp		eax, x
		jb		rootIsA
		jae		rootIsB
		
		
	rootIsA:	
		mov		eax, root
		;call	WriteInt
		mov		a, eax

		jmp		L1

	rootIsB:
		mov		eax, root
		mov		b, eax

		jmp		L1

	;while a<b
	L1:		
		;move a to eax
		mov		eax, a

		;move b to ebx
		mov		ebx, b

		;do b-a
		sub		ebx, eax

		cmp		ebx, 1

		;jump if a<b
		ja		find_Square
		
		
	exitingProcas:
		mov		eax, root
		add		eax, 1
		call	WriteInt
		
		ret

	On_Error:
		mov		edx, OFFSET noZero
		call	WriteString

		ret
findSquareRoot ENDP

;Procedure used to print list
printList PROC
	mov		edx, OFFSET listIs
	call	WriteString

	mov		esi, 0
	mov		ecx, scoreSize

	L1:
		mov		eax, [scoreList+esi]
		add		esi, 4
		call	WriteInt

		mov		edx, OFFSET comma
		call	WriteString
	loop	L1

	call	Crlf
	
	ret
printList ENDP

END main