;ch12 quiz

INCLUDE Irvine32.inc

.data
memVal	SDWORD 12
conVal	REAL4	?
coA		BYTE	"Enter a floating point: ",0
PI		REAL4	3.14
result	SDWORD ?
.code

main PROC
	FINIT
	
	mov		edx, OFFSET coA
	call	WriteString
	call	ReadFloat
	fst		conVal
	fild	memVal

	;st(0) = memVal, st(1) = conVal
	fmulp   	st(1), st(0)

	;st(0) *= st(1)
	fld		PI

	;st(0) = PI, st(1) = memVal * conVal
	fdivp	st(1), st(0)

	call	WriteFloat
	fist	result

	exit
main ENDP


end main