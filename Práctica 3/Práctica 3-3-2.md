# int0 equ 24h

pb equ 31h

cb equ 33h

num\_f10 equ 10

eoi equ 20h

imr equ 21h

org 40

dw rut\_f10

org 3000h

ini\_pio: mov al, 0h

out cb, al

mov al, 0

out pb,al

ret

rut\_f10: push ax

in al, pb

not al

out pb,al

mov al, eoi

out eoi, al

pop ax

iret

ini\_pic:

cli

mov al, 0feh

out imr, al

mov al, num\_f10

out int0,al

sti

ret

org 2000h

call ini\_pio

call ini\_pic

loop: jmp loop

int 0

end