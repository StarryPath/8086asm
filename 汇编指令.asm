1、标志寄存器：
CF
SF
ZF
OF
PF
2、寻址方式
（1）立即寻址 MOV AH,10
（2）寄存器寻址 MOV  BX, AX	;双操作数指令中至少要有一个操作数使用寄存器寻址方式
（3）直接寻址   MOV  AX,[0078H] 
（4）寄存器间接寻址 MOV  AX,[BX] 
（5）寄存器相对寻址 MOV  AX, 8 [BX]
（6）基址变址寻址   MOV  AL, [BX] [SI]
（7）相对基址变址寻址 MOV  AL, ARY[BX] [SI]

3、数据传送指令：
（1）通用数据传送指令
MOV
XCHG  ;将两个操作数DEST与SRC的内容互换。不能在两个存储单元之间直接进行
XLAT  ;AL←(BX+AL) 将BX+AL指向字节单元中的值送AL
（2）堆栈操作指令
PUSH
POP
（3）标志寄存器传送指令
LAHF  ;(AH)←(PSW的低8位)
SAHF	;(AH)→(PSW的低8位)
PUSHF	; (SP)←(SP)-2       ,   ((SP)+1,(SP))←(PSW)
POPF	;(PSW)←((SP)+1,(SP)) ,(SP)←(SP)+2

（4）地址传送指令 
LEA    ;LEA  reg16，mem16  将源操作数所在单元的16位偏移量（mem16），送到16位寄存器（reg16）目的中
LDS   ;LDS reg16，mem32；reg16← (mem32)，DS ← (mem32+2)
LES	  ;LES reg16，mem32；reg16← (mem32), ES← (mem32+2)

（5）输入输出指令
IN	
		IN  AL,PORT    长格式字节操作
        IN  AX,PORT    长格式字操作
        IN  AL,DX      短格式字节操作
        IN  AX,DX      短格式字操作
OUT
	  OUT  PORT,AL    长格式字节操作
      OUT  PORT,AX    长格式字操作
      OUT  DX,AL       短格式字节操作
      OUT  DX,AX       短格式字操作

4、算数运算指令
（1）加法指令
add
ADC  DEST，SRC ;DEST←(DEST)+(SRC)+CF
INC  ;除不影响CF标志外，影响其它条件标志。

（2）减法指令
SUB
SBB DEST，SRC ;DEST←(DEST)－（SRC）－CF
DEC
NEG  DEST  ;DEST←0-(DEST)
对操作数所能表示的最小负数(例若操作数是8位则为－128)求补,原操作数不变,但OF被置1
当操作数为0时，清0 CF 。
对非0操作数求补后，置1 CF。
CMP
（3）乘法指令
MUL
IMUL
对MUL:若乘积的高半部分为0,则对CF和OF清0，否则置CF和OF为1。
对IMUL:若乘积的高半部分为低半部分的符号扩展，则对CF和OF清0,否则置CF和OF为1。

（4）除法指令
DIV ;无符号数除法
16／8位:AL←AX/（SRC）(商)，AH←AX/（SRC）(余数)
32／16位：AX←（DX，AX）/（SRC）(商)，
            DX←（DX，AX）/（SRC）(余数)
IDIV ;操作与DIV相同，但结果带符号。余数符号与被除数符号相同。

（5）符号扩展指令
CBW  ;将AL中的符号扩展到AH中。
CWD  ;将AX中的符号扩展到DX中。
（6）十进制调整指令
DAA ;对AL的值调整为正确的压缩BCD码。执行DAA前两个压缩型BCD码相加的结果已存于AL中。
					 若  (AL& 0FH)>9 或标志 AF=1
                     则  AL←AL+6,AF←1
                     若  AL>9FH或CF＝1
                     则  AL←AL+60H,CF←1

DAS ;压缩BCD码减法调整指令DAS,将AL中的结果，调整为正确压缩BCD码
				若(AL & 0FH)>9或AF=1 
                则AL←AL－6,AF←1
                若AL>9FH或CF=1 
                则AL←AL－60H,CF←1
AAA	;非压缩BCD码相加的结果已存于AL中,调整AL为正确的非压缩BCD码。
AAS ;将AL中的减结果，调整为正确非压缩BCD码。
AAM;将AL中的积值调整为非压缩BCD码并送回AX中。
;指令执行前必须先执行MUL指令，将两个非压缩BCD码相乘（此时要求其高四位为0），
;且积值保存在AL中。
AAD ;除法运算前，先对被除数AX的内容进行调整。(AL)←(AH)×0AH+(AL),(AH)←0
5、位操作指令
（1）逻辑运算指令
AND DEST,SRC  ;DEST←（DEST）与（SRC）
OR
NOT
XOR
TEST ;TEST  DEST,SRC  ；FLAGS←（DEST）与（SRC ）
（2）移位指令
SAL ;算术左移,最高位移入CF，最低位移入0
SHL ;逻辑左移,最高位移入CF，最低位移入0
SAR ;算术右移,最低位移入CF，最高位右移同时再填入最高位
SHR ;逻辑右移,最低位移入CF，最高位移入0 
ROL ;不带进位位的循环左移,最高位移入CF， 同时移回最低位
ROR ;不带进位位的循环右移
RCL ;  带进位位的循环左移,最高位移入CF， 原CF位移回最低位
RCR ;  带进位位的循环右移
6、字符串操作
当（DF）=0时，变址寄存器SI（和DI）的内容增加1、2或4 cld std
（1）LODS ;把指定主存单元的数据传送给AL或AX
		LODSB	;字节串读取：AL← DS : [SI]，
				;SI←SI±1
		LODSW	;字串读取：AL← DS : [SI]，
				;SI←SI±2
