;Title: Program 7 Umoh
;Description: 

INCLUDE Irvine32.inc

.data

intOne			DWORD	?
intTwo			DWORD	?
gcd				DWORD	?
temp			DWORD	0

;Strings
introMessage	BYTE  "Greatest Common Divisor Program",0
inputPrompt		BYTE	"Input two unsigned integers: ",0
inputOne		BYTE	"Input unsigned integer #1: ",0
inputTwo		BYTE	"Input unsigned integer #2: ",0
gcdOut			BYTE	"Greatest common divisor is: ",0
errorMsg		BYTE	"Error - Input is not greater than zero",0

.code

main PROC

intro:
	mov		edx, OFFSET introMessage
	call	WriteString
	call	Crlf
	call	Crlf

get_input:
	mov		edx, OFFSET inputPrompt
	call	WriteString
	call	Crlf
	call	Crlf

	;get first unsigned integer
	mov		edx, OFFSET inputOne
	call	WriteString
	call	ReadDec
	cmp		eax, 0
	jbe		On_Error
	mov		intOne, eax
	
	;get second unsigned integer
	mov		edx, OFFSET inputTwo
	call	WriteString
	call	ReadDec
	cmp		eax, 0
	jbe		On_Error
	mov		intTwo, eax

call_gcd:
	call	Crlf
	mov		edx, OFFSET gcdOut
	call	WriteString

	;a = intOne, b = intTwo
	push	intOne
	push	intTwo
	call	computeGCD
	pop		intOne
	pop		intTwo

	exit

	On_Error:
	call	Crlf
	mov		edx, OFFSET errorMsg
	call	WriteString
	exit
main ENDP

computeGCD PROC
	;to process stack
	push	ebp
	mov		ebp, esp

	;store intOne in eax = a
	mov		eax, [ebp+12]

	;store intTwo in ebx = b
	mov		ebx, [ebp+8]

	;if intOne is less than intTwo, switch two registers so the bigger/smaller
	;xchg	eax, ebx		;eax = a, ebx = b

	mov		edx, 0			;move 0 to edx

	afterWard:
	div		ebx				;divide a/b = eax, remainder = edx

	afters:		;check edx
	cmp		edx, 0			
	je		done			;if a%b ==0, recursion is done

	;else: return computeGCD with b and remainder of a and b as params
	push	ebx				;push a%b : a
	push	edx			;push b	   : b
	call	computeGCD

	done:
		mov		eax, ebx
		call	WriteDec
		pop		ebp
		exit	
computeGCD	ENDP

END main