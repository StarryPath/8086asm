starter      macro     sname
	    sname 	  DB 20    ;0
      DB ?					;1
      DB 20 DUP(24H) 	;2-21
	  DB ?,?,'$'		;22-24
	    endm
IO  macro  sname,score_1,score_2
LEA DX,STR1   ;提示输入姓名
    MOV AH,9
    INT 21H  
    MOV AH,10     ;输入姓名
    LEA DX,sname
    INT 21H
    LEA DX,CRLF    ;回车换行
    MOV AH,9
    INT 21H	
	LEA DX,STR2   ;提示输入分数
    MOV AH,9
    INT 21H	
	MOV AH,1     ;输入分数   
    INT 21H
	mov sname+22,al
	mov score_1,al
	MOV AH,1     ;输入分数   
    INT 21H
	mov sname+23,al
	mov score_2,al
    LEA DX,CRLF    ;回车换行
    MOV AH,9
    INT 21H
    LEA DX,sname+2	;输出姓名
    MOV AH,9
    INT 21H
	LEA DX,CRLF    ;回车换行
    MOV AH,9
    INT 21H
	LEA DX,sname+22	;输出分数
    MOV AH,9
    INT 21H
	LEA DX,CRLF    ;回车换行
    MOV AH,9
    INT 21H
endm
DATAS SEGMENT
STR1   DB 'Please input name:$'
STR2   DB 'Please input score:$'
starter    name1
starter    name2
starter    name3
starter    name4
starter    name5	  
num   db 5
score db 10 dup (?)	
CRLF  DB 0AH,0DH,'$'
DATAS ENDS
STACKS SEGMENT
       DB 200 DUP(?)
STACKS ENDS
CODES SEGMENT
    ASSUME CS:CODES,DS:DATAS,SS:STACKS
START:
    MOV AX,DATAS
    MOV DS,AX
	IO  name1,score+1,score
    IO  name2,score+3,score+2
    IO  name3,score+5,score+4
    IO  name4,score+7,score+6
    IO  name5,score+9,score+8
	mov cl,num
	mov ch,0
	mov bx,offset score
	call sort
    mov bx,offset name1+22
		mov si,offset score
		mov cx,5
		push cx			
output:	
		mov ax,	ds:[si]
		mov dh, ds:[bx]
		mov dl, ds:[bx+1]
		cmp ax,dx
		je output2
		add bx,25		
		loop output
		jmp done
output2:
		mov ah,09h			;输出字符串
		sub bx,20
        mov dx,bx
        int 21h
		LEA DX,CRLF    ;回车换行
		MOV AH,9
		INT 21H
		pop cx
		dec cx
		jz done
		push cx
		mov cx,5
		mov bx,offset name1+22
		add si,2
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
	mov ax, [si] 
	cmp ax, [si+2] 
	jbe noswap 
	mov dx, [si+2] 
	mov [si+2], ax 
	mov [si], dx 
	noswap: add si,2
	loop c2 
	pop cx 
	loop c1 
	pop ax 
	pop si 
	ret 
sort endp
CODES ENDS
    END START