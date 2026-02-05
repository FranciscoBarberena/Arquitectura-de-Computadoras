pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

org 1000h
msj db "ORGANIZACION Y ARQUITECTURA DE COMPUTADORAS"
fin db ?

org 1500h
flanco_ascendente:
  push ax
  and al,1
  out pa,al
  or al,10b
  out pa, al
  pop ax
  ret

ini_pio:
  push ax
  mov al, 0h
  out cb, al
  mov al, 1h
  out ca, al
  pop ax
  ret

poll: 
  push ax
  in al, pa
  and al, 1
  pop ax
  jnz poll
  ret

imprimir_caracter:
  call poll
  out pb, al
  call flanco_ascendente
  call poll
  jmp imprimir_palabra
  ret

imprimir_palabra:
  mov al, [bx]
  inc bx
  cmp bx, offset fin +1
  jnz imprimir_caracter
  ret

org 2000h
call ini_pio
mov bx, offset msj
call imprimir_palabra
int 0
end