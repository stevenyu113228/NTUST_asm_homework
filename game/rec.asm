include main.h
.MODEL SMALL

.data
.STACK 100H

.code
MAIN PROC
    mov ax,@DATA
    mov ds,ax

    draw_mode    ; into draw mode
    bg_color 03h ; set bg color = 03h 青綠色
    
    
    
    
EXIT:
    get_char
    text_mode
    mov ax,4c00h
    int 21h
MAIN ENDP
END MAIN