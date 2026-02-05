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
inicio db "PRESIONE F10 PARA EMPEZAR"
fin_inicio db ?
leido db 0
msj db ?

org 1500h
rut_f10: 
  push ax
  push cx
  push bx
  leer_caracter: 
    int 6
    inc bx
    dec cl
    jnz leer_caracter
  not leido
  mov al, eoi
  out eoi, al
  pop bx
  pop cx
  pop ax
  iret

ini_pic: 
  cli
  mov al,0Feh
  out imr,al
  mov al, num_f10
  out int0, al
  sti
  ret

ini_pio: 
  mov al, 0
  out pa, al
  mov al,1
  out ca, al
  mov al, 0
  out cb,al
  ret

pantalla_string: 
  push ax
  push bx
  mov al,offset fin_inicio - offset inicio
  mov bx, offset inicio
  int 7
  pop bx
  pop ax
  ret

imprimir_msj: 
  mov bx, sp
  add bx,2
  mov bx, [bx]
  poll: 
    in al, pa
    and al,1
    jnz poll
  mov al, [bx]
  out pb,al
  in al, pa
  and al, 11111101b
  out pa,al
  or al, 10b
  out pa, al
  inc bx
  dec cl
  jnz poll
  ret

org 2000h
mov cl,10
mov bx, offset msj
call ini_pic
call ini_pio
call pantalla_string
loop:  
  cmp leido, 0
  jz loop
mov bx, offset msj
mov cl,10
push bx
call imprimir_msj
int 0
end
