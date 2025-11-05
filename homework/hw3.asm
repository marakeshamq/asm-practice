BUF_LEN     equ 12

section .text
    global _start

_start:
    mov     eax, 17
    call    print_number
    call    check_prime
    mov     eax, 1
    xor     ebx, ebx
    int     0x80

check_prime:
    push    eax
    cmp     eax, 2
    jb      .is_prime
    je      .is_prime
    mov     ebx, 2
.loop:
    mov     eax, [esp]
    xor     edx, edx
    div     ebx
    test    edx, edx
    jz      .not_prime
    inc     ebx
    mov     eax, [esp]
    cmp     ebx, eax
    jb      .loop
.is_prime:
    call    show_prime
    add     esp, 4
    ret
.not_prime:
    call    show_not_prime
    add     esp, 4
    ret

print_number:
    mov     esi, eax
    mov     edi, buffer + BUF_LEN
    mov     byte [edi - 1], 0
    dec     edi
    test    eax, eax
    jnz     .convert
    mov     byte [edi], '0'
    jmp     .print
.convert:
    xor     edx, edx
    mov     ebx, 10
.next_digit:
    xor     edx, edx
    div     ebx
    add     dl, '0'
    dec     edi
    mov     [edi], dl
    test    eax, eax
    jnz     .next_digit
.print:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, edi
    mov     edx, buffer + BUF_LEN
    sub     edx, edi
    int     0x80
    call    newline
    mov     eax, esi
    ret

show_prime:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, msg_prime
    mov     edx, msg_prime_len
    int     0x80
    call    newline
    ret

show_not_prime:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, msg_notprime
    mov     edx, msg_notprime_len
    int     0x80
    call    newline
    ret

newline:
    mov     eax, 4
    mov     ebx, 1
    mov     ecx, nl
    mov     edx, 1
    int     0x80
    ret

section .data
    msg_prime       db "That's a prime number", 0
    msg_prime_len   equ $ - msg_prime
    msg_notprime    db "That's NOT a prime number", 0
    msg_notprime_len equ $ - msg_notprime
    nl              db 10

section .bss
    buffer  resb BUF_LEN
