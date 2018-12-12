DATA SEGMENT        

    STRING1  DB  'Zhang yi  $',89

	len  EQU  $ - STRING1

    STRING2  DB  'Wang er   $',95

    STRING3  DB  'Li san    $',66

    STRING4  DB  'Zhao si   $',77

    STRING5  DB  'Liu wu    $',70

    STRING6  DB  'Chen liu  $',90
	num db 6  ;人数
	score db 89,95,66,77,70,90  ;分数
DATA ENDS



code segment
assume ds:data,cs:code
start:
		mov ax,data
        mov ds,ax
		mov cl,num
		mov ch,0
		mov bx,offset score
		call sort
		mov bx,offset STRING1+11
		mov si,offset score
		mov cx,6
		push cx
			
output:	
		mov al,	ds:[si]
		mov dl, ds:[bx]
		cmp al,dl
		je output2
		add bx,12
		
		loop output
		jmp done
output2:
		mov ah,09h			;输出字符串
		sub bx,11
        mov dx,bx
        int 21h
		pop cx
		dec cx
		jz done
		push cx
		mov cx,6
		mov bx,offset STRING1+11
		inc si
		jmp output
		
done:
       mov ax, 4c00h
       int   21h

sort proc
	push si 
	push ax 
	dec cx ;外层循环次数为数据个数减1 
	c1: ;排序的外层循环 
	push cx 
	mov si, bx 
	c2: ;排序的内层循环 
	mov al, [si] 
	cmp al, [si+1] 
	jbe noswap 
	mov ah, [si+1] 
	mov [si+1], al 
	mov [si], ah 
	noswap: inc si 
	loop c2 
	pop cx 
	loop c1 
	pop ax 
	pop si 
	ret 
sort endp

code ends
end start