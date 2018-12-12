CHA MACRO  NUMB     ;宏名称以及参数

    LEA  DX, STRING1

    MOV  BL, NUMB   ;取参数
	dec  al
    MUL  BL

    ADD  DX, AX

    MOV  AH, 9

    INT  21H

ENDM               

DATA SEGMENT        

    STRING1   DB  ' Janurary $'

	len  EQU  $ - STRING1

    STRING2   DB  'February  $'
              
    STRING3   DB  'March     $'
              
    STRING4   DB  'April     $'
              
    STRING5   DB  'May       $'
              
    STRING6   DB  'June      $'
	STRING7   DB  'July      $'
	STRING8   DB  'August    $'
	STRING9   DB  'September $'
	STRING10  DB  'October   $'
	STRING11  DB  'November  $'
	STRING12  DB  'December  $'
	
	
DATA ENDS

CODE SEGMENT         

    ASSUME  CS:CODE, DS:DATA


START:

    MOV   AX, DATA

    MOV   DS, AX


    MOV   AH, 1

    INT   21H        ;INPUT: '0' ~ '5' 取得ascii码为30H~35H


    AND   Ax, 000FH    ;AL = 0~6 取低四位
	
	push ax
	
	
	MOV   AH, 1

    INT   21H        ;INPUT: '0' ~ '5' 取得ascii码为30H~35H
	mov bl,13
	cmp al,bl
	
	je  c1
	
	AND   Ax, 000FH    ;AL = 0~6 取低四位
	
	add ax,10
	jmp cha1
	
	
	
	
c1:
	pop ax

cha1:	
	CHA   len      ;宏调用


    MOV   AH, 4CH    ;结束程序

    INT   21H

CODE ENDS

    END   START
