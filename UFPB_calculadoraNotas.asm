.386
.model flat,stdcall
option casemap:none

include \masm32\include\windows.inc

include \masm32\include\kernel32.inc
includelib \masm32\lib\kernel32.lib

include \masm32\include\masm32.inc
includelib \masm32\lib\masm32.lib

include \masm32\include\msvcrt.inc
includelib \masm32\lib\msvcrt.lib

include \masm32\macros\macros.asm


; »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»

.data

write_count dd 0
read_count   dd 0

handle_out dd ?
handle_in  dd ?

msg1 db "Qual a quantidade de notas da disciplina?", 0ah, 0h
msg2 db "Digite o nome de um aluno", 0ah, 0h
msg3 db "Digite uma nota:", 0ah, 0h
msg4 db "Aprovado!", 0ah, 0h
msg5 db "Reprovado!", 0ah, 0h
msg6 db "FINAL", 0ah, 0h

qtdNotas db 10 DUP(?)

_qtdNotas real8 ?

aluno db 10 DUP(?)

nota1 db 10 DUP(?)
nota2 db 10 DUP(?)
nota3 db 10 DUP(?)

_nota1 real8 ?
_nota2 real8 ?
_nota3 real8 ?

_sete   real8 7.0
_quatro real8 4.0

_media real8 ?

media  db 10 DUP(?)

teste  db 10 DUP(?)

; »»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»»

.code
start:

push STD_OUTPUT_HANDLE
call GetStdHandle
mov handle_out, eax

push STD_INPUT_HANDLE
call GetStdHandle
mov handle_in, eax


invoke WriteConsole, handle_out, addr msg1, sizeof msg1, addr write_count, NULL
invoke ReadConsole, handle_in, addr qtdNotas, sizeof qtdNotas, addr read_count, NULL
    
invoke StrToFloat, addr [qtdNotas], addr [_qtdNotas]



invoke WriteConsole, handle_out, addr msg2, sizeof msg2, addr write_count, NULL
invoke ReadConsole, handle_in, addr aluno, sizeof aluno, addr read_count, NULL



invoke WriteConsole, handle_out, addr msg3, sizeof msg3, addr write_count, NULL
invoke ReadConsole, handle_in, addr nota1, sizeof nota1, addr read_count, NULL
invoke StrToFloat, addr [nota1], addr [_nota1]



invoke WriteConsole, handle_out, addr msg3, sizeof msg3, addr write_count, NULL
invoke ReadConsole, handle_in, addr nota2, sizeof nota2, addr read_count, NULL
invoke StrToFloat, addr [nota2], addr [_nota2]



invoke WriteConsole, handle_out, addr msg3, sizeof msg3, addr write_count, NULL
invoke ReadConsole, handle_in, addr nota3, sizeof nota3, addr read_count, NULL
invoke StrToFloat, addr [nota3], addr [_nota3]


fld _media
fld _nota1
fadd
fld _nota2
fadd
fld _nota3
fadd
fld _qtdNotas
fdiv
fstp _media
fcom _sete
fstsw ax
sahf
jae REPROVADO
jb APROVADO
jmp FINAL


APROVADO:

printf("Aluno aprovado com media: %f\n", _media)
jmp SAIDA

REPROVADO:

printf("Aluno reprovado com media: %f\n", _media)
jmp SAIDA

FINAL:
printf("Final com media: %f\n", _media)
jmp SAIDA



SAIDA:

    ;invoke FloatToStr, _media, addr media
    ;invoke WriteConsole, handle_out, addr media, sizeof media, addr write_count, NULL



    invoke ExitProcess, 0

    end start
