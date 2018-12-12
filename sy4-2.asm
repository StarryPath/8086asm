DATA SEGMENT        
	  str1 db 'input hours$'
	  str2 db 'input salary$'
	  
	  divisors        DW 10000, 1000, 100, 10, 1
	  results          DB 0,0,0,0,0,"$"        ;存放五位数ASCII码
DATA ENDS

CODE SEGMENT         

    ASSUME  CS:CODE, DS:DATA


START:

    MOV   AX, DATA

    MOV   DS, AX
	
	LEA DX,str1   ;提示输入工作时间
    MOV AH,9
    INT 21H
	
	MOV   AH, 1
    INT   21H        ;INPUT: '0' ~ '5' 取得ascii码为30H~35H
    AND   Ax, 000FH    ;AL = 0~6 取低四位
	push ax
	
go:	MOV   AH, 1
	INT   21H 
	
	mov bl,13
	cmp al,bl
	je  c1
	AND   Ax, 000FH
	pop bx
	push ax
	mov ax,10
	mul bx
	pop bx
	add ax,bx
	push ax
	jmp go
	
	
	
	
	
c1:	LEA DX,str2   ;提示输入工作时间
    MOV AH,9
    INT 21H
	
	
	MOV   AH, 1
    INT   21H        ;INPUT: '0' ~ '5' 取得ascii码为30H~35H
    AND   Ax, 000FH    ;AL = 0~6 取低四位
	push ax
	
go2:	MOV   AH, 1
	INT   21H 
	
	mov bl,13
	cmp al,bl
	je  c2
	AND   Ax, 000FH
	pop bx
	push ax
	mov ax,10
	mul bx
	pop bx
	add ax,bx
	push ax
	jmp go2
c2:	pop bx
	pop ax
	mul bx
	
		mov     si, offset divisors
        mov     di, offset results                    
        mov     cx,5  
aa:
        mov     dx,0           
        div     word ptr [si]   ;除法指令的被除数是隐含操作数，此处为dx:ax，商ax,余数dx
        add     al,48           ;商加上48即可得到相应数字的ASCII码
        mov     byte ptr [di],al       
        inc     di                               
        add     si,2                          
        mov     ax,dx                       
        loop    aa
        mov     cx,4   
        mov     di, offset results
bb:
        cmp     byte ptr [di],'0'   ;不输出前面的0字符   
        jne     print
        inc     di                          
        loop    bb
print:
        mov     dx,di                      
        mov     ah,9
        int     21h                   
	
	
	mov ax,4c00h

	int 21h
code ends

end start