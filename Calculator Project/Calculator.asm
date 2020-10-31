.MODEL SMALL 
.STACK 100H 
.DATA
ADDITION_STRING       DB 'ENTER + to add.$'
SUBTRACTION_STRING    DB 'ENTER - to subtract.$'
MULTIPLICATION_STRING DB 'ENTER * to multiply.$'
DIVISION_STRING       DB 'ENTER / to divide.$'
POWER_STRING          DB 'ENTER ^ to power.$'
RESET_STRING          DB 'ENTER r to reset.$'
EXIT_STRING           DB 'ENTER e to exit.$'

ENTERSIGN DB 'ENTER Sign: $'

FIRSTNUMBER DB 'Enter the First Number: $'
SECONDNUMBER DB 'Enter the Second Number: $'


NUMBER1 DB ?
NUMBER2 DB ?
RESULT DB ?

UPPERLOOP DB ?
INNERLOOP DB ?

 
.CODE 
MAIN PROC FAR
    
    MOV AX, @DATA
    MOV DS, AX
    
    LEA DX, ADDITION_STRING
    MOV AH, 9
    INT 21H
    CALL NEWLINE      
    LEA DX, SUBTRACTION_STRING
    MOV AH, 9
    INT 21H
    CALL NEWLINE   
    LEA DX, MULTIPLICATION_STRING
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    LEA DX, DIVISION_STRING
    MOV AH, 9
    INT 21H
    CALL NEWLINE      
    LEA DX, POWER_STRING
    MOV AH, 9
    INT 21H
    CALL NEWLINE          
    LEA DX, RESET_STRING
    MOV AH, 9
    INT 21H
    CALL NEWLINE          
    LEA DX, EXIT_STRING
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    CALL NEWLINE
    
     
    
    MOV UPPERLOOP, 0
    UPLOOP:
    
    CALL INPUTFORMALITIES
    
    MOV INNERLOOP, 0
    INLOOP:
    CALL CALCULATIONS
    CMP INNERLOOP, 0
    JE INLOOP
    
    CMP UPPERLOOP, 0
    JE UPLOOP 
    
    EXIT:                                
    MOV AH, 4CH
    INT 21H 
  
    MAIN ENDP


INPUTFORMALITIES PROC              
    LEA DX, FIRSTNUMBER
    MOV AH, 9
    INT 21H
    CALL TAKENUMBER
    MOV NUMBER1, DL
    CALL NEWLINE
    
    LEA DX, SECONDNUMBER
    MOV AH, 9
    INT 21H
    CALL TAKENUMBER
    MOV NUMBER2, DL
    CALL NEWLINE
    CALL NEWLINE
	
	
     
    RET
      
    INPUTFORMALITIES ENDP

CALCULATIONS PROC              
    LEA DX, ENTERSIGN
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    
    CMP AL, '+'
    JE ADDI
    
    CMP AL, '-'
    JE SUBT
    
    CMP AL, '*'
    JE MULT
    
    CMP AL, '/'
    JE DIVI
    
    CMP AL, '^'
    JE POW
    
    CMP AL, 'r'
    JE RESET
    
    CMP AL, 'e'
    JE EXIT
    
    ADDI:
    CALL NEWLINE
    MOV AL, NUMBER1
    MOV BL, NUMBER2
    ADD AL, BL
    MOV RESULT, AL
    
    
    
    MOV AL, RESULT
    
    
    CALL OUTPUT
    CALL NEWLINE
    RET
    
    SUBT:
    CALL NEWLINE
    MOV AL, NUMBER1
    MOV BL, NUMBER2
    SUB AL, BL
    MOV RESULT, AL
    
    MOV AL, RESULT
    
    
    CMP AL, 0
    JL NEGATIVE
    
    CALL OUTPUT
    CALL NEWLINE
    JMP NEXTSTEP
    
    NEGATIVE:
    MOV AH, 2
    MOV DL, '-'
    INT 21H
    
    MOV AL, RESULT
    
    NEG AL
    CALL OUTPUT
    CALL NEWLINE
    
    NEXTSTEP:
    RET
    
    MULT:
    CALL NEWLINE        
    MOV AL, NUMBER1
    MOV BL, NUMBER2
    MUL BL
    CALL OUTPUT
    CALL NEWLINE
    RET
    
    DIVI:
    CALL NEWLINE
    
    MOV AL, NUMBER1 
    MOV AH, 1
    MUL AH
    
    MOV BL, NUMBER2
    
    DIV BL
    
    CALL OUTPUT
    CALL NEWLINE
    RET
    
    POW:
    CALL NEWLINE
    MOV AL, NUMBER1
    MOV BL, NUMBER1
    XOR AH, AH
    
    MOV BH, NUMBER2
    
    AGAINMUL:
    CMP BH, 1
    JLE EXITFROMLOOP
    MUL BL
    
    SUB BH, 1
    JMP AGAINMUL 
    EXITFROMLOOP:
    
 
    CALL OUTPUT
    CALL NEWLINE
    RET
    
    RESET:
    CALL NEWLINE
    CALL NEWLINE
    JMP UPLOOP
     
    RET
      
    CALCULATIONS ENDP

NEWLINE PROC              
    MOV AH, 2
    MOV DL, 13
    INT 21H
    MOV DL, 10
    INT 21H
     
    RET
      
    NEWLINE ENDP


ADDIT PROC              
    MOV AH, 2
    MOV DL, '1'
    INT 21H
     
    RET
      
    ADDIT ENDP

TAKENUMBER PROC
    MOV BL, 0     ;BL=0 
    MOV DL, 0     ;DL=0
    MOV AL, '0'   ;AL=48
    
    ABC:  
    SUB AL, '0'   ;AL=3
    MOV CL, AL    ;CL=3
    MOV AL, DL    ;AL=2
    MOV BL, 10
    MUL BL        ;AX=20, AL=20
    ADD AL, CL    ;AL=23
    MOV DL, AL    ;DL=23 (INPUT NUMBER IN STOR DL)
    
    MOV AH, 1     
    INT 21H       ;AL=51
     
    CMP AL, 13
    JNE ABC  
     
    RET
      
    TAKENUMBER ENDP

OUTPUT PROC
    
    MOV CX, 0  ;CX USE FOR NUMBER LENGHT
    MOV AH, 0
    ;NUMBER HAS BEEN CONVERTED INTO AX
    PRINT:
    CMP AL, 0 
    JE NEXT
    MOV BL, 10  
    DIV BL       ;REMIDER=AH, RESULT=AL
    PUSH AX      ;MUST PUSH 16 BIT REGISTER BUT AH WILL STORE IN STACK
    INC CX
    MOV AH, 0 
    JMP PRINT
    NEXT:
    POP DX     ;MUST USE 16 BIT REGISTER FOR POP BUT THE VALUE COME IN High Register
    MOV DL, DH
    ADD DL, '0'
    MOV AH, 2
    INT 21H
    LOOP NEXT
    
    RET
      
    OUTPUT ENDP


END MAIN