eoi equ 20h
IMR equ 21h
INT1 equ 25h
CONT equ 10h
COMP equ 11h

org 40
dw rut_timer

org 1000h
msj db "Vamos las interrupciones!",10
fin db ?

org 3000h
ini_pic: 
  cli
  mov al,11111101b
  out IMR,al
  mov al, 10
  out int1,al
  mov dx,1
  sti
  ret


ini_timer: 
  push ax
  mov al,10
  out comp,al
  mov al,0
  out cont,al
  pop ax
  ret

rut_timer: 
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
call ini_pic
call ini_timer
loop: 
  cmp dx,0
  jnz loop
int 0
end
