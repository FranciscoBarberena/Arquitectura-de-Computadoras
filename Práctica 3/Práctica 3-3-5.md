# pa equ 30h

pb equ 31h

ca equ 32h

cb equ 33h

cont equ 10h

comp equ 11h

eoi equ 20h

num\_timer equ 20

int1 equ 25h

imr equ 21h

org 80

dw rut\_timer

org 1000h

estado\_llaves db ?

termino\_timer db 0

org 1500h

ini\_pio:

mov al, 0FFh

out ca,al

mov al, 0

out cb,al

ret

ini\_timer:

mov al, 11111101b

out imr,al

mov al, 12

out comp,al

mov al,0

out cont,al

ret

ini\_pic: cli

mov al,0FFh

out imr,al

mov al,num\_timer

out int1,al

sti

ret

rut\_timer:

push ax

not termino\_timer

mov al, eoi

out eoi, al

pop ax

iret

Luces\_12:

mov bx, sp

add bx, 2

mov bx, \[bx\]

mov al, \[bx\]

and al, 10000000b

jz fin

mov al,0FFh

out pb,al

call ini\_timer

esperar:

cmp termino\_timer,0FFh

jnz esperar

not termino\_timer

mov al,0

out pb,al

fin: ret

org 2000h

call ini\_pio

call ini\_pic

loop:

in al, pa

mov estado\_llaves,al

mov bx, offset estado\_llaves

push bx

call Luces\_12

jmp loop

int 0

end