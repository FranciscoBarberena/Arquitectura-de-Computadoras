pb equ 31h
cb equ 33h
imr equ 21h
eoi equ 20h
comp equ 11h
cont equ 10h
int0 equ 24h
STATE equ 41h
DATA equ 40h
num_f10 equ 10

org 40
dw rut_f10

org 1000h
msj db "Ingrese un número del 1 al 9: ",10
fin db ?
digito db 0
apreto db 0

org 1500h
ini_pic: 
  cli
  mov al, 11111110b
  out imr, al
  mov al, num_f10
  out int0,al
  sti
  ret

rut_f10:
  push ax
  mov apreto,1
  mov al,0
  out state,al
  mov al,digito
  push ax
  call descender
  mov al, eoi
  out eoi,al
  pop ax
  pop ax
  iret

leer_digito: 
  push bx
  push ax
  intentar:
    mov bx, offset msj
    mov al, offset fin - offset msj
    int 7
    mov bx,offset digito
    int 6
    cmp digito, 49
    js intentar
    cmp digito, 58
    jns intentar
  pop ax
  pop bx
  ret

descender: 
  mov bx,sp
  add bx,2
  poll: 
    in al,state
    and al,1
    jnz poll
  mov al, [bx]
  out data, al
  dec al
  mov [bx],al
  cmp al, 47
  jnz poll
  ret

org 2000h
call ini_pic
call leer_digito
esperar: 
  cmp apreto,0
  jz esperar
int 0
end