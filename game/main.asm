include main.h
.MODEL SMALL

.DATA
row dw 200
pip_x dw 590
pipe_high dw 150
score dw 0
score_max dw 0
score_p db "Score:",3 dup(' '),'$'
score_max_p db "Max Score:",3 dup(' '),'$'
;;;; for print pipe
    x_sub_3 dw ?
    high_add_1 dw ?
    high_add_100 dw ?
    high_add_120 dw ?
    what_the_fuck dw ?
;;;;


;;;; for welcome page
welcome1 db '                                            '
welcome2 db '___________.__                              '
welcome3 db '\_   _____/|  | _____  ______ ______ ___.__.'
welcome4 db ' |    __)  |  | \__  \ \____ \\____ <   |  |'
welcome5 db ' |     \   |  |__/ __ \|  |_> >  |_> >___  |'
welcome6 db ' \___  /   |____(____  /   __/|   __// ____|'
welcome7 db '     \/              \/|__|   |__|   \/     '
welcome8 db '___.   .__           .___                   '
welcome9 db '\_ |__ |__|______  __| _/______             '
welcome10 db ' | __ \|  \_  __ \/ __ |/  ___/             '
welcome11 db ' | \_\ \  ||  | \/ /_/ |\___ \              '
welcome12 db ' |___  /__||__|  \____ /____  >             '
welcome13 db '     \/               \/    \/              '

welcome20 db '           Press w key to play!             '      
welcome21 db '        Press q key see how to play!        '      
welcome22 db '          Press a key to see about          '
welcome23 db '       Press esc key to exit the game       '
;;;;

;;;; for how to play
htp01 db "  ____  __ __  _____ ______      ____  ____     ___  _____ _____"
htp02 db " |    ||  |  |/ ___/|      |    |    \|    \   /  _]/ ___// ___/"
htp03 db " |__  ||  |  (   \_ |      |    |  o  )  D  ) /  [_(   \_(   \_ "
htp04 db " __|  ||  |  |\__  ||_|  |_|    |   _/|    / |    _]\__  |\__  |"
htp05 db "/  |  ||  :  |/  \ |  |  |      |  |  |    \ |   [_ /  \ |/  \ |"
htp06 db "\  `  ||     |\    |  |  |      |  |  |  .  \|     |\    |\    |"
htp07 db " \____j \__,_| \___|  |__|      |__|  |__|\_||_____| \___| \___|"
htp08 db "                                                                "
htp09 db "                 __    __      __  _    ___  __ __              "
htp10 db "                |  |__|  |    |  |/ ]  /  _]|  |  |             "
htp11 db "                |  |  |  |    |  \' /  /  [_ |  |  |             "
htp12 db "                |  |  |  |    |    \ |    _]|  ~  |             "
htp13 db "                |  `  '  |    |     \|   [_ |___, |             "
htp14 db "                 \      /     |  .  ||     ||     |             "
htp15 db "                  \_/\_/      |__|\_||_____||____/              "

htp20 db '                      Press any key to continue!                '
;;;;


;;;; for about
abo1 db '        Flappy birds in asm ver1.0                                  '
abo2 db '        This game is powered by NTUST EE Steven Yu and OOO          '
abo3 db '        Thank you for playing!                                      '
abo4 db '        Copyright (C) 2017 , Steven Yu  and  OOO                    '
;;;


;;;; for gg
gg1 db '                         _____    _____                        '
gg2 db '                        / ____|  / ____|                       '
gg3 db '                       | |  __  | |  __                        '
gg4 db '                       | | |_ | | | |_ |                       '
gg5 db '                       | |__| | | |__| |                       '
gg6 db '                        \_____|  \_____|                       '
gg10 db '                      Press r key to restart!                '
gg11 db '                      Press esc key to exit!                '

;;;;

.STACK 100H

.code
MAIN PROC
    mov ax,@DATA
    mov ds,ax
    draw_mode    ; into draw mode
    bg_color 00h ; set bg color = 03h 青綠色

