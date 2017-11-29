; main.asm
; 2017/11/29
; mointer desplay
.model small
.data
color db 07h  ; 預設黑/深灰
.stack 1024h

.code
main proc
mov ax,@data
mov ds,ax
L1:     
	mov ah,10h         ;等待按鍵
	int 16h	
	cmp al,00h 	 ;是否為延伸鍵
	je CHECK_F1
	cmp al,1bh	 ;是否為ESC鍵
	je EXIT


    ; 寫入字元輸出及屬性 start
    mov ah,09h  ; 設定顯示文字
    mov dl,al   ; 設定char 內容
    mov bh,00h  ; 頁碼 0
    mov bl,color ; 顏色
    mov cx,02h  ; 重複次數
    int 10h
    ; 寫入字元輸出及屬性 stpo

	;得到游標位置 start
    mov ah,03h  ; 讀取目前游標的位置及大小
    mov bh,00h  ; 頁碼 0
    int 10h
        ;DH=游標的列座標 (row)
        ;DL=游標的行座標 (column)
    ;得到游標位置 stop

    ; 設定游標 start
    add dh,01h
    add dl,02h
    mov ah,02h
    int 10h
    ; 設定游標 stop
	jmp L1


CHECK_F1:                 ;F1鍵是否按下
 	cmp  ah,3Bh
  	jnz  CHECK_F2
  	call CHANGE_CURSOR
  	jmp  L1

CHECK_F2:                 ;F2鍵是否按下
  	cmp  ah,3Ch
  	jnz  CHECK_F3  
  	call CHANGE_BACKCOLOR
  	jmp  L1  


CHECK_F3:                 ;F3鍵是否按下
  	cmp  ah,3Dh
  	jne  L1    
  	call CHANGE_CHCOLOR
  	jmp  L1


EXIT:
	mov ax,4c00h
	int 21h

main endp

CHANGE_CURSOR proc
    mov ah,03h  ; 讀取目前游標的位置及大小
    mov bh,00h  ; 頁碼 0
    int 10h
        ;CH=頂線
        ;CL=底線
    cmp ch,0 ; 確認ch是否超越邊界ㄌ
    jna OUT_OF_RANGE
    sub ch,1
    jmp SET_CURSOR
OUT_OF_RANGE:
    mov ch,06h ;重設頂線
    jmp SET_CURSOR
SET_CURSOR:
    mov ah,01h
    int 10h
    ret
CHANGE_CURSOR endp



CHANGE_BACKCOLOR proc
    mov ah,color ; load color
    and ah,0f0h  ; masking
    cmp ah,0f0h  ;
    je OUT_OF_RANGE ;if color of back = 0fh
    add ah,10h   ; bg color ++
    jmp SET_BGCOLOR
OUT_OF_RANGE:
    mov ah,00h   ; set to 0
    jmp SET_BGCOLOR
SET_BGCOLOR:
    and color,0fh  ; masking
    or  color,ah   ; set bg color
    ret
CHANGE_BACKCOLOR endp



CHANGE_CHCOLOR proc
    mov ah,color ; load color
    and ah,0fh   ; masking
    cmp ah,0fh
    je OUT_OF_RANGE ; if color of char = 0fh 
    add ah,01h
    jmp SET_CHCOLOR
OUT_OF_RANGE:
    mov ah,00h    ; set to 0
    jmp SET_CHCOLOR
SET_CHCOLOR:
    and color,0f0h ; masking  
    or  color,ah   ; set char color
    ret
CHANGE_CHCOLOR endp
end main