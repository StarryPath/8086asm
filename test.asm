data segment
		tip1 db 'input a str$'
		tip2 db 'input a char$'
        str1 db 64
		db ?
		db 64 dup(?)
        len  equ $-str1			;获取str1的长度
     
        not_found db 'not found$'
		found db 'found$'
data ends

code segment
assume ds:data,cs:code
start:
        mov ax,data
        mov ds,ax
        mov es,ax
 
		mov ah,09h
        mov dx,offset tip1
        int 21h
		
		mov ah,02h			;回车换行
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
		
        mov ah,0ah			;输入字符串
        mov dx,offset str1
        int 21h
			
			
		
		
		mov ah,02h			;回车换行
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
		
        
		
		mov ah,09h
        mov dx,offset tip2
        int 21h
 
		mov ah,02h			;回车换行
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
		
        mov ah,01h			;输入字符
      
        int 21h
		
		mov ah,0
		push ax
 
		mov ah,02h			;回车换行
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h
		
		
		
		
		mov di,offset str1
		pop ax
        mov cx,len			;设置循环次数为str1的长度  
		CLD		
        repnz SCASB			
        jz match
        jmp nomch
		
		jmp done
        match:				
        mov ah,09h
        mov dx,offset found
        int 21h
        jmp done
 
        nomch:				
        mov ah,09h
        mov dx,offset not_found
        int 21h
        jmp done
 
       
        done:        		;返回操作系统
        mov ah,4ch
        int 21h
        
code ends
end start