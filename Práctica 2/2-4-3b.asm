pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

org 1000h
mensaje db "ACTIVADO"
patron db 10000001b

org 1500h
ini_pio:
  push ax
  mov al, 0h
  out cb, al
  mov al, 0FFh
  out ca,al
  pop ax
  ret

imprimir_mensaje:
  push bx
  push ax
  mov bx, offset mensaje
  mov al, offset patron - offset mensaje
  int 7
  pop ax
  pop bx
  ret

org 2000h
call ini_pio
loop: 
  in al,pa
  out pb,al
  cmp al, patron
  jnz loop
call imprimir_mensaje
loop2:
  in al, pa
  cmp al, patron
  jnz loop
  jmp loop2
int 0
end