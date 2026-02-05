pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h
cont equ 10h
comp equ 11h
eoi equ 20h
num_timer equ 20
int1 equ 25h
imr equ 21h

org 80
dw rut_timer

org 1000h
estado_llaves db ?
termino_timer db 0

org 1500h
ini_pio: 
  mov al, 0FFh
  out ca,al
  mov al, 0
  out cb,al
  ret

ini_timer: 
  mov al, 11111101b
  out imr,al
  mov al, 12
  out comp,al
  mov al,0
  out cont,al
  ret

ini_pic: 
  cli
  mov al,0FFh
  out imr,al
  mov al,num_timer
  out int1,al
  sti
  ret

rut_timer: 
  push ax
  not termino_timer
  mov al, eoi
  out eoi, al
  pop ax
  iret

Luces_12: 
  mov bx, sp
  add bx, 2
  mov bx, [bx]
  mov al, [bx]
  and al, 10000000b
  jz fin
  mov al,0FFh
  out pb,al
  call ini_timer
  esperar:
    cmp termino_timer,0FFh
    jnz esperar
  not termino_timer
  mov al,0
  out pb,al
  fin: 
    ret

org 2000h
call ini_pio
call ini_pic
loop:
  in al, pa
  mov estado_llaves,al
  mov bx, offset estado_llaves
  push bx
  call Luces_12
  jmp loop
int 0
end