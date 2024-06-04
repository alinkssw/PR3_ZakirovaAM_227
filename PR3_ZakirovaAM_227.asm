DATA SEGMENT
    A DB ? 
    X DB ? 
    Y DB ?   
    Y1 DB ?
    Y2 DB ?
    PERENOS DB 13,10,"$" 
    VVOD_A DB 13,10,"VVEDITE A=$" 

    VVOD_X DB 13,10,"VVEDITE X=$",13,10
    VIVOD_Y DB "Y=$" 
ENDS
STACK SEGMENT
    DW 128 DUP(0) 
ENDS
CODE SEGMENT
START:

    MOV AX, DATA 
    MOV DS, AX ; ????????? ???????? ??????
    MOV ES, AX ; ????????? ??????????????? ????????
    XOR AX, AX ; ????????? ???????? AX
    MOV DX, OFFSET VVOD_A ; ???????? ?????? ?????? ??????????? ??? ????? A ? DX
    MOV AH, 9 ; ????????? ??????? DOS ??? ?????? ??????
    INT 21H ; ????? DOS ??? ?????? ??????
        SLED2:
    MOV AH, 1 ; ????????? ??????? DOS ??? ????? ??????? ? ??????????
    INT 21H ; ????? DOS
    CMP AL, "-" ; ????????, ???????? ?? ????????? ?????? ?????? ??????
    JNZ SLED1 ; ???????, ???? ????????? ?????? ?? ?????
    MOV BX, 1 ; ????????? ???????? ??????
    JMP SLED2 ; ????????? ???? ???????
        SLED1:
    SUB AL, 30H ; ?????????????? ASCII ???? ????? ? ???????? ????????
    TEST BX, BX ; ???????? ???????? ??????
    JZ SLED3 ; ???????, ???? ??????? ?????? ?? ??????????
    NEG AL ; ???????? ????? ?????
    
        SLED3:
    MOV A, AL ; ?????????? ???????? A
    XOR AX, AX ; ????????? ???????? AX
    XOR BX, BX ; ????????? ???????? BX
    MOV DX, OFFSET VVOD_X ; ???????? ?????? ?????? ??????????? ??? ????? X ? DX
    MOV AH, 9 ; ????????? ??????? DOS ??? ?????? ??????
    INT 21H ; ????? DOS ??? ?????? ??????
        SLED4:
    MOV AH, 1 ; ????????? ??????? DOS ??? ????? ??????? ? ??????????
    INT 21H ; ????? DOS
    CMP AL, "-" ; ????????, ???????? ?? ????????? ?????? ?????? ??????
    JNZ SLED5 ; ???????, ???? ????????? ?????? ?? ?????
    MOV BX, 1 ; ????????? ???????? ??????
    JMP SLED4 ; ????????? ???? ???????
        SLED5:
    SUB AL, 30H ; ?????????????? ASCII ???? ????? ? ???????? ????????
    TEST BX, BX ; ???????? ???????? ??????
    JZ SLED6 
    NEG AL 
        SLED6:
    MOV X, AL
    cmp al,1
    ja @vishe
    cmp al,0
    jb @nije
    jmp short @skip
    @nije:
    neg al
    @skip:
    mov bl,A
    add al,bl
    mov Y1,al
    jmp short @Y2g
    
    @vishe:
    add al,0Ah
    mov Y1,al
    
        @Y2g:
    mov bx,0
    mov ax,0
    mov al,X
    cmp al,4h
    ja @na
    mov Y2,al
    jmp short @VIXOD
    @na:
    mov Y2,2h
    
    
    @VIXOD:
    mov ax,0
    mov bx,0
    mov al,Y1
    mov bl,Y2
    div bl
    MOV Y, Ah 
    MOV DX, OFFSET PERENOS 
    MOV AH, 9 
    INT 21H 
    MOV DX, OFFSET VIVOD_Y 
    MOV AH, 9 
    INT 21H 
    MOV AL, Y ; ???????? ???????? Y ? AL
    CMP Y, 0 ; ???????? ????? Y
    JGE SLED7 ; ???????, ???? Y >= 0
    NEG AL ; ???????? ?????, ???? Y < 0
    MOV BL, AL ; ?????????? ?????????????? ???????? ? BL
    MOV DL, "-" ; ???????? ????? ?????? ? DL
    MOV AH, 2 ; ????????? ??????? DOS ??? ?????? ???????
    INT 21H ; ????? DOS ??? ?????? ???????
    MOV DL, BL ; ???????? ?????????????? ???????? ? DL
    ADD DL, 30H ; ?????????????? ???????? ? ASCII ???
    INT 21H ; ????? DOS ??? ?????? ???????
    JMP SLED8 ; ??????? ? ??????????
        SLED7:
    MOV DL, Y ; ???????? ???????? Y ? DL
    ADD DL, 30H ; ?????????????? ???????? ? ASCII ???
    MOV AH, 2 ; ????????? ??????? DOS ??? ?????? ???????
    INT 21H ; ????? DOS ??? ?????? ???????
        SLED8:
    MOV DX, OFFSET PERENOS ; ???????? ?????? ?????? ???????? ?????? ? DX
    MOV AH, 9 ; ????????? ??????? DOS ??? ?????? ??????
    INT 21H ; ????? DOS ??? ?????? ??????

MOV AH, 1 ; ????????? ??????? DOS ??? ???????? ??????? ???????
INT 21H ; ????? DOS ??? ???????? ??????? ???????
MOV AX, 4C00H ; ????????? ??????? DOS ??? ?????? ?? ?????????
INT 21H ; ????? DOS ??? ?????????? ?????????
ENDS
END START