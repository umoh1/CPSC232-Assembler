;TITLE Program3, Umoh

;Accepts a string from the console, and determines whether or not it is a palindrome

INCLUDE Irvine32.inc


.data

myMethod PROTO
    pString: PTR BYTE,
    pChar: BYTE
    pNum: DWORD
	varA: DWORD
	varB: SWORD

.code



main PROC
	
	 INVOKE myMethod 

	exit
main ENDP

END main