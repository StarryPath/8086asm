DATA SEGMENT
BINNUM DW 4FFFH
ASCBCD DB 5 DUP(0),'$'
DATA ENDS
STACK SEGMENT
DB 200 DUP(?)
STACK ENDS
CODE SEGMENT 
ASSUME CS: CODE, DS: DATA, ES: DATA, SS: STACK
start: 
MOV AX, DATA
MOV DS, AX
MOV ES, AX
MOV CX, 5
XOR DX, DX
MOV AX, BINNUM
MOV BX, 10
MOV DI, OFFSET ASCBCD 
BINASC1: DIV BX
ADD DL, 30H
MOV [DI], DL
INC DI
AND AX, AX
JZ STOP
MOV DL, 0
LOOP BINASC1
STOP: 
mov ah,09h
lea dx,ASCBCD
int 21h


mov ax,4c00h

int 21h
CODE ENDS
 END  start