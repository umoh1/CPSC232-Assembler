;TITLE Program1, Umoh

; This program gets input (name,age), from console and outputs it

INCLUDE Irvine32.inc

.data
userName		BYTE " ",0						;stores the user's name
userAge			BYTE ?							;stores the user's age
askName			BYTE "Enter your name: ",0		;prompt to ask user for name
askAge			BYTE "Enter your age: ",0		;prompt to ask user for age
printAge		BYTE "Your age is: ",0			;used for printing user's age to output
printName		BYTE "Your name is: ",0			;used for printing user's name to output
buffer			BYTE 20 DUP(0)					;buffer for string processing

.code
main PROC
	
	get_input:
		mov		edx, OFFSET askAge		;store age question in string buffer
		call	WriteString				;print out question asking for the user's age
		call	ReadInt					;read user's age as a int from input
		mov		userAge, AL				;move input into variable userAge
		call	Crlf					;new line

		mov		edx, OFFSET askName		;store name question in string buffer
		call	WriteString				;display question asking for the user's name
		mov		edx, OFFSET buffer		;implementing the buffer
		mov		ecx, SIZEOF buffer		;implementing the buffer
		call	ReadString				;get user's name as a string from input
		mov		userName, DL			;store user's name
		call	Crlf					;new line

		
		mov		edx, OFFSET printName	;store print name prompt in string buffer
		call	WriteString				;print out "Your name is"
		mov		DL, userName			;store the user's name in string buffer
		call	WriteString				;print out user's name
		call	Crlf					

		mov		edx, OFFSET printAge	;store print age prompt in string buffer
		call	WriteString				;print out "Your age is:"
		mov		AL, userAge				;store user's age in the low 8 bit eax register, AL
		call	WriteInt				;Write user's age
	exit
main ENDP
END main