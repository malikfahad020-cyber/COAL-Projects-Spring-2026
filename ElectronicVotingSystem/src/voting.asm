org 100h
jmp start

msg1 db 13,10,'===== ELECTRONIC VOTING SYSTEM =====',13,10,'$'
msg2 db '1. Ali',13,10,'$'
msg3 db '2. Ahmed',13,10,'$'
msg4 db '3. Sara',13,10,'$'
msg5 db '4. Show Result & Exit',13,10,'$'
msg6 db 'Enter Your Vote (1-4): $'

voteAli   db 0
voteAhmed db 0
voteSara  db 0

aliMsg    db 13,10,'Vote Casted For Ali',13,10,'$'
ahmedMsg  db 13,10,'Vote Casted For Ahmed',13,10,'$'
saraMsg   db 13,10,'Vote Casted For Sara',13,10,'$'
invalid   db 13,10,'Invalid Vote! Try Again',13,10,'$'

resultMsg db 13,10,'===== RESULT =====',13,10,'$'
aliRes    db 13,10,'Ali Votes  : $'
ahmedRes  db 13,10,'Ahmed Votes: $'
saraRes   db 13,10,'Sara Votes : $'
winMsg    db 13,10,'Winner is: $'
aliWin    db 'Ali$'
ahmedWin  db 'Ahmed$'
saraWin   db 'Sara$'
tieMsg    db 'TIE - No Single Winner$'

start:
    mov ah,09h
    lea dx,msg1
    int 21h
    mov ah,09h
    lea dx,msg2
    int 21h
    mov ah,09h
    lea dx,msg3
    int 21h
    mov ah,09h
    lea dx,msg4
    int 21h
    mov ah,09h
    lea dx,msg5
    int 21h
    mov ah,09h
    lea dx,msg6
    int 21h
    mov ah,01h
    int 21h
    cmp al,'1'
    je ali_vote
    cmp al,'2'
    je ahmed_vote
    cmp al,'3'
    je sara_vote
    cmp al,'4'
    je show_result
    jmp wrong

ali_vote:
    inc voteAli
    mov ah,09h
    lea dx,aliMsg
    int 21h
    jmp start

ahmed_vote:
    inc voteAhmed
    mov ah,09h
    lea dx,ahmedMsg
    int 21h
    jmp start

sara_vote:
    inc voteSara
    mov ah,09h
    lea dx,saraMsg
    int 21h
    jmp start

wrong:
    mov ah,09h
    lea dx,invalid
    int 21h
    jmp start

show_result:
    mov ah,09h
    lea dx,resultMsg
    int 21h
    mov ah,09h
    lea dx,aliRes
    int 21h
    mov al,voteAli
    call print_num
    mov ah,09h
    lea dx,ahmedRes
    int 21h
    mov al,voteAhmed
    call print_num
    mov ah,09h
    lea dx,saraRes
    int 21h
    mov al,voteSara
    call print_num
    mov ah,09h
    lea dx,winMsg
    int 21h
    mov al,voteAli
    mov bl,voteAhmed
    mov cl,voteSara
    cmp al,bl
    jl ali_not_max
    cmp al,cl
    jl ali_not_max
    cmp al,bl
    je check_tie_ab
    cmp al,cl
    je check_tie_ac
    mov ah,09h
    lea dx,aliWin
    int 21h
    jmp end_program

ali_not_max:
    cmp bl,cl
    jl sara_winner
    je check_tie_bc
    mov ah,09h
    lea dx,ahmedWin
    int 21h
    jmp end_program

sara_winner
