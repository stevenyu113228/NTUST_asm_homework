.model small
.STACK 100H

.DATA
NAMES db 'Steven Yu' ;英文名字：Steven Yu

.CODE
MAIN PROC
    mov ax,@DATA     
    mov ds,ax        ;mov DS address

    mov ax,bx        ;題目要求，觀察8BC3
    ;mov eax,ebx     ;8086無法編譯32bit
    mov ax,1103h     ;生日1103

    mov ah,4ch       
    int 21h

MAIN ENDP
END MAIN


