;TITLE Program3, Umoh

;Accepts a string from the console, and determines whether or not it is a palindrome

INCLUDE Irvine32.inc


.data
;myByte BYTE 00h, 0FFh
;myDouble DWORD 12345678h
sum		DWORD 0
.code
	main PROC

	;mov al,myByte 
	;mov ah,[myByte+1]    

	;mov ax,WORD PTR [myDouble+1]


	;mov al, 0
	;mov ah, 0
	;dec ah

	mov eax,1

	mov ecx,10
	L1:
		add sum, eax
		add eax,2
		LOOP L1
	mov		eax,sum
	call	WriteInt

	exit
	main ENDP
	END main