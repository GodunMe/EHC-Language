section .data
   msg db 'The sum is: ', 0
   len equ $ - msg            
   input1 db 'Enter the first number: ', 0
   len_input1 equ $ - input1
   input2 db 'Enter the second number: ', 0
   len_input2 equ $ - input2
   newline db 0xa, 0xd, 0
   error_msg db 'Please enter a valid positive integer', 0xa, 0xd, 0
   len_error equ $ - error_msg
   carry_msg db '1'

section .bss
   num1 resb 31
   num2 resb 31
   sum resb 32

section .text
   global _start        

_start:          
   ; input the first number 
   mov eax, 4
   mov ebx, 1
   mov ecx, input1
   mov edx, len_input1
   int 80h

   mov eax, 3
   mov ebx, 0
   mov ecx, num1
   mov edx, 31
   int 80h

   ; input the second number
   mov eax, 4
   mov ebx, 1
   mov ecx, input2
   mov edx, len_input2
   int 80h

   mov eax, 3
   mov ebx, 0
   mov ecx, num2
   mov edx, 31
   int 80h

   ; find length
   xor ecx, ecx
   lenNum1:
      cmp byte [num1 + ecx], 0
      je  length1
      inc ecx
      jmp lenNum1
   length1:
      sub ecx, 1
      mov esi, ecx   ; esi now holds the length of num1

   xor ecx, ecx
   lenNum2:
      cmp byte [num2 + ecx], 0
      je  length2
      inc ecx
      jmp lenNum2
   length2:
      sub ecx, 1
      mov edi, ecx   ; edi now holds the length of num2

   ; find the maximum length
   cmp esi, edi
   jae lenMax
   mov esi, edi
   lenMax:
      mov   ecx, esi

   call check_input
   xor al, al

add_loop:  
   mov al, [num1 + esi - 1]
   adc al, [num2 + edi - 1]
   aaa
   pushf
   or al, 30h
   popf

   mov [sum + ecx - 1], al
   dec edi
   dec esi
   loop add_loop

   ; Check to add '1' before sum
   jc carry
   jmp no_carry

no_carry:

   ; print the result
   mov eax, 4            
   mov ebx, 1            
   mov ecx, msg         
   mov edx, len    
   int 80h                 

   mov eax, 4            
   mov ebx, 1            
   mov ecx, sum         
   mov edx, ecx    
   int 80h               

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 80h

   ; exit the program
   mov eax, 1        
   int 80h 
carry: 
   ; print the result
   mov eax, 4            
   mov ebx, 1            
   mov ecx, msg         
   mov edx, len    
   int 80h         
   
   mov eax, 4            
   mov ebx, 1            
   mov ecx, carry_msg         
   mov edx, 1
   int 80h        

   mov eax, 4            
   mov ebx, 1            
   mov ecx, sum         
   mov edx, ecx    
   int 80h               

   mov eax, 4
   mov ebx, 1
   mov ecx, newline
   mov edx, 1
   int 80h

   ; exit the program
   mov eax, 1        
   int 80h 

check_input:
   mov eax, esi
   mov ebx, edi
   mov al, [num1 + eax - 1]
   cmp al, '0'
   jl input_error
   cmp al, '9'
   jg input_error

   mov al, [num2 + ebx - 1]
   cmp al, '0'
   jl input_error
   cmp al, '9'
   jg input_error
   ret

input_error:
   mov eax, 4
   mov ebx, 1
   mov ecx, error_msg
   mov edx, len_error
   int 80h
   jmp _start
