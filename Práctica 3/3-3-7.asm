pb equ 31h
cb equ 33h
imr equ 21h
eoi equ 20h
comp equ 11h
cont equ 10h
int0 equ 24h
int1 equ 25h
num_timer equ 20
num_f10 equ 10

org 40
dw rut_f10

org 80
dw rut_timer

org 1000h
msj db "Hola!0"
fin db ?

org 1500h
ini_pic: 
  cli
  mov al, 11111101b
  out  imr,al
  mov al, num_timer
  out int1,al
  mov al, num_f10
  out int0,al
  sti
  ret

ini_pio: 
  mov al,0
  out cb,al
  ret

reset_timer:
  mov al, 5
  out comp, al
  mov al, 0
  out cont,al
  ret

rut_timer: 
  push ax
  mov al, [bx]
  out pb, al
  inc bx
  dec cl
  mov al, eoi
  out eoi,al
  pop ax
  call reset_timer
  iret

deshabilitar_timer:
  in al,imr
  or al,10b
  out imr,al
  ret

rut_f10: 
  push ax
  call deshabilitar_timer
  mov cl,1
  mov al, eoi
  out eoi,al
  pop ax
  iret

org 2000h
mov cx, offset fin - offset msj
call ini_pic
call ini_pio
mov bx, offset msj
mov al, [bx]
inc bx
dec cl
out pb, al
call reset_timer
esperar: 
  cmp cl, 1
  jnz esperar
call deshabilitar_timer
int 0
end