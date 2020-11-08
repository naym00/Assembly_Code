; If You Enter A-Z then it will output 'Capital Letters.'
; If You Enter a-z then it will output 'Small Letters.'
; If You Enter 0-9 then it will output 'Digit.'
; And if you don't enter any of this then it will output 'Something Else.'
.MODEL SMALL 
.STACK 100H 
.DATA

ENTER DB 'Enter Something: $'
CAPITAL DB 'Capital Letters.$'
SMALL DB 'Small Letters.$'
DIGIT DB 'Digit.$'
SOMETHINGELSE DB 'Something Else.$'
 
.CODE 
MAIN PROC FAR
    
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, ENTER
    MOV AH, 9
    INT 21H
        
    MOV AH, 1
    INT 21H
    
    CMP AL, 'A'
    JGE START_CAPITAL
    STEP1:
    
    CMP AL, 'a'
    JGE START_SMALL
    STEP2:
    
    CMP AL, '0'
    JGE START_DIGIT
    STEP3:
    
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
    
    LEA DX, SOMETHINGELSE
    MOV AH, 9
    INT 21H
    JMP EXIT
    
    
    START_CAPITAL:
    CMP AL, 'Z'
    JLE END_CAPITAL
    JMP STEP1
    
    END_CAPITAL:
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
    
    LEA DX, CAPITAL
    MOV AH, 9
    INT 21H
    JMP EXIT
    
    START_SMALL:
    CMP AL, 'z'
    JLE END_SMALL
    JMP STEP2
    
    END_SMALL:
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
    
    LEA DX, SMALL
    MOV AH, 9
    INT 21H
    JMP EXIT
    
    START_DIGIT:
    CMP AL, '9'
    JLE END_DIGIT
    JMP STEP3
    
    END_DIGIT:
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
    
    LEA DX, DIGIT
    MOV AH, 9
    INT 21H
    JMP EXIT  
    
    EXIT:                                
    MOV AH, 4CH
    INT 21H 
  
    MAIN ENDP
END MAIN