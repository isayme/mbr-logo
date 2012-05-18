	org		07c00h
	mov		ax,	cs
	mov		ds,	ax
	mov		es, ax
	mov     ss, ax
	mov     sp, 0f00h

	call	ClrScreen   ;«Â∆¡
    call    SetScreen
    call    copy

    mov     ax, 08000h
    mov     ds, ax
    mov     dx, 0 
LOOP:     
    mov     si, 0
    mov     ax, 193
    mov     bx, 0
    add     dx, 1

AGAIN:
    mov     cx, [si]
    mov     cl, ch
    mov     ch, 0
REPEAT:
    push    ax
    push    bx
    mov     ax, [si]
    cmp     al, 0f0h
    jnbe     J_NN
    push    dx
    jmp     J_N
J_NN:    
    push    ax
J_N:
    call    DrawPix
    pop     ax
    pop     bx
    pop     ax

    add     bx, 1
    cmp     bx, 320
    jnz     NEWLINE
    sub     ax, 1
    ;cmp     ax, 6
    ;jz      TEND
    mov     bx, 0   
NEWLINE:
    loop    REPEAT
    
    add     si, 2
    ;cmp     ax, 6
    cmp     si, 1d26h
    jnz     AGAIN
TEND:
    call    delay_50
    jmp     LOOP
	jmp		$

logo:
SetScreen:
    mov     ax, 0013h
    int     10h
    ret
	
DrawPix:
    push    ax
    push    bx
    push    cx
    push    dx
    push    bp
    
    mov     bp, sp
    mov     dx, [bp + 16]
    mov     cx, [bp + 14]
    mov     ax, [bp + 12]

    mov     bh, 0
    mov     ah, 0ch
    int     10h
    
    pop     bp
    pop     dx
    pop     cx 
    pop     bx
    pop     ax 
    ret
    
copy:
    push    ax
    push    bx
    push    cx
    push    dx
    push    bp
    
    
    mov     ax, 08000h
    mov     es, ax
    mov     ax, 020fh
    mov     bx, 00h
    mov     cx, 0002h
    mov     dx, 00h
    int     13h
    
    pop     bp
    pop     dx
    pop     cx 
    pop     bx
    pop     ax 
    ret
            	
delay_50:
    push    ax
    push    bx
    push    cx
    push    dx
    
    mov     bl, 50     ;—” ±50ms
delay_5:	
    
    mov     ah, 0
    int     01ah   
    mov     ax, dx 
delay_1:               ;—” ±10ms
    push    ax
    mov     ah, 0
    int     01ah 
    pop     ax
    cmp     ax, dx
    jz      delay_1
    
    sub     bl, 1
    jnz     delay_5
	
    pop     dx
    pop     cx 
    pop     bx
    pop     ax 
	ret
    
ClrScreen:
    mov     ah, 06h 
    mov     al, 00h
    mov     bh, 07h
    mov     ch, 00d
    mov     cl, 00d
    mov     dh, 24d
    mov     dl, 79d
    int     10h
    mov     ah, 02h
    mov     bh, 00h
    mov     dh, 00h
    mov     dl, 00h
    int     10h
    ret
            
    times	510 - ($ - $$)	db	0
    dw		0xaa55