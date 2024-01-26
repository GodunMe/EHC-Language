section .data
    input db "Input anything here: ", 0
    len_input equ $ - input
    output_msg db "Your string entered: ", 0
    len_output_msg equ $ - output_msg
    newline db 0xa, 0xd, 0
    not_contain_lower db "Your strings entered is not contain lower case.", 0
    len_not_contain equ $ - not_contain_lower

section .bss
    input_str resb 32
    is_changed resb 1

section .text
    global _start

_start:
    ; In ra thông báo để nhập chuỗi
    mov eax, 4
    mov ebx, 1
    mov ecx, input
    mov edx, len_input
    int 0x80

    ; Đọc chuỗi từ người dùng
    mov eax, 3
    mov ebx, 0
    mov ecx, input_str
    mov edx, 32
    int 0x80

    ; Chuyển đổi chuỗi thành chữ hoa
    mov ecx, input_str
    xor edx, edx  ; Sử dụng edx làm index

convert_loop:
    mov al, [ecx + edx]
    cmp al, 0  ; Kiểm tra ký tự kết thúc chuỗi
    je end_convert

    cmp al, 'a'
    jl skip_convert  ; Nếu ký tự không phải là chữ thường, bỏ qua

    cmp al, 'z'
    jg skip_convert
    
    sub al, 32 
    mov [ecx + edx], al
    mov byte [is_changed], 1
    inc edx
    jmp convert_loop

skip_convert:
    inc edx
    jmp convert_loop

end_convert:
    cmp byte [is_changed], 0
    jne strings_not_equal
    
    ; In ra thông báo khi không có chữ thường
    mov eax, 4
    mov ebx, 1
    mov ecx, not_contain_lower
    mov edx, len_not_contain 
    int 0x80

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 0x80
    jmp end_program

strings_not_equal:
    ; In ra chuỗi đã nhập
    mov eax, 4
    mov ebx, 1
    mov ecx, output_msg
    mov edx, len_output_msg
    int 0x80

    ; In ra chuỗi sau khi chuyển đổi
    mov eax, 4
    mov ebx, 1
    mov ecx, input_str
    mov edx, 32
    int 0x80

end_program:
    ; Kết thúc chương trình
    mov eax, 1
    int 0x80
