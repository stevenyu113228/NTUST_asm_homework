clear_screen macro
    mov ax,0a000h
    mov es,ax
    xor di,di
    mov cx,4b000h
    rep stosb
endm

print_string macro string
    pusha
    mov ah,09h
    mov dx,offset string
    int 21h
    popa
    endm

text_mode macro
    push ax
    mov ah,00h
    mov al,03h
    int 10h
    pop ax
endm

get_char macro
    mov ah,10h
    int 16h
endm

draw_mode macro
    push ax
    mov ah,00h
    mov al,12h ;640x480 , 16color
    int 10h
    pop ax
endm

bg_color macro color
    push ax
    push bx
    mov ah,0bh
    mov bh,00h
    mov bl,color
    int 10h
    pop bx
    pop ax
endm

draw_pixel macro col,row,color
    pusha
    mov ah,0ch
    mov bh,00h
    mov al,color
    mov cx,col
    mov dx,row
    int 10h
    popa
endm

rectangle macro  col,row,length,weigth
local L1,L2
    pusha
    mov di,col
    mov dx,row
L1:
    draw_pixel di,dx,02h ;02 color
    inc di
    mov ax,length
    add ax,col
    cmp di,ax
    jna L1
L2:
    mov di,col
    inc dx
    mov ax,row
    add ax,weigth
    cmp dx,ax
    jne L1
    popa
endm






h_rectangle macro col,row,length,weigth,chu
    pusha
    rectangle col,row,length,chu
    rectangle col,row,chu,weigth
    mov cx,col
    add cx,length
    mov bp,weigth
    add bp,chu
    rectangle cx,row,chu,bp
    mov cx,row
    add cx,weigth
    mov bp,length
    add bp,chu
    rectangle col,cx,bp,chu
    popa
endm

get_rand macro
    mov ah,2ch
    int 21h
    ;dl is 0~99亂數
endm

wait_key macro
    mov ah,11h
    int 16h
endm


clear_screen macro
    mov ax,0a000h
    mov es,ax
    xor di,di
    mov cx,4b000h
    rep stosb
endm



printstr13h macro str,atr,lennn,rowww,colll  ;ø�ϼҦ���X�r��
	    mov ax,ds
	    mov es,ax
        mov bp,offset str
	    mov ah,13h
	    mov al,1h
        mov bh,00
	    mov bl,atr	   ;顏色 
        mov cx,lennn
	    mov dh,rowww
	    mov dl,colll
	    int 10h
	endm