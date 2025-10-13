; ===============================
;   HW2: IntToString
; ===============================

section .data
    buffer_size equ 16

section .bss
    buffer resb buffer_size
    len    resb 1

section .text
    global _start

_start:
    mov eax, 1234567       ; число для перетворення
    mov esi, buffer         ; куди писати рядок
    call intToString        ; викликати функцію

    ; вивести результат
    mov eax, 4              ; sys_write
    mov ebx, 1              ; stdout
    mov ecx, buffer
    movzx edx, byte [len]   ; довжина рядка
    int 0x80

    ; вихід
    mov eax, 1
    xor ebx, ebx
    int 0x80


; -------------------------------
; intToString:
;   вхід: eax — число
;         esi — адрес буфера
;   вихід: рядок числа в буфері
; -------------------------------
intToString:
    push ebx
    push ecx
    push edx

    cmp eax, 0
    jne .convert
    mov byte [esi], '0'
    mov byte [len], 1
    jmp .done

.convert:
    mov ecx, 0

.rev_loop:
    xor edx, edx
    mov ebx, 10
    div ebx
    add dl, '0'
    movzx ebx, dx
    push ebx
    inc ecx
    test eax, eax
    jnz .rev_loop

    mov [len], cl
    mov ebx, ecx

.write_loop:
    pop eax
    mov [esi], al
    inc esi
    loop .write_loop

.done:
    pop edx
    pop ecx
    pop ebx
    ret
