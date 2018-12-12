DATA SEGMENT        
	db 64 dup(?)
    STRING1  DB  ' GOOD AFTERNOON $'
DATA ENDS
code segment
  assume cs:code ,ds:data
 start:
      mov cx,001ah	;循环26次
      mov bl,41h	;A->bl
      mov ah,02h
  a1: 
    mov dl,bl	;显示A
    int 21h
    inc bl	;B
	loop a1
	mov ah,02h			;回车换行
        mov dl,0dh
        int 21h
        mov dl,0ah
        int 21h	
	mov ah,09h			;输出字符串	
    mov dx,offset STRING1
    int 21h
	mov ax,4c00h
	int 21h
      code ends
  end start