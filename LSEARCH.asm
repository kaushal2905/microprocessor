.MODEL SMALL
.386
.DATA
ARRAY DB 50 DUP(?)
M1 DB 10,13,'ENTER THE SIZE OF ARRAY$'
M2 DB 10,13,'ENTER DIGIT$'
M3 DB 10,13,'ENTER THE KEY TO BE SEARCHED$'
M4 DB 10,13,'KEY FOUND :)$'
M5 DB 10,13,'KEY NOT FOUND :($'
M6 DB 10,13,'POSITION: $'
NUM DW 0H
KEY DW 0H
POS DW 0H
.CODE
.STARTUP

MOV AX,0H
MOV CX,0H
MOV DI,0H
MOV BX,0H

MOV AH,9
MOV DX,OFFSET M1
INT 21H

MOV AH,1
INT 21H
SUB AL,30H
MOV AH,0
MOV NUM,AX
MOV DI,0H
MOV CX,NUM

L1:MOV AH,9
 MOV DX,OFFSET M2
 INT 21H
 MOV AH,1
 INT 21H
 SUB AL,30H
 MOV ARRAY[DI],AL
 INC DI
 LOOP L1

MOV AH,9
MOV DX,OFFSET M3
INT 21H

MOV AH,1
INT 21H
SUB AL,30H

MOV AH,0
MOV KEY,AX
MOV CX,NUM
MOV DI,0
MOV DX,KEY
SEARCH:
MOV BL,ARRAY[DI]
MOV BH,0
CMP BX,DX

JE FOUND

INC DI
DEC CX
CMP CX,0
JNZ SEARCH
JMP NOTFOUND

FOUND:
 MOV AH,9
 MOV DX,OFFSET M4
 INT 21H
 MOV AX,BX
 CALL DISPH

MOV AH,9
MOV DX,OFFSET M6
INT 21H

MOV AX,CX
CALL DISPH
CALL q

NOTFOUND:MOV AH,9
 MOV DX,OFFSET M5
 INT 21H
 q:
.EXIT
DISPH PROC NEAR
 PUSH AX
 PUSH CX
 MOV CL,4
 MOV CH,4

DISPH1:
 ROL AX,CL
 PUSH EAX
 AND AL,0FH
 ADD AL,30H
 CMP AL,'9'
 JBE DISPH2
 ADD AL,7

DISPH2:
 MOV AH,2
 MOV DL,AL
 INT 21H
 POP EAX
 DEC CH
 JNZ DISPH1
 POP CX
 POP BX
 RET

DISPH  ENDP
   END
