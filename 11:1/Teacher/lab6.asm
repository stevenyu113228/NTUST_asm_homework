include Lab6_print.h
getkey	macro
        mov     ah,00h	
        int     16h	
	endm

.model small
.data
Ent db 'Press ESC to exit',0ah,0dh,'$'

.stack
.code
main proc
	mov ax,@data
	mov ds,ax

L1:	pString Ent
L2:	getkey

	cmp al,1Bh
	je L3

	pChar al
	jmp L2

L3:	mov ax,4c00h
	int 21h

main endp
end main