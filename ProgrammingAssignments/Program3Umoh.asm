;TITLE Program3, Umoh

;Accepts a string from the console, and determines whether or not it is a palindrome

INCLUDE Irvine32.inc

.data			

MAX = 21																	;stores amount of characters to be read in by string
inputSize				DWORD ?												;stores size of input string

;STRINGS
inputString				BYTE	MAX  DUP (?)								;stores user inputted string
copyInputString			DWORD   MAX +1 DUP (?)								;stores copy of input string
reversedString			BYTE	MAX  DUP (?)								;stores reversed user inputted string

promptString			BYTE   "Input a string (20 chars max) >>",0			
reversePromptString		BYTE   "The reverse of the string is: ",0			
isPalindrome			BYTE   "The string is a palindrome",0
notPalindrome			BYTE   "The string is not a palindrome",0
error					BYTE   "Error - Empty String Entered",0
intro					BYTE   "CPSC 232 - Program #3",0

.code

main PROC

;Print out intro statement
	introStatement:
		mov		edx, OFFSET intro					
		call	WriteString								;write intro to the console
		call	Crlf
		call	Crlf

;print out prompt string and get input from the user and store
	get_input:
		mov		edx, OFFSET promptString
		call	WriteString								;write prompt to the user to the console

		mov		edx, OFFSET inputString
		mov		ecx, MAX
		call	ReadString								;read in input string

		cmp		inputString, 00000000
		jz		on_Error								;if the string is empty, jump to error message

		mov		inputSize, eax							;get size of string
		mov		esi, 0									;set esi to 0 for string indexing
		mov		ecx, inputSize							;set ecx to size of string for looping
		

;reverse the inputted string and store in memory
	
	;Push each character onto the stack
	reverse_string:		
		movzx		eax, inputString[esi]				;move each character to eax, padded with 0s
		push		eax									;push eax onto the stack		
		inc			esi									;increment esi to point to next character
		loop		reverse_string						;loop to get through all characters
	
		mov ecx, inputSize								;reset ecx to actually reverse string
		mov	esi, 0										;set esi pointer
	
	;Pop the loaded characters on the stack to reverse them
	reverse:
		pop		eax										;pop characters in reverse order
		mov		reversedString[esi],al					;move character to index in input string
		inc		esi										;increment esi to point to next character
		loop	reverse									;loop to reverse all characters

		

;print out reversed string
	print_reverse_string:
		mov		edx, OFFSET reversePromptString
		call	WriteString								;write reverse string prompt to console
		mov		edx, OFFSET reversedString
		call	WriteString								;write reversed input string to console
		call	Crlf

;check if the input string is a palindrome
	palindrome_check:
		mov		esi, 0									;set esi to 0 for indexing
		mov		ecx, inputSize							;set ecx to size of string for looping
	
	;Push string onto the stack
	push_String:	
		movzx		eax, inputString[esi]				;move each character to eax, padded with 0s
		push		eax									;push eax onto the stack		
		inc			esi									;increment esi to point to next character
		loop		push_string							;loop to get through all characters
	
		mov ecx, inputSize								;reset ecx to actually reverse string
		mov	esi, 0										;set esi pointer
	
	;Pop characters off the stack to get them in reverse order. If at any point the index of the reversed string
	;differs from the index of the input string, it is not a palindrome
	pop_String:
		pop		eax										;pop a character in reverse order
		mov		reversedString[esi],al					;move character to index in input string
		cmp     al, inputString[esi]					;compare the character with the inputstring character
		jnz		not_palindrome							;If reversedString[x] != inputString[x], jump to not a palindrome
		inc		esi										;increment esi to point to next character	
		loop	pop_String								;loop to reverse all characters

		
;Jump to this if it is a palindrome
	is_palindrome:
		mov		edx, OFFSET isPalindrome
		call	WriteString							;write is palindrome to console
		exit

;Jump to this if it is not a palindrome
	not_palindrome:
		mov		edx, OFFSET notPalindrome
		call	WriteString							;write not a palindrome to console
		exit

;Jump to error message
	on_Error:
		mov		edx, OFFSET error
		call	WriteString							;write an error message to console
	
exit
main ENDP
END main
