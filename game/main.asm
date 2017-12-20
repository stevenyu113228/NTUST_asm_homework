
include main.h
.MODEL SMALL

.DATA
row dw 200
pip_x dw 590
pipe_high dw 150
score dw 0
score_p db "Score:",3 dup(' '),'$'
aaaaa db '幹$'

;;;; for print pipe
    x_sub_3 dw ?
    high_add_1 dw ?
    high_add_100 dw ?
    high_add_120 dw ?
    what_the_fuck dw ?
;;;;
.STACK 100H

.code
MAIN PROC
    mov ax,@DATA
    mov ds,ax

    draw_mode    ; into draw mode
    bg_color 00h ; set bg color = 03h 青綠色

; ==========MAIN LOOP========
WWW:
    clear_screen
    call tran
    printstr13h score_p,7,9,3,0
    rectangle 40,row,15,15  ; column is 50 ;this is bird
    call pipe               ; show pipe
    call check_hit
    ;call Delay
    wait_key
    jnz KEY_PROCESS         ; if key pressed

bird_down:
    mov ax,row
    add ax,3
    mov row,ax

pipe_left:
    mov ax,pip_x
    sub ax,5
    cmp ax,5
    jng pipe_over ; !> (到邊界)
    jmp pipe_continue
pipe_over:
    get_rand    ;rand is at dl
    mov bx,100
    xor dh,dh
    add bx,dx   ;add rand(0~100)*2
    add bx,dx

    mov ax,score    ;過ㄌ一個
    inc ax          ;加分
    mov score,ax

    mov ax,590
    mov pipe_high,bx
pipe_continue:
    mov pip_x,ax
    jmp WWW

bird_ground:
    call check_hit

KEY_PROCESS:
    get_char    ; clear buffer
    cmp al,1bh	 ;是否為ESC鍵
	je EXIT
    cmp al,'w'  ; up row - 4
    je UP
    jmp WWW
; ==========MAIN LOOP========



; --------------------KEY_START--------------------

; ----------UP_START-----------
UP:
    mov ax,row
    sub ax,40
    cmp ax,0
    jl UP_OUT_OF_RANGE  ; signed <
    jmp UP_SUBMIT
UP_OUT_OF_RANGE:
    mov ax,0
UP_SUBMIT:
    mov row,ax
    jmp WWW
; ----------UP_STOP-----------

; --------------------KEY_STOP--------------------

; ----------END_PROGRAM-----------
EXIT:    
    text_mode
    mov ax,4c00h
    int 21h
MAIN ENDP




Delay proc	
	mov cx,0ffffh
 L1:
	push cx
	mov cx,0ffffh
 L2:
	loop L2
	pop cx
	loop L1
	ret
Delay	endp


pipe proc
    mov ax,pip_x
    sub ax,3
    mov x_sub_3,ax
    mov ax,pipe_high
    add ax,1
    mov high_add_1,ax
    add ax,99
    mov high_add_100,ax
    add ax,20
    mov high_add_120,ax
    mov cx,480
    sub cx,high_add_120
    mov what_the_fuck,cx
    h_rectangle pip_x,0,50,pipe_high,2
    h_rectangle x_sub_3,high_add_1,56,20,2 ;上半部ㄉ
    h_rectangle x_sub_3,high_add_100,56,20,2
    h_rectangle pip_x,high_add_120,50,what_the_fuck,2
    ret
pipe endp

check_hit proc
    ;rectangle at row,40
    cmp row,480
    jae GAME_OVER ;撞到地板
    cmp pip_x,55
    ja eee  ;管子在不正確ㄉ地方

    mov ax,pipe_high 
    cmp row,ax          ;撞到上面ㄉ
    jbe GAME_OVER

    mov ax,high_add_100 ;撞到下面ㄉ
    cmp row,ax
    jae GAME_OVER

    jmp eee
    

GAME_OVER:
    text_mode
    mov ax,4c00h
    int 21h
eee:
    ret
check_hit endp



tran proc
    mov di,offset score_p
    mov ax,score
	mov cx,0
Hex2Dec:
	inc cx
	mov bx,10
	mov dx,0
	div bx
	push dx
	cmp ax,0
	jne Hex2Dec	
dec2Ascll:
	pop ax
	add al,30h
	mov [di+6],al
	inc di
	loop dec2Ascll
	ret			
tran endp	


END MAIN