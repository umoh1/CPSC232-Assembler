

INCLUDE Irvine32.inc

.data

user1     BYTE "Enter the radius: ",0

area     REAL4 ?
radius	 DWORD ?
PI		 REAL4 3.14


.code

main PROC
mov		edx, OFFSET user1
call	WriteString

call    ReadInt
mov		radius, eax

fild    radius
FMUL    St(0), St(0)    ;radius ^2 = st(0)

fld     PI
FMUL    St(0), St(1)    ;radius ^ 2 * PI = ST(0)

call  WriteFloat



exit
main ENDP

END main