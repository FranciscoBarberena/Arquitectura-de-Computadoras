# eoi equ 20h

IMR equ 21h

INT1 equ 25h

CONT equ 10h

COMP equ 11h

org 40

dw rut\_timer

org 1000h

msj db "Vamos las interrupciones!",10

fin db ?

org 3000h

ini\_pic: cli

mov al,11111101b

out IMR,al

mov al, 10

out int1,al

mov dx,5

sti

ret

ini\_timer:

push ax

mov al,2

out comp,al

mov al,0

out cont,al

pop ax

ret

rut\_timer:

push ax

push bx

dec dx

mov bx, offset msj

mov al, offset fin - offset msj

int 7

mov al,eoi

out eoi,al

call ini\_timer

pop bx

pop ax

iret

org 2000h

call ini\_pic

call ini\_timer

loop: cmp dx,0

jnz loop

int 0

end

c)

eoi equ 20h

IMR equ 21h

INT1 equ 25h

CONT equ 10h

COMP equ 11h

org 40

dw rut\_timer

org 1000h

msj db "Vamos las interrupciones!",10

fin db ?

org 3000h

ini\_pic: cli

mov al,11111101b

out IMR,al

mov al, 10

out int1,al

mov dx,1

sti

ret

ini\_timer:

push ax

mov al,10

out comp,al

mov al,0

out cont,al

pop ax

ret

rut\_timer:

push ax

push bx

dec dx

mov bx, offset msj

mov al, offset fin - offset msj

int 7

mov al,eoi

out eoi,al

pop bx

pop ax

iret

org 2000h

call ini\_pic

call ini\_timer

loop: cmp dx,0

jnz loop

int 0

end

d)

eoi equ 20h

IMR equ 21h

INT1 equ 25h

CONT equ 10h

COMP equ 11h

org 40

dw rut\_timer

org 1000h

msj db "Vamos las interrupciones!",10

fin db ?

org 3000h

ini\_pic: cli

mov al,11111101b

out IMR,al

mov al, 10

out int1,al

mov dx,0

sti

ret

ini\_timer:

push ax

mov al,1

out comp,al

mov al,0

out cont,al

pop ax

ret

aumentar\_comp:

in al,comp

inc al

out comp,al

mov al,0

out cont,al

ret

rut\_timer:

push ax

push bx

inc dx

mov bx, offset msj

mov al, offset fin - offset msj

int 7

mov al,eoi

out eoi,al

call aumentar\_comp

pop bx

pop ax

iret

org 2000h

call ini\_pic

call ini\_timer

loop: cmp dx,255

jnz loop

int 0

end