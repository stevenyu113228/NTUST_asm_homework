pChar	macro	para1
	push    ax 	        
	push	dx		
        mov   	dl,para1	
       	mov     ah,02h		
       	int     21h		
       	pop	dx		
       	pop     ax		
       	endm 

pString	macro	para1
	push    ax 	        
	push	dx		
        mov   	dx,offset para1	
       	mov     ah,09h		
       	int     21h		
       	pop	dx		
       	pop     ax		
       	endm 