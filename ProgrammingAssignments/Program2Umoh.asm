;TITLE: Program #2 Umoh

;This program gets an unsigned decimal from the output,
;then stores the info in memory, counts the # of on bits, and
;computes the parity of the number.

INCLUDE Irvine32.inc

.data	
inputNumber			DWORD 0		;Stores user inputted unsigned decimal number
increment			DWORD 0		;holds the number of ones set in the inputted number
check				DWORD 0		;used as an incrementer, which checks whether to stop counting 1s during loop

;STRINGS
promptNumber		BYTE "Input an unsigned decimal number >> ",0	;used to prompt the user for a decimal number
onesPrompt			BYTE "Number of ones found = ",0				;label for the # of ones found
numberIs			BYTE "The number is ",0							;label for whether the number is even or odd
numEven				BYTE "even",0									;used to print out if the number is even
numOdd				BYTE "odd",0									;used to print out if the number is odd
intro				BYTE "CPSC 232 - Program #2",0					;stores intro sentence

.code
main PROC
	
	;Get user inputted unsigned decimal number from console
get_input:
		mov		edx, OFFSET intro				
		call	WriteString							;print out intro sentence
		call	Crlf
		call	Crlf

		mov		edx, OFFSET promptNumber			
		call	WriteString							;prompt the user for a positive decimal number
		call	ReadDec								;read in the unsigned decimal
		mov		inputNumber, eax					;store the unsigned decimal to inputNumber
		call	Crlf								
		mov		ecx, 32								;used to stop loop after processing 32 bits
		mov		ebx, inputNumber						;move user inputted number for processing

	;shift bits for processing by count_ones
binary_convert:
		xor		eax, eax				;add bits with xor
		shl		ebx, 1					;shift bits right
		adc		eax,0					;add carry

		;call WriteInt				;FOR TESTING: write to console
		inc		check					;increment to tell count_ones label when to stop counting
		
		cmp		eax, 1					;compare value in eax to 1 (set bit)
		je		count_ones				;if eax =1, jump to count ones to increment the # of ones set

		LOOP	binary_convert			
		
	;count the # of ones set
count_ones:		
		cmp		check, 32				;compare the check incrementer to 32
		ja		print_results			;if check > 32, counting is done, so jump to print results
		inc		increment				;increment # of ones set
		jb		binary_convert			;if check<32, jump to binary convert to continue counting


	;print out the number of ones found and whether the number of Ones is even or odd
print_results:
							
		mov		edx, OFFSET onesPrompt			
		call	WriteString						;print out prompt stating how many set bits there are
		mov		eax, increment					
		call	WriteDec						;print out the # of ones set

		call	Crlf							
		mov		edx, OFFSET	numberIs			
		call	WriteString						;print out "the number is " prompt

		test	al,00000001b						;compare increment to 1
		jnz		is_odd							;if the zero flag is not set, then the number is odd
		jz		is_even							;if the zero flag is set, then the number is even

	is_odd:
		mov		edx, OFFSET numOdd
		call	WriteString						;write odd to console
		exit

	is_even:
		mov		edx, OFFSET numEven				
		call	WriteString						;print out even to console


	exit
main ENDP
END main