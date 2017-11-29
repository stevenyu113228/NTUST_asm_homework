.MODEL SMALL

.DATA
array db 12h, 11h, 99h, 28h, 70h, 16h
index1 db 6
count1 db ?
.STACK 100H

.code
MAIN PROC
    mov ax,@DATA
    mov ds,ax
    
    xor ax,ax
    xor bx,bx
    xor cx,cx
    xor bp,bp

    mov cl,index1
LOOP1:
    mov count1,cl
    mov cl,count1
LOOP2:
    xor bx,bx
    mov bl,count1

    dec bx
    mov ah,array[bx]
    mov bp,bx
    mov bx,cx

    dec bx
    mov al,array[bx]
    mov bx,bp

    cmp ah,al
    jb CHG

LOOP2_CONT:
    loop LOOP2
    mov cl,count1
    loop LOOP1
    jmp END_P

CHG:
    mov array[bx],al
    mov bp,bx
    mov bx,cx
    dec bx
    mov array[bx],ah
    mov bx,bp
    xor ax,ax
    jmp LOOP2_CONT

END_P:
    mov ax,4c00h
    int 21h

    MAIN ENDP
    END MAIN
