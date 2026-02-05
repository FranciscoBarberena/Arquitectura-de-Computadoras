EOI equ 20h
IMR equ 21h
INT2 equ 26h
data equ 40h
state equ 41h
n_handshake equ 10

org 40
IP_handshake dw rut_handshake

org 1000h
msj db "UNIVERSIDAD NACIONAL DE LA PLATA"
fin db ?

org 1500h
ini_pic:
  cli
  mov al, n_handshake
  out int2,al
  mov bx, offset msj
  call ini_handshake
  mov al,11111011b
  out imr,al
  sti
  ret

ini_handshake: 
  push ax
  mov al, [bx]
  out data,al
  or al,10000001b
  out state,al
  pop ax
  ret

rut_handshake: 
  push ax
  inc bx
  cmp bx, offset fin
  jz terminar
  mov al, [bx]
  out data,al
  mov al, eoi
  out eoi,al
  pop ax
  iret

org 2000h
call ini_pic
loop:
  jmp loop
terminar:
  int 0
  end
