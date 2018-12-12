data segment 
	str1 db 'hello'
	len equ $-str1
	str2 db 'hello'
	match db 'MATCH$'
	nomatch db 'NO MATCH$'
data ends

code segment 
assume ds:data,cs:code
start:
	mov ax,data
	mov ds,ax
	mov es,ax
	mov cx,len
	mov di,offset str1
	mov si,offset str2
	repz cmpsb
	jz mat
    jnz nomat
mat:
	mov ah,09h
	mov dx,offset match
	int 21h
	jmp done
nomat:				
    mov ah,09h
    mov dx,offset nomatch
    int 21h
    jmp done	
	
done:        		
    mov ah,4ch
    int 21h
        
code ends
end start
	
	
	
	
	
	