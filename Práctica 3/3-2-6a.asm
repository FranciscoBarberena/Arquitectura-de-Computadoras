eoi equ 20h
IMR equ 21h
INT0 equ 24h
INT1 equ 25h
CONT equ 10h
COMP equ 11h

org 40
dw rut_timer

org 80 
dw rut_f10

org 1000h
valor db ?
fin db ?

org 3000h
ini_pic: 
  cli
  mov al,11111110b
  out IMR,al
  mov al, 10
  out int1,al
  mov al, 20
  out int0,al
  sti
  ret

rut_f10: 
  push ax
  push bx
  mov bx, offset valor
  int 6
  cmp valor, 58
  jns basta
  cmp valor, 47
  js basta
  call ini_timer
  mov al,eoi
  out eoi,al
  pop bx
  pop ax
  iret

ini_timer: 
  push ax
  mov al, 1
  out comp,al
  in al, imr
  and al, 11111101b
  out imr, al
  mov al,0
  out cont,al
  pop ax
  ret

rut_timer: 
  push ax
  push bx
  mov ax,1
  mov bx, offset valor
  int 7
  dec valor
  cmp valor,'0'-1
  jz basta
  call ini_timer
  fin_int: 
    mov al,eoi
    out eoi,al
    pop bx
    pop ax
    iret

org 2000h
call ini_pic
loop:
  cmp valor,'0'-1
  jz basta
  jmp loop
basta: 
  and al, 11111101b
  out imr,al
  hlt
  end
