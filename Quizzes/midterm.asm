INCLUDE Irvine32.inc

.data

arrayB SWORD 10h,20h,30h,40h
listOneSize = ($-arrayB)/4

.code


main PROC

mov		eax, OFFSET arrayB
push  eax
push  listOneSize
call  sumArray
pop   eax

    exit
main ENDP


sumArray PROC
	pop		eax
	;mov		listOneSize, AX

	pop		ebx
	;mov		arrayB, AX

	mov		esi, 0									;move 0 to esi for indexing
	mov		ecx, listOneSize						;move size of list one to ecx for looping
	mov		eax, 0


	L1:												;PRINT LIST ONE
	mov		bx, [arrayB + esi]					;move the current element of listone to eax
	add		eax, ebx
	add		esi,4									;increment esi by 4 since the lists are DWORDs			

	loop	L1										;loop through whole array
	
	push eax
	ret
sumArray ENDP



END main