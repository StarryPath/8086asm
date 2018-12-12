CHA MACRO  NUMB     ;宏名称以及参数

    LEA  DX, STRING1

    MOV  BL, NUMB   ;取参数

    MUL  BL

    ADD  DX, AX

    MOV  AH, 9

    INT  21H

ENDM               

DATA SEGMENT        

    STRING1  DB  'xin xi    $'

	len  EQU  $ - STRING1

    STRING2  DB  'yu yan    $'

    STRING3  DB  'ji suan ji$'

    STRING4  DB  'jing guan $'

    STRING5  DB  'shu xue   $'

    STRING6  DB  'ji xie    $'

DATA ENDS

CODE SEGMENT         

    ASSUME  CS:CODE, DS:DATA


START:

    MOV   AX, DATA

    MOV   DS, AX


    MOV   AH, 1

    INT   21H        ;INPUT: '0' ~ '5' 取得ascii码为30H~35H


    AND   AL, 0FH    ;AL = 0~6 取低四位


    CHA   len      ;宏调用


    MOV   AH, 4CH    ;结束程序

    INT   21H

CODE ENDS

    END   START
