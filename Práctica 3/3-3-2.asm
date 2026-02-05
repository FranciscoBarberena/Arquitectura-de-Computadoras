int0 equ 24h
pb equ 31h
cb equ 33h
num_f10 equ 10
eoi equ 20h
imr equ 21h

org 40
dw rut_f10

org 3000h
ini_pio: 
  mov al, 0h
  out cb, al
  mov al, 0
  out pb,al
  ret

rut_f10: 
  push ax
  in al, pb
  not al
  out pb,al
  mov al, eoi
  out eoi, al
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
call ini_pio
call ini_pic
loop: 
  jmp loop
int 0 
end
