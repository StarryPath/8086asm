data segment
str1 	  DB 20    ;0
      DB ?					;1
      DB 20 DUP(24H) 	;2-21
	  DB ?,?,'$'		;22-24
X1	db	48
X2	db	48
X3	db	48
CRLF  DB 0AH,0DH,'$'
data ends
code segment
assume cs:code, ds:data
start:
	mov ax,data
	mov ds,ax
	lea bx,str1	;定位首个字符
	
	mov ah,10
	mov dx,offset str1
	int 21h
	LEA DX,CRLF    ;回车换行
    MOV AH,9
    INT 21H
	lea si,str1
	mov  cl,[si+1]
	mov ch,0
lop:	
	mov al,[bx]
cmp al,'a'
	jb next1
	cmp al,'z'
	ja next1	
	inc X1		;小于a大于z则跳到下一项，否则X1+1
	jmp exit
next1:
	cmp al,'A'
	jb next2
	cmp al,'Z'
	ja next2
	inc X1		;小于A大于Z则跳到下一项，否则X2+1
	jmp exit
next2:
	cmp al,'0'
	jb next3
	cmp al,'9'
	ja next3
	inc X2		;小于0大于9则跳到下一项，否则X3+1
	jmp exit
next3:
	inc X3		;剩下就是其它字符了，X4+1
exit:
	inc bx
	loop lop	;循环
	mov ah,02h
	mov dl,X1
	int 21h
	LEA DX,CRLF    ;回车换行
    MOV AH,9
    INT 21H
	mov ah,02h
	mov dl,X2
	int 21h
	LEA DX,CRLF    ;回车换行
    MOV AH,9
    INT 21H
	mov ah,02h
	mov dl,X3
	int 21h
	LEA DX,CRLF    ;回车换行
    MOV AH,9
    INT 21H
	
	mov ax,4c00h
	int 21h
code ends
end start
