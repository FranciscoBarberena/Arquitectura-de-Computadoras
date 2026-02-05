EOI equ 20h
IMR equ 21h
INT0 equ 24h
INT1 equ 25h
n_f10 equ 10
n_timer equ 20
cont equ 10h
comp equ 11h

org 40
IP_f10 dw rut_f10

org 80
dw rut_timer

org 1000h
PAUSA db 0
seg db ?

org 1500h
ini_pic: 
  cli
  push ax
  mov al, n_f10
  out int0,al
  mov al, n_timer
  out int1,al
  call ini_timer
  mov seg,'9'+1;
  pop ax
  sti
  ret
  
rut_f10: 
  push ax
  push bx
  mov bx, offset seg
  cmp byte ptr [bx],02Fh
  jnz seguir
  call ini_pic
  call ini_timer
  jmp finn
  seguir: 
    not pausa
  finn:
    mov al, eoi
    out eoi,al
    pop bx
    pop ax
    iret

ini_timer: 
  push ax
  and al,11111100b
  out imr,al
  mov al,0
  out cont,al
  mov al,1
  out comp,al
  pop ax
  ret

rut_timer:
  push bx
  push ax
  mov bx, offset seg
  dec byte ptr [bx]
  cmp byte ptr [bx], '0'-1
  jz fin
  js fin
  mov al,1
  int 7
  call ini_timer
  fin: 
    mov al, eoi
    out eoi,al
    pop ax
    pop bx
    iret

pausar_timer: 
  push ax
  or al,10b
  out imr,al
  pop ax
  ret

org 2000h
call ini_pic
loop:
  cmp pausa,0
  jz loop
call pausar_timer
esperar: 
  cmp pausa, 0FFh
  jz esperar
  call ini_timer
  jmp loop
int 0
end