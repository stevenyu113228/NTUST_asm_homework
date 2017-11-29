; gcdlcm.h
; Library file 
; By Taiwan Tech (NTUST) EE  B10507004 Steven Yu
; 2017/11/1
; [Euclidean algorithm in ASM, V 1.0]
; Copyright (C) 2017 , Steven Yu

;=====print_string=====
print_string macro par  ; print string
    push ax             ; backup ax
    push dx             ; backup dx
    mov dx,offset par   ; put par 's offset address to dx
    mov ah,09h          ; prepare to print string
    int 21h             ; print string
    pop dx              ; restore dx
    pop ax              ; restore ax
    endm
;=====print_string=====


;=====print_char=====
print_char macro par    ; print char
    push ax             ; backup ax
    push dx             ; backup dx
    xor dx,dx           ; clear dx
    mov dl,par          ; put char to dl
    mov ah,02h          ; prepare to print
    int 21h             ; print
    pop dx              ; restore dx
    pop ax              ; restore ax
    endm
;=====print_char=====

;=====new_line=====
new_line macro      ; n ew line
    push ax         ; backup ax
    push dx         ; backup dx
    mov dl,0dh      ; mov CR to dl
    mov ah,02h      ; prepare to run
    int 21h         ; run
    mov dl,0ah      ; mov LF to dl
    mov ah,02h      ; prepare to run
    int 21h         ; run   
    pop dx          ; restore dx
    pop ax          ; restore ax
    endm
;=====new_line=====

;=====get_key=====
get_key macro       ; get key
    push bx         ; backup bx
    push ax         ; backup ax
    mov ah,00h      ; read keyboard command
    int 16h         ; read keyboard (東西會讀在al) 不過ah會被寫怪怪數字
    pop bx          ; 把原本ax東西放在bx
    mov ah,bh       ; 把新的ah怪怪數字刷回舊的ah
    pop bx          ; restore bx
    endm

;=====a2i=====
a2i macro par       ; ascii to int
    push ax         ; backup ax
    push bx         ; backup bx
    mov bx,par      ; put Ram中的word to bx
    mov al,0Ah      ; 十位數*10
    sub bx,3030h    ; ascii to int
    mul bh          ; 十位數*10 (ax=al*bh)
    xor bh,bh       ; clear old bh
    add bx,ax       ; 十位數*10加回個位數
    mov par,bx      ; put bx back to Ram 中
    pop bx          ; restore bx
    pop ax          ; restore ax
    endm
;=====a2i=====


;=====input_char=====
input_char macro par        ; key in the char
    Local input1,input1_1,store1,end1   ; local label
    push ax                 ; backup ax
    push bx                 ; backup bx
    push cx                 ; backup cx
    xor ax,ax               ; clear ax
    xor bx,bx               ; clear bx
    xor cx,cx               ; clear cx
    jmp input1              ; go to input
    input1:                 ; input1
        get_key             ; get key to al
        print_char al       ; print the key (al)
        jmp input1_1        ; go to get second num

    input1_1:               ; get second num
        mov cl,08h          ; shift first number left 8bit
        shl ax,cl           ; because first is 十位數
        get_key             ; get second number
        cmp al,0Dh          ; if (press enter)
        je store1           ;   go to save number
                            ; else    
        print_char al       ;   print the number
        mov par,ax          ;   mov whole number to RAM
        jmp end1            ;   go to prepare input second int

    store1:
        shr ax,cl           ; Because press Enter so 第一位數其實是個位數，移回原位
        mov ah,30h          ; mov 十位數等於ascii的30 (0)
        mov par,ax          ; mov 完整的數字 to RAM
        jmp end1            ; 進入輸入第n個字

    end1:
        pop cx              ; restore cx
        pop bx              ; restore bx
        pop ax              ; restore ax
    endm                    
;=====input_char=====

;=====find_s=====
; s = m*n
find_s macro    ; calculate s
    push ax     ; backup ax
    push bx     ; backup bx
    mov ax,m    ; put m from ram to ax
    mov bx,n    ; put n from ram to bx
    mul bl      ; ax = al * bl 
    mov s,ax    ; put ax to ram (s)
    pop bx      ; restore bx
    pop ax      ; restore ax
    endm
;=====find_s=====


;=====euclidean_algorithm=====
;輾轉相除法的英文叫做euclidean_algorithm (歐幾里德法)
euclidean_algorithm macro   ; 輾轉相除法
    Local Loop1             ; local label
    push ax                 ; backup ax
    push bx                 ; backup bx
    push cx                 ; backup cx
    push dx                 ; backup dx
    Loop1:                  ; like a while loop while(ax!=0)
        xor dx,dx           ; clean up dx
        mov ax,m            ; mov m to ax
        mov bx,n            ; mov n to bx
        mov m,bx            ; mov bx to m  (m = n)
        div bx              ; (dx ax) / bx = ax...dx
        mov ax,dx           ; mov dx(餘數) to ax
        mov n,ax            ; mov ax(餘數) to n
        cmp ax,0            ; if(n!=0)
        jne Loop1           ;   then jump back to loop1

                            ; 計算l(LCM) = s/m
    mov ax,s                ; mov s to ax
    mov bx,m                ; mov m to bx
    xor dx,dx               ; clear dx
    div bx                  ; (dx ax) / bx = ax ...dx
    mov l,ax                ; mov ax(商) to l 

    pop dx                  ; restore dx
    pop cx                  ; restore cx
    pop bx                  ; restore bx
    pop ax                  ; restore ax
    endm
;=====euclidean_algorithm=====


;=====num2str=====
num2str macro num,p_str         ; number to string
    Local get_char,put_string   ; local label
    push ax                     ; backup ax
    push bx                     ; backup bx
    push cx                     ; backup cx
    push dx                     ; backup dx
    mov ax,num                  ; mov num to ax 準備要轉輸出字串的數字
    mov bx,0ah                  ; mov 0Ah (10) to bx 十進位 每次除以 10
    xor cx,cx                   ; clear cx 計數器清空

    get_char:                   ; 拆字
        xor dx,dx               ; clear dx
        div bx                  ; (dx ax) / bx = ax ... dx
        push dx                 ; 堆疊 dx
        inc cx                  ; cx counter ++
        cmp ax,0                ; if (ax > 0)  // 還沒除完
        ja get_char             ;   then jmp to get_char
                                ; else     //把每個字都拆開塞去堆疊ㄌ
        mov si,offset p_str     ; mov p_str ㄉ offset address to si
        jmp put_string          ; jmp to put_strint

    put_string:                 ; 把堆疊裡面的字拉出來塞進string
        pop dx                  ; 取出堆疊ㄉ值 放dx
        add dl,30h              ; 純數字 + 30h = ascii 數字
        mov [si],dl             ; 前面有 mov 過 offset p_str address to si
        inc si                  ; si++ (找下一個字元)
        loop put_string         ; 迴圈直到 cx = 0
    
    pop dx                      ; restore dx
    pop cx                      ; restore cx
    pop bx                      ; restore bx
    pop ax                      ; restore ax
    endm

;============= macro end =============