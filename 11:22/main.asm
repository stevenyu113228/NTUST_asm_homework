.model small
.data
.stack 100h
.code
main proc
    mov ax,@data
    mov ds,ax
L1:
    mov dl,2Eh ; output .
    mov ah,02h
    int 21h
    mov cx,32
L2:
    push cx
    mov cx,0ffffh
L3:
    call CheckKeyboard
    loop L3
    pop cx
    loop L2
    jmp L1

    mov ah,4ch
    int 21h
main endp

CheckKeyboard proc
    push ax
    mov ah,11h
    int 16h
    jz quit
    mov ah,10h
    int 16h
    cmp al,1bh
    je quit1
    cmp al,0E0h
    je w
    jmp char
w:
    cmp ah,48h
    je up
    cmp ah,50h
    je down
    cmp ah,4Bh
    je left
    cmp ah,4Dh
    je right

up:
    mov dl,75h ; u
    mov ah,02h
    int 21h
    jmp quit
down:
    mov dl,64h ; d
    mov ah,02h
    int 21h
    jmp quit
left:
    mov dl,6Ch ; l
    mov ah,02h
    int 21h
    jmp quit
right:
    mov dl,72h ; r
    mov ah,02h
    int 21h
    jmp quit
char:
    mov dl,al  ; print char
    mov ah,02h
    int 21h
    jmp quit
quit1:
    mov ah,4ch
    int 21h
quit:
    pop ax
    ret
CheckKeyboard endp
end main