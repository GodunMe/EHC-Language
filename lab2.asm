section .data
    msg1 db "Input: ", 0xa, 0xd
    len1 equ $-msg1

    msg2 db "Nhap vao chieu dai va chieu rong: ", 0xa, 0xd
    len2 equ $-msg2

    msg3 db "Output: ", 0xa, 0xd
    len3 equ $-msg3

    msg4 db "Dien tich cua hinh chu nhat: "
    len4 equ $-msg4

    msg5 db "Chu vi cua hinh chu nhat: "
    len5 equ $-msg5

    newLine db 0xa, 0xd
    newLineLen equ $-newLine

section .bss
    num1 resb 10
    num2 resb 10
    resA resb 1
    resP resb 1

section .text
    global _start

_start:
    ; Print "Input: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80

    ; Print "Nhap vao chieu dai va chieu rong: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

    ; Read input for num1
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 10
    int 0x80

    ; Read input for num2
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 10
    int 0x80

    ; Calculate area
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    mul bl
    add al, '0'
    mov [resA], al

    ; Print "Output: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len3
    int 0x80

    ; Print "Dien tich cua hinh chu nhat: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, len4
    int 0x80

    ; Print area
    mov eax, 4
    mov ebx, 1
    mov ecx, resA
    mov edx, 1
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 0x80

    ; Calculate perimeter
    mov al, [num1]
    sub al, '0'
    mov bl, [num2]
    sub bl, '0'
    add al, bl
    shl al, 1
    add al, '0'
    mov [resP], al

    ; Print "Chu vi cua hinh chu nhat: "
    mov eax, 4
    mov ebx, 1
    mov ecx, msg5
    mov edx, len5
    int 0x80

    ; Print perimeter
    mov eax, 4
    mov ebx, 1
    mov ecx, resP
    mov edx, 1
    int 0x80

    ; Print newline
    mov eax, 4
    mov ebx, 1
    mov ecx, newLine
    mov edx, newLineLen
    int 0x80

    ; Exit
    mov eax, 1
    int 0x80
