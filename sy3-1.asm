DATA SEGMENT        
	num db 10  ;人数
	score db 89,95,66,77,70,90,50,85,63,100  ;分数
	num1 db 48 ;90-100
	num2 db 48	;80-89
	num3 db 48	;70-79	
	num4 db 48	;60-69
	num5 db 48	;0-59 
DATA ENDS
code segment
assume ds:data,cs:code
start:
		mov ax,data
        mov ds,ax
		mov cl,num
		mov ch,0
		mov bx,offset score
		call tj
		mov ah,02h
		mov dl,num1
		int 21h
		mov ah,02h
		mov dl,num2
		int 21h
		mov ah,02h
		mov dl,num3
		int 21h
		mov ah,02h
		mov dl,num4
		int 21h
		mov ah,02h
		mov dl,num5
		int 21h
		mov ax, 4c00h
        int   21h
tj proc
	push si 
	push ax 
	
c1: 
	
	mov si, bx 
c2: 
	mov al, [si]
	mov ah, 90
	cmp al, ah
	jae n1_add 
	mov ah,80
	cmp al, ah
	jae n2_add
	mov ah,70
	cmp al, ah
	jae n3_add 
	mov ah,60
	cmp al, ah
	jae n4_add
	jmp n5_add
n1_add:
	mov bl, num1
	inc bl
	mov num1,bl
	jmp add_done
n2_add:
	mov bl, num2
	inc bl
	mov num2,bl
	jmp add_done
n3_add:
	mov bl, num3
	inc bl
	mov num3,bl
	jmp add_done
n4_add:
	mov bl, num4
	inc bl
	mov num4,bl
	jmp add_done
n5_add:
	mov bl, num5
	inc bl
	mov num5,bl
	jmp add_done
	
add_done:
	inc si
	loop c2 
	pop ax 
	pop si 
	ret 
tj endp

code ends
end start

