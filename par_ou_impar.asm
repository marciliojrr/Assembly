.386

.model flat, stdcall
option casemap :none
include \masm32\include\windows.inc
include \masm32\include\kernel32.inc
include \masm32\include\masm32.inc
include \masm32\include\msvcrt.inc
include \masm32\macros\macros.asm
includelib \masm32\lib\kernel32.lib
includelib \masm32\lib\masm32.lib
includelib \masm32\lib\msvcrt.lib

.data
num_1 dd 13


.code
start:
xor edx, edx
mov eax, num_1
mov ecx, 2
div ecx 
cmp edx, 1
je impar
printf("PAR!\n")
jmp saida


impar:
    printf("IMPAR!\n")
saida:
    invoke ExitProcess, 0
end start
