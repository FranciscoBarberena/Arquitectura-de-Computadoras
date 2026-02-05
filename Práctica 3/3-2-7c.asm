EOI equ 20h
IMR equ 21h
INT2 equ 26h
data equ 40h
state equ 41h
n_handshake equ 10

org 40
IP_handshake dw rut_handshake

org 1000h
longitud db 10
msj db ?

org 1500h
leer_string: 
  mov bx, offset msj
  mov dl, longitud
  seguir: 
    int 6
    inc bx
    dec dl
    jnz seguir
  ret

ini_pic:
  mov bx, offset msj
  call ini_handshake
  mov al, n_handshake
  out int2,al
  mov al,11111011b
  out imr,al
  sti
  ret

ini_handshake: 
  push ax
  mov al, [bx]
  out data,al
  or al,10000000b
  out state,al
  pop ax
  ret

rut_handshake: 
  push ax
  inc bx
  dec dl
  mov al, [bx]
  out data,al
  mov al, eoi
  out eoi,al
  pop ax
  iret

org 2000h
cli
call leer_string
mov dl, longitud
call ini_pic
loop:
  cmp dl, 1
  jnz loop
int 0
end