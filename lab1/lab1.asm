section .data
    input db 'Input: '
    input_len equ $-input

    output db 'Output:', 0xa, 0xd
    output_len equ $-output

    hello db 'Hello '
    hello_len equ $-hello

    syntax db ' !!', 0xa, 0xd
    syntax_len equ $-syntax

    welcome db 'Welcome, '
    welcome_len equ $-welcome

    toEHC db ' to EHC', 0xa, 0xd
    toEHC_len equ $-toEHC

section .bss
    name resb 10

section .text
    global _start

_start:
    ;Print "Input: "
    mov eax, 4
    mov ebx, 1
    mov ecx, input
    mov edx, input_len
    int 0x80

    ;Read input
    mov eax, 3
    mov ebx, 0
    mov ecx, name
    mov edx, 10
    int 0x80

    ;Delete newline character
    mov edx, name
    sub eax, 0x1
    mov word[edx + eax], 0x0

    ;Print "Output:"
    mov eax, 4
    mov ebx, 1
    mov ecx, output
    mov edx, output_len
    int 0x80
    

    ;Print "Hello "
    mov eax, 4
    mov ebx, 1
    mov ecx, hello
    mov edx, hello_len
    int 0x80

    ;Print input name
    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, 10
    int 0x80

    ;Print syntax
    mov eax, 4
    mov ebx, 1
    mov ecx, syntax
    mov edx, syntax_len
    int 0x80

    ;Print "Welcome, "
    mov eax, 4
    mov ebx, 1
    mov ecx, welcome
    mov edx, welcome_len
    int 0x80

    ;Print input name again
    mov eax, 4
    mov ebx, 1
    mov ecx, name
    mov edx, 10
    int 0x80

    ;Print " to EHC"
    mov eax, 4
    mov ebx, 1
    mov ecx, toEHC
    mov edx, toEHC_len
    int 0x80

    ;Exit
    mov eax, 1
    int 0x80
