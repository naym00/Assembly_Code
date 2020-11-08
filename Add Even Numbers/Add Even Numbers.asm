; 16 bit Program
;2+4+6+8+10+..........+nth=?
.MODEL SMALL 
.STACK 100H 
.DATA
ENTER DB 'Enter nth number: $'
RESULT DB 'Result is: $'
.CODE 
MAIN PROC FAR
    
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, ENTER
    MOV AH, 9
    INT 21H
                                
    MOV DX, 0
    INPUT:
    MOV AH, 1
    INT 21H
    CMP AL, 13
    JE DONE
    SUB AL, '0'
    MUL AH       
    MOV CX, AX     
    MOV AX, DX     
    MOV BX, 10
    MUL BX         
    ADD CX, AX
    MOV DX, CX
    JMP INPUT
    DONE:
    ;NUMBER IN DX
    MOV CX, DX
    
    
    MOV AH, 2
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    MOV AH, 2
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
    
    LEA DX, RESULT
    MOV AH, 9
    INT 21H
    
    ;Store Your Number in CX
    MOV AX, 0
    SUMEVEN:
    MOV DX, 1B
    AND DX, CX
    CMP DX, 0
    JE SUM
    JMP NEXTPROCEDURE
    SUM:
    ADD AX, CX
    NEXTPROCEDURE:
    LOOP SUMEVEN
    ;Total Number in AX
    
    
    ;Number Have to stored in AX              
    ;Initilize Count 
    MOV CX, 0 
    MOV DX, 0 
    LABEL: 
    CMP AX, 0 
    JE PRINT            
    MOV BX, 10
    DIV BX    
    PUSH DX 
    INC CX
    XOR DX, DX
    JMP LABEL 
    PRINT:  
    CMP CX, 0
    JE EXIT 
    POP DX
    ADD DX, 48 
    MOV AH, 2
    INT 21H 
    DEC CX
    JMP PRINT
    
    EXIT:                                
    MOV AH, 4CH
    INT 21H 
  
    MAIN ENDP
END MAIN