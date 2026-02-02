# eoi equ 20h

IMR equ 21h

INT0 equ 24h

org 40

dw rut\_f10

org 1000h

msj db "Vamos las interrupciones!",10

fin db ?

org 3000h

ini\_pic: cli

mov al,0FEh

out IMR,al

mov al, 10

out int0,al

mov dx,5

sti

ret

rut\_f10:

push ax

push bx

mov bx, offset msj

mov al, offset fin - offset msj

int 7

dec dx

jnz seguir

mov al,0FFh

out IMR,al

seguir: mov al,eoi

out eoi,al

pop bx

pop ax

iret

org 2000h

call ini\_pic

loop: cmp dx,0

jnz loop

int 0

end