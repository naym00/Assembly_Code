.MODEL SMALL 
.STACK 100H 
.DATA  
DESCRIPTION_ADDITION         DB 'For ADD operation Enter    + Sign.$'
DESCRIPTION_SUBTRACTION      DB 'For SUB operation Enter    - Sign.$'
DESCRIPTION_MULTIPLICATION   DB 'For MUL operation Enter    * Sign.$'
DESCRIPTION_DIVISION         DB 'For DIV operation Enter    / Sign.$'
DESCRIPTION_REMAINDER        DB 'For REMAINDER Enter        % Sign.$'
DESCRIPTION_POWER            DB 'For POWER operation Enter  ^ Sign.$'
DESCRIPTION_ROOT             DB 'For ROOT operation Enter   R Sign.$'
DESCRIPTION_RESET            DB 'For RESET operation Enter  r Sign.$'
DESCRIPTION_EXIT             DB 'For EXIT Enter             Esc Sign.$'

ENTER_SIGN                   DB 'ENTER Sign: $'
FIRST_NUMBER                 DB 'Enter the First Number: $'
SECOND_NUMBER                DB 'Enter the Second Number: $'


NUMBER1                      DW ?
NUMBER2                      DW ?
RESULT                       DW ?



UPPER_LOOP                   DB 0
INNER_LOOP                   DB 0

 
.CODE 
MAIN PROC FAR
    
    MOV AX, @DATA
    MOV DS, AX
    
    CALL OPERATION_DETAILS 
    
    UP_LOOP:
    CALL INPUTFORMALITIES
    IN_LOOP:
    CALL CALCULATIONS
    CMP INNER_LOOP, 0
    JE IN_LOOP
    
    CMP UPPER_LOOP, 0
    JE UP_LOOP 
    
    EXIT:                                
    MOV AH, 4CH   
    INT 21H 
  
    MAIN ENDP

OPERATION_DETAILS PROC              
    LEA DX, DESCRIPTION_ADDITION
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    
    LEA DX, DESCRIPTION_SUBTRACTION
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    
    LEA DX, DESCRIPTION_MULTIPLICATION
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    
    LEA DX, DESCRIPTION_DIVISION
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    
    LEA DX, DESCRIPTION_REMAINDER
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    
    LEA DX, DESCRIPTION_POWER
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    
    LEA DX, DESCRIPTION_ROOT
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    
    LEA DX, DESCRIPTION_RESET
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    
    LEA DX, DESCRIPTION_EXIT
    MOV AH, 9
    INT 21H
    CALL NEWLINE
    CALL NEWLINE
    RET 
    OPERATION_DETAILS ENDP

INPUTFORMALITIES PROC              
    LEA DX, FIRST_NUMBER
    MOV AH, 9
    INT 21H
    CALL TAKENUMBER
    MOV NUMBER1, DX
    CALL NEWLINE
    
    LEA DX, SECOND_NUMBER
    MOV AH, 9
    INT 21H
    CALL TAKENUMBER
    MOV NUMBER2, DX
    CALL NEWLINE
    CALL NEWLINE
    RET
    INPUTFORMALITIES ENDP

