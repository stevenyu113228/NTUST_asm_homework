; gcdlcm.asm
; By Taiwan Tech (NTUST) EE  B10507004 Steven Yu
; 2017/11/1
; [Euclidean algorithm in ASM, V 1.0]
; Copyright (C) 2017 , Steven Yu

; 輸入兩個十進位數字(兩位數字)
; input 2 integer 
; 輸出最大公因數與最小公倍數
; Output GCD and LCM

include gcdlcm.h
.model small    ; model small   
.stack 100h     ; stack 100h


.data                                       ; data
mes  db 'Please input 2 numbers (1~99)$'    ; Please...
GCD_iS db 'GCD is : $'                      ; string for 'GCD is :
LCM_is db 'LCM is : $'                      ; string for 'LCM is :
str_GCD db 8 dup(?),'$'                     ; output gcd string
str_LCM db 8 dup(?),'$'                     ; output lcm string
m    dw 0                                   ; input1  ___ GCD
n    dw 0                                   ; input2
s    dw 0                                   ; input1*input2
l    dw 0                                   ; LCM

.code                   ; code
main proc               ; main code
    mov ax,@data        ; put data address to ax
    mov ds,ax           ; mov ax to ds
    print_string mes    ; print hello
    new_line            ; new_line
    input_char m        ; input char m
    new_line            ; new_line
    input_char n        ; input char n
    new_line            ; new line
    a2i m               ; put m from ascii to int
    a2i n               ; put n from ascii to int
                        ; 到這邊 m , n 已經是真正的輸入值了
    find_s              ; 計算n*m
    
    euclidean_algorithm ; 輾轉相除法

    num2str m,str_GCD   ; number to string
    num2str l,str_LCM   ; number to string

    print_string GCD_iS ; pring GCD is :
    print_string str_GCD; print GCD value
    new_line            ; new line
    print_string LCM_is ; print LCM is:
    print_string str_LCM; print LCM value

    mov ah,4ch          ; back to dos
    int 21h             ; run


main endp               ; end program
end main