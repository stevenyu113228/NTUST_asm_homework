; addarr.asm
; By Taiwan Tech (NTUST) EE  B10507004 Steven Yu
; 2017/11/14
; Copyright (C) 2017 , Steven Yu

.model small    ; model small   
.stack 100h     ; stack 100h


.data                              
arr dw 1,2,3,4,5,6,7,8,9

.code                   ; code
main proc               ; main code
    mov ax,@data        ; put data address to ax
    mov ds,ax           ; mov ax to ds
    mov ax,lengthof arr 
    push ax             ; push length of array to stack
    mov ax,offset arr
    push ax             ; push arr offset address to stack
    call addarr         ; call 副程式

    mov ah,4ch          ; back to dos
    int 21h             ; run


main endp               ; end program


addarr proc
push bp                 ; backup bp
mov bp,sp
add sp,0FFF0H           ; 保留local var space

mov bx,[bp+4]
mov dx,[bp+6]
mov ax,2
dec dx                  ; array address is from 0 ~ length-1
mul dx                  ; array is 'word' (double bytes)
mov cx,ax
xor ax,ax               ; clear ax
L1:
    mov si,cx
    add ax,[bx][si]     ;add ax,arr[index*2](bx+si) , because word
    sub cx,02h
    cmp cx,0
    jge L1 ;有號數>=

mov sp,bp               ; restore sp
pop bp                  ; restore bp
ret 4                   ; remove 2 arguments
addarr endp




end main