extern printPrimeNum
extern printLF

BORDER  equ '#'
DOT     equ '#'
SPACE   equ ' '

section .text
    global _start

_start:
    mov ah, 36
    mov al, 18
    call drawEnvelope
    mov eax, 1
    int 0x80

drawEnvelope:
    mov [w], ah
    mov [h], al
    call setupLine
    call drawEdge
    call drawMiddle
    call drawEdge
    ret

setupLine:
    mov eax, [w]
    mov [row + eax], byte 13
    inc eax
    mov [row + eax], byte 10
    ret

drawEdge:
    xor ecx, ecx
    mov cl, [w]
top_loop:
    dec ecx
    mov [row + ecx], byte BORDER
    inc ecx
    loop top_loop
    call printLine
    ret

drawMiddle:
    sub esp, 4
    mov [esp + 3], byte 0
    mov [esp + 2], byte 0
    mov [esp + 1], byte 0
    mov [esp], byte 0

    xor ecx, ecx
    mov cl, [w]
    sub cl, 2
clear_line:
    mov [row + ecx], byte SPACE
    loop clear_line

    xor eax, eax
    xor ebx, ebx
    mov al, [w]
    mov bl, [h]
    div bl
    mov [esp + 2], al

    xor ecx, ecx
    mov cl, [h]
    sub cl, 2
draw_body:
    mov byte [esp], cl
    mov al, [esp + 2]
    add [esp + 3], al

    mov al, [esp + 3]
    mov [row + eax], byte DOT

    mov bl, [w]
    dec bl
    sub bl, al
    mov [row + ebx], byte DOT

    call printLine

    mov [row + eax], byte SPACE
    mov [row + ebx], byte SPACE

    mov cl, [esp]
    loop draw_body

    add esp, 4
    ret

printLine:
    push eax
    push ebx
    mov eax, 4
    mov ebx, 1
    mov ecx, row
    mov dl, [w]
    add dl, 2
    int 0x80
    pop ebx
    pop eax
    ret

section .bss
    row: resb 260
    h:   resb 1
    w:   resb 1
