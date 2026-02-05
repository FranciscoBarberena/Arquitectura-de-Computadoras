int0 equ 24h
num_f10 equ 10
eoi equ 20h
imr equ 21h

org 40
dw rut_f10

org 1000h
numero db ?

org 3000h
rut_f10: 
  push ax
  push bx
  mov bx, offset numero
  mov al,1
  int 7
  mov al, eoi
  out eoi, al
  pop bx
  pop ax
  iret

ini_pic: 
  cli
  mov al, 0feh
  out imr, al
  mov al, num_f10
  out int0,al
  sti
  ret

org 2000h
call ini_pic
mov numero,'0'
loop: 
  inc numero
  cmp numero,'9'
  jnz loop
  mov numero,'0'
  jmp loop
int 0 
end