;File name hello.asm
.MODEL SMALL

.DATA
AmulB db 'A*B$'
A dw 340dh
B dw 5h
D dw 0ff00h

.STACK 100H

.code
MAIN PROC
    mov ax,@DATA
    mov ds,ax
    
    ;先印第一行
    mov dx,offset AmulB
    mov ah,09h
    int 21h
    
    ;換行
    mov dl,0dh
    mov ah,02h
    int 21h
    mov dl,0ah
    mov ah,02h
    int 21h


    ;計算乘法
    mov bx,A
    mov ax,B
    mul bx
    ;

    mov bx,ax

    ;印出第一位
    and dx,0fh
    add dx,30h
    mov ah,02h     ;準備輸出
	int 21h        ;執行
    
    ;印出第二位
    mov dx,bx
    and dx,0f000h
    mov cl,12
    shr dx,cl
    add dx,30h
    mov ah,02h     ;準備輸出
	int 21h        ;執行

    ;印出第三位
    mov dx,bx
    and dx,00f00h
    mov cl,8
    shr dx,cl
    add dx,30h
    mov ah,02h     ;準備輸出
	int 21h        ;執行

    ;印出第四位
    mov dx,bx
    and dx,000f0h
    mov cl,4
    shr dx,cl
    add dx,30h
    mov ah,02h     ;準備輸出
	int 21h        ;執行

    ;印出第五位
    mov dx,bx
    and dx,0000fh
    add dx,30h
    mov ah,02h     ;準備輸出
	int 21h        ;執行

    ;換行
    mov dl,0dh
    mov ah,02h
    int 21h
    mov dl,0ah
    mov ah,02h
    int 21h

    ;除法
    xor ax,ax
    xor bx,bx
    xor dx,dx
    mov bx,A
    mov ax,B
    mul bx

    mov bx,D
    idiv bx
   
    mov ax,dx
    mov bx,dx
    
    ;印第一位
    and dx,0f000h
    mov cl,12
    shr dx,cl
    add dx,30h
    mov ah,02h
    int 21h

    ;印第二位
    mov dx,bx
    and dx,0f00h
    mov cl,8
    shr dx,cl
    add dx,30h
    mov ah,02h
    int 21h

    ;印第三位
    mov dx,bx
    and dx,00f0h
    mov cl,4
    shr dx,cl
    add dx,30h
    mov ah,02h
    int 21h

    ;印第四位
    mov dx,bx
    and dx,000fh
    add dx,30h
    mov ah,02h
    int 21h


    mov ax,4c00h
    int 21h

    MAIN ENDP
    END MAIN
