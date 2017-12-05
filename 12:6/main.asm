include main.h
.MODEL SMALL

.DATA
column_init dw 300
row_init dw 200
color db 06h
.STACK 100H

.code
MAIN PROC
    mov ax,@DATA
    mov ds,ax

    draw_mode
    bg_color 03h

WWW:
    triangle column_init,row_init,color
    get_char
    cmp al,1bh	 ;是否為ESC鍵
	je exit
    cmp al,'8'  ; up row - 4
    je UP
    cmp al,'2'  ; down row + 4
    je DOWN
    cmp al,'4'  ; left col - 4
    je LEFT
    cmp al,'6'  ; right col + 4
    je RIGHT
    cmp al,'5'  ; change color
    je CHGCOLOR

UP:
    clear_screen row_init,column_init,03h
    mov ax,row_init
    sub ax,4
    mov row_init,ax
    jmp WWW

DOWN:
    clear_screen row_init,column_init,03h
    mov ax,row_init
    add ax,4
    mov row_init,ax
    jmp WWW

LEFT:
    clear_screen row_init,column_init,03h
    mov ax,column_init
    sub ax,4
    mov column_init,ax
    jmp WWW

RIGHT:
    clear_screen row_init,column_init,03h
    mov ax,column_init
    add ax,4
    mov column_init,ax
    jmp WWW

CHGCOLOR:
    clear_screen row_init,column_init,03h
    mov ah,color
    cmp ah,15
    je SET_COLOR0
    inc ah
    mov color,ah
    jmp WWW

SET_COLOR0:
    mov ah,0
    mov color,ah
    jmp WWW

exit:    
    text_mode
    mov ax,4c00h
    int 21h
MAIN ENDP
END MAIN