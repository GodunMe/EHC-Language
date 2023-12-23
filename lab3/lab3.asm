section .data
    msg1 db "Enter the number:", 0
    len1 equ $ - msg1
    msg2 db "-> This is odd number!!",  0xa, 0xd, 0
    len2 equ $ - msg2
    msg3 db "-> This is even number!!", 0xa, 0xd, 0
    len3 equ $ - msg3
section .bss
    num resb 1
section .text
    global _start
_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, len1
    int 0x80
        
    mov eax, 3
    mov ebx, 0
    mov ecx, num
    mov edx, 1
    int 0x80
    
    test byte [num], 1
    jnz odd
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, len3
    int 0x80
    jmp exit
    
odd:
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, len2
    int 0x80

exit:
    mov eax, 1
    int 0x80

    
