.model small
.data
value1 dw 0ffffh
value2 dw 0003h
value3 dw 7fffh
value4 dw 8123h
.stack
.code
main proc
	mov ax,@data
	mov ds,ax
	mov ax,0
	add ax,value1
 	add ax,value1
	add ax,value2
	add ax,value3
	add ax,value4 
	
    mov bx,ax
    mov dx,ax      ;ax放在bx,dx備用


    ;第一位數
	and dx,0f000h  ;mask
 	mov cl,12      ;12放cl準備移位
	shr dx,cl      ;➡️移12格
	add dl,30h     ;+30h變成ASCII
	mov ah,02h     ;準備輸出
	int 21h        ;執行
	


    ;第二位數
	mov dx,bx
	and dx,0f00h
	mov cl,8       ;移動8格
	shr dx,cl
	add dl,30h
	mov ah,02h
	int 21h
	

    ;第三位數
	mov dx,bx
	and dx,00f0h
	mov cl,4       ;移動4格
	shr dx,cl
	add dl,30h
	mov ah,02h
	int 21h



    ;第四位數
    ;不需要右移
	mov dx,bx
	and dx,000fh
	add dl,30h
	mov ah,02h
	int 21h

	mov ax,4c00h    ;程式結束
	int 21h
main endp
end main