section .data
    msg1 db "Enter the first number: ", 0
    msg1_length equ $ - msg1
    msg2 db "Enter the second number: ", 0
    msg2_length equ $ - msg2    
    output db "Sum: ", 0
    output_length equ $ - output

section .bss
    num1 resb 33
    num2 resb 33
    result resb 34

section .text
    global _start

_start:
    ; In yêu cầu nhập số thứ nhất
    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, msg1_length
    int 0x80

    ; Đọc số thứ nhất
    mov eax, 3
    mov ebx, 0
    mov ecx, num1
    mov edx, 32
    int 0x80

    ; Tìm độ dài của num1
    mov eax, num1
    call calculate_length
    mov esi, eax

    ; In yêu cầu nhập số thứ hai
    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, msg2_length
    int 0x80

    ; Đọc số thứ hai 
    mov eax, 3
    mov ebx, 0
    mov ecx, num2
    mov edx, 32
    int 0x80

    ; Tìm độ dài của num2
    mov eax, num2
    call calculate_length
    mov edi, eax

    mov ebx, 33         ; Vị trí lưu kết quả (bắt đầu từ cuối)
    xor ecx, ecx        ; Clear carry

    ; Bắt đầu vòng lặp cộng
    add_loop:
        dec esi
        dec edi
        dec ebx

        ; Xử lý số thứ nhất
        mov al, '0'
        cmp esi, -1
        jle skip_num1
        mov al, [num1 + esi]
        sub al, '0'

        skip_num1:
        ; Xử lý số thứ hai
        mov ah, '0'
        cmp edi, -1
        jle skip_num2
        mov ah, [num2 + edi]
        sub ah, '0'

        skip_num2:
        ; Cộng hai chữ số
        add al, ah
        adc al, cl         ; Thêm carry nếu có
        aaa                ; Adjust after addition
        add al, '0'        ; Chuyển về dạng ASCII

        ; Lưu kết quả
        mov [result + ebx], al

        ; Cập nhật chỉ số và carry
        mov cl, 0
        adc cl, 0          ; Cập nhật carry

        ; Kiểm tra điều kiện dừng
        cmp esi, -1
        jl check_num2
        cmp edi, -1
        jl check_num2
        jmp add_loop

    check_num2:
        cmp ebx, 0
        jge print_result
        jmp add_loop

    print_result:
        mov eax, 4
        mov ebx, 1
        mov ecx, output
        mov edx, output_length
        int 0x80

        ; In kết quả
        mov eax, 4
        mov ebx, 1
        lea ecx, [result + ebx + 1] ; Địa chỉ chuỗi kết quả
        mov edx, 33
        sub edx, ebx               ; Tính độ dài kết quả
        int 0x80

    ; Thoát
    mov eax, 1
    int 0x80

calculate_length:
    mov ecx, -1
    count_length:
        inc ecx
        cmp byte [eax + ecx], 0xA  ; Kiểm tra ký tự xuống dòng
        je length_found
        cmp byte [eax + ecx], 0    ; Kiểm tra ký tự kết thúc
        je length_found
        jmp count_length
    length_found:
        mov eax, ecx
        ret
