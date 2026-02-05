num_f10 equ 10
pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h
imr equ 21h
eoi equ 20h
int0 equ 24h

org 40
dw rut_f10

org 1000h
msj db ?

org 1500h
ini_pio: 
  mov al,0
  out cb,al
  mov al, 11111101b
  out ca,al
  ret

ini_pic: 
  cli
  mov al, 0Feh
  out imr,al
  mov al, num_f10
  out int0,al
  sti
  ret

leer_string: 
  int 6
  inc bx
  inc cl
  jmp leer_string
  ret

rut_f10: 
  push ax
  mov bx, offset msj
  poll: 
    in al, pa
    and al,1
    jnz poll
    mov al, [bx]
    out pb, al
    in al, pa
    or al,02h
    out pa, al
    and al, 0fdh
    out pa, al
    inc bx
    dec cl;contador
    jnz poll
  mov al, eoi
  out eoi, al
  pop ax
  int 0
  iret

org 2000h
call ini_pio
call ini_pic
mov cx,0
mov bx, offset msj
call leer_string
int 0
end