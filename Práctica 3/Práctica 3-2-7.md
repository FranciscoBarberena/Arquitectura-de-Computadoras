# EOI equ 20h

IMR equ 21h

INT2 equ 26h

data equ 40h

state equ 41h

n\_handshake equ 10

org 40

IP\_handshake dw rut\_handshake

org 1000h

msj db "UNIVERSIDAD NACIONAL DE LA PLATA"

fin db ?

org 1500h

ini\_pic:cli

mov al, n\_handshake

out int2,al

mov bx, offset msj

call ini\_handshake

mov al,11111011b

out imr,al

sti

ret

ini\_handshake:

push ax

mov al, \[bx\]

out data,al

or al,10000001b

out state,al

pop ax

ret

rut\_handshake:

push ax

inc bx

cmp bx, offset fin

jz terminar

mov al, \[bx\]

out data,al

mov al, eoi

out eoi,al

pop ax

iret

org 2000h

call ini\_pic

loop:jmp loop

terminar:

int 0

end

c)

EOI equ 20h

IMR equ 21h

INT2 equ 26h

data equ 40h

state equ 41h

n\_handshake equ 10

org 40

IP\_handshake dw rut\_handshake

org 1000h

longitud db 10

msj db ?

org 1500h

leer\_string:

mov bx, offset msj

mov dl, longitud

seguir:

int 6

inc bx

dec dl

jnz seguir

ret

ini\_pic:

mov bx, offset msj

call ini\_handshake

mov al, n\_handshake

out int2,al

mov al,11111011b

out imr,al

sti

ret

ini\_handshake:

push ax

mov al, \[bx\]

out data,al

or al,10000000b

out state,al

pop ax

ret

rut\_handshake:

push ax

inc bx

dec dl

mov al, \[bx\]

out data,al

mov al, eoi

out eoi,al

pop ax

iret

org 2000h

cli

call leer\_string

mov dl, longitud

call ini\_pic

loop:

cmp dl, 1

jnz loop

int 0

end

d)

EOI equ 20h

IMR equ 21h

INT0 equ 24h

INT2 equ 26h

data equ 40h

state equ 41h

n\_handshake equ 10

n\_f10 equ 20

org 40

IP\_handshake dw rut\_handshake

org 80

IP\_f10 dw rut\_f10

org 1000h

msj db "UNIVERSIDAD NACIONAL DE LA PLATA"

fin db ?

org 1500h

ini\_pic:cli

mov al, n\_handshake

out int2,al

mov al, n\_f10

out int0, al

mov bx, offset msj

call ini\_handshake

mov al,11111010b

out imr,al

sti

ret

rut\_f10: push ax

or al, 100b

out imr, al

mov al, eoi

out eoi, al

pop ax

iret

ini\_handshake:

push ax

mov al, \[bx\]

out data,al

or al,10000001b

out state,al

pop ax

ret

rut\_handshake:

push ax

inc bx

cmp bx, offset fin

jz terminar

mov al, \[bx\]

out data,al

mov al, eoi

out eoi,al

pop ax

iret

org 2000h

call ini\_pic

loop:

in al, imr

and al,100b

jz loop

terminar:

int 0

end