CALCULATIONS PROC              
    LEA DX, ENTER_SIGN
    MOV AH, 9
    INT 21H
    
    MOV AH, 1
    INT 21H
    
    CMP AL, '+'
    JE ADDITION
    
    CMP AL, '-'
    JE SUBTRACTION
    
    CMP AL, '*'
    JE MULTIPLICATION
    
    CMP AL, '/'
    JE DIVISION
    
    CMP AL, '%'
    JE REMAINDER
    
    CMP AL, '^'
    JE POWER
    
    CMP AL, 'R'
    JE ROOT
    
    CMP AL, 'r'
    JE RESET
    
    CMP AL, 27
    JE EXIT
    
    ADDITION:
    CALL NEWLINE
    MOV AX, NUMBER1
    MOV BX, NUMBER2
    ADD AX, BX
    MOV RESULT, AX
    MOV AX, RESULT
    
    CALL OUTPUT
    CALL NEWLINE
    RET
    
    SUBTRACTION:
    CALL NEWLINE
    MOV AX, NUMBER1
    MOV BX, NUMBER2
    SUB AX, BX
    MOV RESULT, AX
    
    MOV AX, RESULT
    
    
    CMP AX, 0
    JL NEGATIVE
    
    CALL OUTPUT
    CALL NEWLINE
    JMP NEXTSTEP
    
    NEGATIVE:
    MOV AH, 2
    MOV DL, '-'
    INT 21H
    
    MOV AX, RESULT
    
    NEG AX
    CALL OUTPUT
    CALL NEWLINE
    
    NEXTSTEP:
    RET
    
    MULTIPLICATION:
    CALL NEWLINE
    MOV DX, 0        
    MOV AX, NUMBER1
    MOV BX, NUMBER2
    MUL BX
    CALL OUTPUT
    CALL NEWLINE
    RET
    
    
    DIVISION:
    CALL NEWLINE
    
    MOV AX, NUMBER1 
    MOV DX, 0
    MOV BX, NUMBER2
    
    DIV BX
    
    CALL OUTPUT
    CALL NEWLINE
    RET
    
    REMAINDER:
    CALL NEWLINE
    MOV AX, NUMBER1 
    MOV DX, 0
    MOV BX, NUMBER2
    
    DIV BX
    MOV AX, DX 
    CALL OUTPUT 
    CALL NEWLINE 
    
    RET
    
    POWER:
    MOV CX, NUMBER2
    MOV DX, 0
    MOV AX, 1
    MOV BX, NUMBER1
    
    POWER_RESULT:
    CMP CX, 0
    JG GO_FOR_NEXT_STEP
    JMP OUT_OF_LOOP
    GO_FOR_NEXT_STEP:
    MUL BX
    DEC CX
    JMP POWER_RESULT
    
    OUT_OF_LOOP:
    MOV RESULT, AX
    CALL NEWLINE
    MOV AX, RESULT
    CALL OUTPUT 
    CALL NEWLINE
    RET
    
    ROOT:
    MOV BX, 1
    ROOT_RESULT:
    MOV AX, BX
    MUL BX
    INC BX
    CMP AX, NUMBER1
    JL ROOT_RESULT
    
    CMP AX, NUMBER1
    JG HAVE_TO_DECRIMENT_ONE
    JMP PERFECT
    HAVE_TO_DECRIMENT_ONE:
    DEC BX
     
    PERFECT:
    DEC BX
    MOV RESULT, BX
    CALL NEWLINE
    MOV AX, RESULT
    CALL OUTPUT 
    CALL NEWLINE  
    RET
    
    RESET:
    CALL NEWLINE
    CALL NEWLINE
    JMP UP_LOOP
     
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

TAKENUMBER PROC
    ;NUMBER IN DX              
    MOV DX, 0
    INPUT:
    MOV AH, 1
    INT 21H
    CMP AL, 13
    JE DONE_INPUT
    SUB AL, '0'
    MUL AH       
    MOV CX, AX     
    MOV AX, DX     
    MOV BX, 10
    MUL BX         
    ADD CX, AX
    MOV DX, CX
    JMP INPUT
    DONE_INPUT:
     
    RET  
    TAKENUMBER ENDP 

OUTPUT PROC
    ;Number has to be in AX              
    ;Initilize Count 
    MOV CX, 0 
    MOV DX, 0 
    LABEL: 
    CMP AX, 0     ;If AX Is Zero 
    JE PRINT       
         
    MOV BX, 10    ;Initilize BX To 10
          
    DIV BX        ;Extract The Last Digit    
          
    PUSH DX       ;Push It In The Stack 
          
    INC CX        ;Increment The Count
          
    XOR DX, DX    ;Set DX To 0
    JMP LABEL 
    PRINT:  
    CMP CX, 0     ;Check If Count Is Greater Than Zero
    JE DONE_OUTPUT
           
    POP DX        ;POP The Top Of Stack
         
    ADD DX, 48    ;Add 48 So That It Represents The ASCII Value Of Digits
           
    MOV AH, 2     ;Interuppt To Print A Character
    INT 21H 
           
    DEC CX        ;Decrease The Count
    JMP PRINT
    
    DONE_OUTPUT:
    RET
      
    OUTPUT ENDP
END MAIN