START:
    clear_screen
    printstr13h welcome1,7,44,3,15
    printstr13h welcome2,7,44,4,15
    printstr13h welcome3,7,44,5,15
    printstr13h welcome4,7,44,6,15
    printstr13h welcome5,7,44,7,15
    printstr13h welcome6,7,44,8,15
    printstr13h welcome7,7,44,9,15
    printstr13h welcome8,7,44,10,15
    printstr13h welcome9,7,44,11,15
    printstr13h welcome10,7,44,12,15
    printstr13h welcome11,7,44,13,15
    printstr13h welcome12,7,44,14,15
    printstr13h welcome13,7,44,15,15
    
    printstr13h welcome20,7,44,20,15
    printstr13h welcome21,7,44,22,15
    printstr13h welcome22,7,44,24,15
    printstr13h welcome23,7,44,26,15

Wait_welcome:
    get_char
    cmp al,1bh  ; exit
    je EXIT
    cmp al,'w'  ;enter game
    je WWW
    cmp al,'q'  ;how to play
    je HOW_TO_PLAY
    cmp al,'a'
    je ABOUT    ; about
    jmp START


; ==========How to play=========
HOW_TO_PLAY:
    clear_screen
    printstr13h htp01,7,64,3,5
    printstr13h htp02,7,64,4,5
    printstr13h htp03,7,64,5,5
    printstr13h htp04,7,64,6,5
    printstr13h htp05,7,64,7,5
    printstr13h htp06,7,64,8,5
    printstr13h htp07,7,64,9,5
    printstr13h htp08,7,64,10,5
    printstr13h htp09,7,64,11,5
    printstr13h htp10,7,64,12,5
    printstr13h htp11,7,64,13,5
    printstr13h htp12,7,64,14,5
    printstr13h htp13,7,64,15,5
    printstr13h htp14,7,64,16,5
    printstr13h htp15,7,64,17,5

    printstr13h htp20,7,64,20,5
    get_char    
    jmp START
; ==========How to play=========

ABOUT:
    clear_screen
    printstr13h welcome1,7,44,3,15
    printstr13h welcome2,7,44,4,15
    printstr13h welcome3,7,44,5,15
    printstr13h welcome4,7,44,6,15
    printstr13h welcome5,7,44,7,15
    printstr13h welcome6,7,44,8,15
    printstr13h welcome7,7,44,9,15
    printstr13h welcome8,7,44,10,15
    printstr13h welcome9,7,44,11,15
    printstr13h welcome10,7,44,12,15
    printstr13h welcome11,7,44,13,15
    printstr13h welcome12,7,44,14,15
    printstr13h welcome13,7,44,15,15

    printstr13h abo1,7,68,18,5
    printstr13h abo2,7,68,19,5
    printstr13h abo3,7,68,20,5
    printstr13h abo4,7,68,21,5
    printstr13h htp20,7,64,25,5
    get_char    
    jmp START
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
    clear_screen
    printstr13h gg1,7,63,10,5
    printstr13h gg2,7,63,11,5
    printstr13h gg3,7,63,12,5
    printstr13h gg4,7,63,13,5
    printstr13h gg5,7,63,14,5
    printstr13h gg6,7,63,15,5
    printstr13h score_p,7,9,20,35
    mov ax,score
    cmp ax,score_max
    ja over_max
    jmp show_max
over_max:
    mov score_max,ax
show_max:
    call tranA
    printstr13h score_max_p,7,13,21,35
    printstr13h gg10,7,60,23,5
    printstr13h gg11,7,60,24,5
    get_char
    cmp al,'r'
    je RST
    cmp al,1bh ;esc
    je END_GAME
    jne show_max
END_GAME:
    text_mode
    mov ax,4c00h
    int 21h
eee:
    ret
RST:
    mov score,0
    mov row,200
    mov pip_x,590
    mov pipe_high,150
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

tranA proc
    mov di,offset score_max_p
    mov ax,score_max
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
	mov [di+10],al
	inc di
	loop dec2Ascll
	ret			
tranA endp	


END MAIN