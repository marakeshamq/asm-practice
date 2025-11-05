extern printInt
extern printLF

section .text
    global _start

_start:
    xor     eax, eax
    mov     ax, 10
    mov     esi, eax
    call    printInt
    call    printLF
    mov     eax, esi
    call    factorial
    shl     edx, 16
    or      eax, edx
    mov     esi, eax
    call    printInt
    call    printLF
    mov     eax, 1
    int     0x80

factorial:
    mov     cx, ax
    sub     esp, 10
    mov     [esp + 4], word 0
    mov     [esp + 2], word ax
    mov     [esp], cx
    cmp     ax, 1
    jbe     .done
.loop:
    dec     word [esp]
    xor     eax, eax
    xor     ebx, ebx
    xor     edx, edx
    mov     [esp + 8], word 0
    mov     [esp + 6], word 0
    mov     ax, [esp + 2]
    mov     bx, [esp]
    mul     bx
    mov     [esp + 8], dx
    mov     [esp + 6], ax
    mov     ax, [esp + 4]
    mov     bx, [esp]
    mul     bx
    mov     dx, ax
    add     dx, [e]()
