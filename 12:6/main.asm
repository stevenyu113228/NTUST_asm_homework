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

    draw_mode    ; into draw mode
    bg_color 03h ; set bg color = 03h 青綠色

; ==========MAIN LOOP========
WWW:
    triangle column_init,row_init,color
    get_char
    cmp al,1bh	 ;是否為ESC鍵
	je EXIT
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
    jmp WWW
; ==========MAIN LOOP========



; --------------------KEY_START--------------------

; ----------UP_START-----------
UP:
    triangle column_init,row_init,03h ;clear screen
    mov ax,row_init
    sub ax,4
    cmp ax,0
    jl UP_OUT_OF_RANGE  ; signed <
    jmp UP_SUBMIT
UP_OUT_OF_RANGE:
    mov ax,0
UP_SUBMIT:
    mov row_init,ax
    jmp WWW
; ----------UP_STOP-----------


; ----------DOWN_START-----------
DOWN:
    triangle column_init,row_init,03h ;clear screen
    mov ax,row_init
    add ax,4
    cmp ax,440
    ja DOWN_OUT_OF_RANGE
    jmp DOWN_SUBMIT
DOWN_OUT_OF_RANGE:
    mov ax,440
DOWN_SUBMIT:
    mov row_init,ax
    jmp WWW
; ----------DOWN_STOP-----------


; ----------LEFT_START-----------
LEFT:
    triangle column_init,row_init,03h ;clear screen
    mov ax,column_init
    sub ax,4
    cmp ax,0
    jl LEFT_OUT_OF_RANGE ; signed <
    jmp LEFT_SUBMIT
LEFT_OUT_OF_RANGE:
    mov ax,0
LEFT_SUBMIT:
    mov column_init,ax
    jmp WWW
; ----------LEFT_STOP-----------



; ----------RIGHT_START-----------
RIGHT:
    triangle column_init,row_init,03h ;clear screen
    mov ax,column_init
    add ax,4
    cmp ax,600
    ja RIGHT_OUT_OF_RANGE
    jmp RIGHT_SUBMIT
RIGHT_OUT_OF_RANGE:
    mov ax,600
RIGHT_SUBMIT:
    mov column_init,ax
    jmp WWW
; ----------RIGHT_STOP-----------


; ----------CHANGE_COLOR_START-----------
CHGCOLOR:
    triangle column_init,row_init,03h ;clear screen
    mov ah,color
    cmp ah,15
    je COLOR_OUT_OF_RANGE
    inc ah
    jmp COLOR_SUBMIT
COLOR_OUT_OF_RANGE:
    mov ah,0
COLOR_SUBMIT:
    mov color,ah
    jmp WWW
; ----------CHANGE_COLOR_STOP-----------

; --------------------KEY_STOP--------------------

; ----------END_PROGRAM-----------
EXIT:    
    text_mode
    mov ax,4c00h
    int 21h
MAIN ENDP
END MAIN