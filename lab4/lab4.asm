section .data
    prompt db "Input: ", 0
    len_prompt equ $ - prompt
    output1 db "Sum of "
    len_output1 equ $ - output1
    output2 db " sequences is: "
    len_output2 equ $ - output2
    newline db 0xa, 0xd, 0
    
section .bss
    n resd 1
    sum resd 1
    
section .text
    global _start

_start:
    mov eax, 4
    mov ebx, 1
    mov ecx, prompt
    mov edx, len_prompt
    int 0x80

    mov eax, 3
    mov ebx, 0
    mov ecx, n
    mov edx, 4
    int 0x80

    dec eax 
    mov edx, n
    mov byte [edx + eax], 0  

    mov eax, 4
    mov ebx, 1
    mov ecx, output1
    mov edx, len_output1
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, n
    mov edx, 1
    int 0x80
    
    mov eax, 4
    mov ebx, 1
    mov ecx, output2
    mov edx, len_output2
    int 0x80
    
    sub dword [n], '0'
    mov dword [sum], 0
    mov ecx, 1  

sum_loop:
    add [sum], ecx  
    inc ecx         
    cmp ecx, [n]      
    jbe sum_loop    
    
    add byte [sum], '0'
    mov eax, 4
    mov ebx, 1
    mov ecx, sum    
    mov edx, 4      
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 1
    int 0x80
