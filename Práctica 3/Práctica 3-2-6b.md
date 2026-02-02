# EOI equ 20h

IMR equ 21h

INT0 equ 24h

INT1 equ 25h

n\_f10 equ 10

n\_timer equ 20

cont equ 10h

comp equ 11h

org 40

IP\_f10 dw rut\_f10

org 80

dw rut\_timer

org 1000h

PAUSA db 0

seg db ?

org 1500h

ini\_pic:

cli

push ax

mov al, n\_f10

out int0,al

mov al, n\_timer

out int1,al

call ini\_timer

mov seg,'9'+1;

pop ax

sti

ret

rut\_f10:

push ax

push bx

mov bx, offset seg

cmp byte ptr \[bx\],02Fh

jnz seguir

call ini\_pic

call ini\_timer

jmp finn

seguir: not pausa

finn:mov al, eoi

out eoi,al

pop bx

pop ax

iret

ini\_timer:

push ax

and al,11111100b

out imr,al

mov al,0

out cont,al

mov al,1

out comp,al

pop ax

ret

rut\_timer:

push bx

push ax

mov bx, offset seg

dec byte ptr \[bx\]

cmp byte ptr \[bx\], '0'-1

jz fin

js fin

mov al,1

int 7

call ini\_timer

fin: mov al, eoi

out eoi,al

pop ax

pop bx

iret

pausar\_timer: push ax

or al,10b

out imr,al

pop ax

ret

org 2000h

call ini\_pic

loop:

cmp pausa,0

jz loop

call pausar\_timer

esperar:

cmp pausa, 0FFh

jz esperar

call ini\_timer

jmp loop

int 0

end