extern printInt
extern printLF

section .text
    global _start

_start:
    xor     eax, eax
    mov     ax, 12
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
    push    ebx
    sub     esp, 12
    mov     bx, ax
    mov     word [esp + 0], bx
    mov     word [esp + 2], 1
    mov     word [esp + 4], 0

.loop_mul:
    mov     cx, [esp + 0]
    cmp     cx, 1
    jle     .finish_calc
    mov     bx, cx

    mov     ax, [esp + 2]
    mul     bx
    mov     word [esp + 6], ax
    mov     word [esp + 8], dx

    mov     ax, [esp + 4]
    mul     bx
    mov     si, ax
    add     si, [esp + 8]
    mov     [esp + 4], si
    mov     ax, [esp + 6]
    mov     [esp + 2], ax

    dec     word [esp + 0]
    jmp     .loop_mul

.finish_calc:
    mov     ax, [esp + 2]
    mov     dx, [esp + 4]
    add     esp, 12
    pop     ebx
    ret
