;File name hello.asm
.MODEL SMALL

.DATA
mes db '123$'
.STACK 100H

.code
MAIN PROC
    mov ax,@DATA
    mov ds,ax
    
    mov dx,offset mes
    mov ah,09h
    int 21h
    
    mov ax,4c00h
    int 21h

    MAIN ENDP
    END MAIN
