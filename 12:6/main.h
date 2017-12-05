print_string macro string
    mov ah,09h
    mov dx,offset string
    int 21h
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
    push ax
    push bx
    push cx
    mov ah,0ch
    mov bh,00h
    mov al,color
    mov cx,col
    mov dx,row
    int 10h
    pop cx
    pop bx
    pop ax
endm

triangle macro  col,row,color
local L1,OVER_W
    mov cx,col
    mov dx,row
L1:
    draw_pixel cx,dx,color
    inc cx
    push cx
    push dx
    sub cx,col
    sub dx,row
    cmp cx,dx
    pop dx
    pop cx
    jna L1
OVER_W:
    mov cx,col
    inc dx
    push ax
    mov ax,row
    add ax,40
    cmp dx,ax
    pop ax
    jna L1
endm

clear_screen macro row,col,color
local L1,L2
    mov cx,col
    mov dx,row
L1:
    draw_pixel cx,dx,color
    inc cx
    mov ax,col
    add ax,40
    cmp cx,ax
    jna L1
L2: 
    mov cx,0
    inc dx
    mov ax,row
    add ax,40
    cmp dx,ax
    jna L1
endm
