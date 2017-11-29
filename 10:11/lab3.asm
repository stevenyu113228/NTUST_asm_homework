
.MODEL SMALL

.DATA
value dw 0ffffh,0003h,7fffh,8123h
result db 4 dup(?), '$'

.STACK 100H

.code
MAIN PROC
    mov ax,@DATA
    mov ds,ax

    mov ax,value[0]   
    add ax,value[0] ;題目要我value1加兩次ㄉQQ
    add ax,value[2]
    add ax,value[4]
    add ax,value[6]

    mov bx,ax     
    mov dx,ax      ;ax放在bx,dx備用

    and dx,0f000h  ;mask
 	mov cl,12      ;12放cl準備移位
	shr dx,cl      ;➡️移12格
	add dl,30h     ;+30h變成ASCII
    mov result[0],dl    ;把值放在result[0]

    mov dx,bx
    and dx,00f00h  ;mask
 	mov cl,8      ;8放cl準備移位
	shr dx,cl      ;➡️移8格
	add dl,30h     ;+30h變成ASCII
    mov result[1],dl

    mov dx,bx
    and dx,000f0h  ;mask
 	mov cl,4      ;4放cl準備移位
	shr dx,cl      ;➡️移4格
	add dl,30h     ;+30h變成ASCII
    mov result[2],dl

    mov dx,bx
    and dx,0000fh  ;mask
	add dl,30h     ;+30h變成ASCII
    mov result[3],dl

    mov dx,offset result  ;把值放dx
    mov ah,09h          ;輸出
    int 21h

    mov ah,4ch  
    int 21h

    MAIN ENDP
    END MAIN
