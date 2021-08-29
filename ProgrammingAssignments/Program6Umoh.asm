;TITLE: Program 6 Umoh

;DESCRIPTION: Calculates the Hamming Code to a generate 12 bit word for a byte of data.

INCLUDE Irvine32.inc

.data
parityType		BYTE ?		;Stores the parity type, 0 for even, 1 for odd
hexByte			DWORD  ?		;stores user inputted byte as two hex digits
encodedByte		DWORD 000000000000b		;stores the 12 bit parity encoding, padded with 0s
transferByte	DWORD ?		;used as an intermediate step to encoded the byte
numSet			DWORD  0, 0, 0, 0		;adds to the num set
p1arr			DWORD  0, 1, 3, 4, 6 
p2arr			DWORD  0, 2, 3, 5, 6 
p4arr			DWORD  1, 2, 3, 7 
p8arr			DWORD  4, 5, 6, 7
parityBits		DWORD  ?, ?, ?, ?		;stores the parity bits to be inputted into the final product
dataArr			DWORD  2,4,5,6,8,9,10,11				;stores where the data bits are located
parityArr		DWORD  0,1,3,7			;stores where the parity bits are located

;Strings
intro			BYTE "CPSC 232 - Hamming Code for Data Byte", 0
inputParity		BYTE "Input the parity type (0- even, *-odd) >> ",0
inputByte		BYTE "Input a byte (two hex digits) >> ",0
message			BYTE "The Hamming encoded message is: ",0

.code

main PROC
	
	;print the introduction
	printIntro:
		mov		edx, OFFSET intro
		call	WriteString
		call	Crlf
		call	Crlf

	;Get the parity type from the user: either a 0 for even or a 1 for odd
	getParityType:
		mov		edx, OFFSET inputParity
		call	WriteString

		;get either a 0 or 1 from the user
		call	ReadDec
		mov		parityType, al
		call	Crlf
		call	Crlf

	;get the hex input byte
	getHexByte:
		mov		edx, OFFSET inputByte
		call	WriteString

		;get the two hex digits
		call	ReadHex
		mov		hexByte, eax
		call	Crlf
	
	;print the hamming code
	printHamming:
		mov		edx, OFFSET message
		call	WriteString

		;call find parity, print out the hamming encoded message
		call	findParity
		call	encodeThing
		call	Crlf

exit
main ENDP

;puts the encoded byte together and prints it to console as a hex value
encodeThing PROC
	mov		esi, 0
	mov 	ecx, 8
	mov		ebx, 0
	
	;fill in all of the data bits
	L1:

	;test the bits of the hex byte, starting from 0
	bt hexByte, ebx

	;if the bit is set, set 1 in the corresponding index in the encoded byte
	jc	add1
	jnc next1

	;if bit is set, set that index to 1 in encoded Byte
	add1:
		mov		eax, [dataarr+esi]
		bts encodedByte, eax

	next1:
		inc ebx
		add esi, 4
		loop L1

	mov		esi, 0
	mov 	ecx, 4
	
	;fill in all of the data bits
	L2:

	;see which parity bits are set, set them in the word
	mov		eax, [parityBits+esi]
	cmp		eax, 1
	je		add11
	jne		next11


	;if bit is set, set that index to 1 in encoded Byte
	add11:
		mov		eax, [parityarr+esi]
		bts		encodedByte, eax

	next11:
		;inc ebx
		add esi, 4
		loop L2

	

	mov		eax, encodedByte
	call	WriteHex
	ret
encodeThing ENDP

findParity PROC
		
		;count the # of 1s for each parity bit
		call	P1
		call	P2
		call	P3
		call	P4

	cmp		parityType, 0
	je		calculateEven

	calculateOdd:
		
		mov		esi, 0
		mov 	ecx, 4

		;Cycle through the total number of 1s for each P bit, if odd, set array element to 0, else, set to 1
		L1:
			;move the total # of ones for current P bit to eax
			mov		eax, [numSet + esi]

			;if the lowest bit of al is set, the total # of ones is odd
			test	al, 1
			jnz		oddNum
			jz		evenNum

			;set parity bit to 0 if # of set bits are odd
			oddNum:
				mov		parityBits[esi], 0
				jmp		exitProg
				
			;set parity bit to 1 if # of set bits are even
			evenNum:
				mov		parityBits[esi], 1

			exitProg:
				add esi, 4
		loop L1

		ret

	calculateEven:
		
		mov		esi, 0
		mov 	ecx, 4

		L4:
			;move the total # of ones for current P bit to eax
			mov		eax, [numSet + esi]

			;if the lowest bit of al is set, the total # of ones is odd
			test	al, 1
			jnz		oddNum1
			jz		evenNum1

			;set parity bit to 1 if # of set bits are odd
			oddNum1:
				mov		parityBits[esi], 1
				jmp		exitProgs
				
			;set parity bit to 0 if # of set bits are even
			evenNum1:
				mov		parityBits[esi], 0

			exitProgs:
				add esi, 4
		loop L4

		mov esi, 0
			mov ecx, 4


	ret
findParity ENDP


;will test for D1, D2, D4, D5, D7
P1 PROC
	;incrementer
	mov		ebx,0
	mov		esi, 0
	mov		ecx, 5

	L1:
	;get the bit number to be tested
	mov		eax, [p1arr + esi]

	;test the first bit of the hex byte
	bt hexByte, eax
	jc	add1
	jnc next1

	;add 1 to ebx if the bit is set
	add1:
		inc ebx

	next1:
		add esi, 4
		loop L1

	mov		eax, ebx
	;call	WriteInt

	;move number of set 1s into first array element
	mov	 [numset + 0], ebx
	ret
P1 ENDP

P2 PROC
	mov		ebx, 0
	mov		esi, 0
	mov		ecx, 5

	L1:
	;get the bit number to be tested
	mov		eax, [p2arr + esi]

	;test the first bit of the hex byte
	bt hexByte, eax
	jc	add1
	jnc next1

	;add 1 to ebx if the bit is set
	add1:
		inc ebx

	next1:
		add esi, 4
		loop L1

	mov		eax, ebx
	;call	WriteInt

	;move number of set 1s into first array element
	mov	 [numset + 4], ebx

	ret
P2 ENDP

P3 PROC
	
	mov		ebx,0
	mov		esi, 0
	mov		ecx, 4

	L1:
	;get the bit number to be tested
	mov		eax, [p4arr + esi]

	;test the first bit of the hex byte
	bt hexByte, eax
	jc	add1
	jnc next1

	;add 1 to ebx if the bit is set
	add1:
		inc ebx

	next1:
		add esi, 4
		loop L1

	mov		eax, ebx
	;call	WriteInt

	;move number of set 1s into first array element
	mov	 [numset + 8], ebx

	ret
P3 ENDP

P4 PROC
	mov		ebx,0
	mov		esi, 0
	mov		ecx, 4

	L1:
	;get the bit number to be tested
	mov		eax, [p8arr + esi]

	;test the first bit of the hex byte
	bt hexByte, eax
	jc	add1
	jnc next1

	;add 1 to ebx if the bit is set
	add1:
		inc ebx

	next1:
		add esi, 4
		loop L1

	mov		eax, ebx
	;call	WriteInt

	;move number of set 1s into first array element
	mov	 [numset + 12], ebx

	ret
P4 ENDP

END main