;TITLE: Program 5 Umoh

;DESCRIPTION: Calculates the mean and standard deviation of a internally defined signed integer list 

INCLUDE Irvine32.inc

.data

.code

main PROC
	mov    ebx, 0
	mov ax, 45
	cwd
	mov bx, 10
	idiv    bx
main ENDP

END main