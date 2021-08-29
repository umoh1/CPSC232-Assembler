INCLUDE Irvine32.inc

.data

.code

main PROC
	mov		eax, 0
	mov		ecx, 5
L1:
	push	ecx
	mov		ecx, 10
L2:
	inc		eax
	loop	L2
	pop		ecx
	loop	L1
main ENDP

END main