（2）STOS;把AL或AX数据传送至目的地址。
		STOSB	；字节串存储：ES:[DI]←AL，
			；DI←DI±1
		STOSW	；字串存储：ES:[DI]←AX，
			；DI←DI±2
（3）MOVS ;ES:[DI]←DS:[SI]
（4）CMPS;DS:[SI]－ES:[DI]
（5）SCAS;AL/AX－ES:[DI]
（6）REP;；每执行一次串指令，CX减1	；直到CX＝0，重复执行结束
（7）REPZ;；每执行一次串指令，CX减1	；并判断ZF是否为0，	；只要CX＝0或ZF＝0，重复执行结束
	REPNZ;；每执行一次串指令，CX减1	；并判断ZF是否为1，	；只要CX＝0或ZF＝1，重复执行结束
7、编程常用
DATA SEGMENT        
	db 64 dup(?)
    STRING1  DB  ' GOOD AFTERNOON $'
	sname 	  DB 20    ;0
      DB ?					;1
      DB 20 DUP(24H) 	;2-21
	  DB ?,?,'$'		;22-24
DATA ENDS
CODE SEGMENT
ASSUME  CS:CODE, DS:DATA
start:
	MOV   AX, DATA
    MOV   DS, AX
	.........
	.........
	MOV   AH, 4CH    ;结束程序
    INT   21H
CODE ENDS
end start
8、地址表达式
（1）HIGH和LOW运算符 ：选取表达式计算结果的高8位和低8位
（2）SEG  变量或标号 ：计算变量或标号的段地址
（3）OFFSET  
（4）TYPE变量或标号：计算变量或标号的类型值
		返回变量的一个数据项占用的字节数
		NEAR型标号返回－1，FAR型标号返回－2

（5）LENGTH  变量：对于使用DUP定义的变量，计算分配给该变量的单元数，其他变量的LENGTH值为1
（6）SIZE 变量：计算分配给该变量的字节数，SIZE=LENGTH*TYPE
注：BP默认段为SS
	DQ 4个字，DT 5个字、
	this label
	ORG 表达式 ;设置偏移地址
	EVEN伪指令使下一个变量或指令开始于偶数字节地址。 
	ALIGN伪指令使它后面的数据或指令从2的整数倍地址开始。其格式为：
	ALIGN  2n （n为任意整数）
	RADIX用来设置整数的默认进制
9、转移指令
（0）JMP
（1）有进位转移（JC）或无进位转移（JNC）
（2）等于/为零转移（JE/JZ）或不等于/非零转移（JNE/JNZ/）
（3）负数转移（JS）或正数转移（JNS）
（4）溢出转移（JO）或不溢出转移（JNO）
（5）偶校验转移（JP/JPE）或奇校验转移（JNP/JPO）
（6）寄存器CX为零转移（JCXZ） 
（1）高于转移(JA)/不低于且不等于转移（JNBE）
（2）高于或等于转移（JAE）/不低于转移（JNB）
（3）低于转移（JB）/不高于且不等于转移（JNAE）
（4）低于或等于转移（JBE）/不高于转移（JNA）
（1）大于转移（JG）/不小于且不等于转移（JNLE）
（2）大于或等于转移（JGE）/不小于转移（JNL）
（3）小于转移（JL）/不大于且不等于转移（JNGE）
（4）低于或等于转移（JLE）/不高于转移（JNG）
10、例：冒泡排序
data segment
	a db 3,1,5,-6,9,8,7
	n dw $-a
data ends
code segment
	assume cs:code,ds:data
start:mov ax,data
	mov ds,ax
	mov cx,n
	dec cx	
loop1:mov bx,0
	mov di,cx
loop2:mov al,a[bx]
	cmp al,a[bx+1]
	jle aa
	xchg al,a[bx+1]
aa:mov a[bx],al
	inc bx	
	loop loop2
	mov cx,di
	loop loop1
	mov ah,4ch
	int 21h	
code ends
	end start
11、子程序设计
	SUBT PROC NEAR
	……
    RET 
    SUBT ENDP
12、例：计算n的阶乘
data segment
	n db 3
	f dw ?
data ends
code segment
	assume cs:code,ds:data
start:	mov ax,data
	mov ds,ax		
	mov ah,0
	mov al,n
	call fac
	mov f,ax
	mov ah,4ch
	int 21h	
fac proc
	cmp ax,1
	jnz a1
	jmp a2
a1:	push ax
	dec al
	call fac
	pop cx
	mul cl
a2:	ret
fac endp
code ends
	end start
13、宏
（1）宏定义
macro_name   MACRO  [哑元表] ; 形参/虚参
                               [LOCAL 标号表]
    …… 
    ……              ; 宏定义体
       ENDM
（2）宏调用
macro_name [实元表]  
（3）操作符
符号1  &  符号2    ;宏展开时,合并前后两个符号形成一个符号。
;;  注释           宏展开时，;;后面的注释不予展开。
% 表达式     ;汇编程序将%后面的表达式转换为数字，并在展期间用这个数取代哑元。
14、中断
AH			功能			调用参数			                    返回参数
	　
01		键盘输入并回显	　						                  AL=输入字符
02		显示输出		DL=输出字符的ASCII码	　
09		显示字符串			DS:DX=串地址
							'$'结束字符串	　
0A		键盘输入到缓冲区	DS:DX=缓冲区首地址         (DS:DX+1)=实际输入的字符数，从(DS:DX+2)开始存放实际输入的字符串
						(DS:DX)=缓冲区最大字符数						



