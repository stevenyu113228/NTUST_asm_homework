.MODEL SMALL

.DATA
NAMES db 'Barry B. Brey'
MESS db 'Where can it be?'
WHAT db 'What it on first.'
.STACK 100H

.code
MAIN PROC
    mov ax,@DATA
    mov ds,ax
    mov ah,4ch
    int 21h

    MAIN ENDP
    END MAIN
