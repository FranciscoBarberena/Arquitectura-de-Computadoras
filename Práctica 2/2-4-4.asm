pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

org 1000h
mensaje db "Arquitectura de computadoras: ACTIVADA "
mensaje_fin db "Fin del programa"
fin db ?

org 1500h
ini_pio:
  push ax
  mov al, 0h
  out cb, al
  mov al, 0FFh
  out ca,al
  pop ax
  ret

function_a: 
  in al, pa
  cmp al, 0
  jz fin_programa
  ret

fin_programa:
  mov dl,1
  mov bx, offset mensaje_fin
  mov ax, offset fin - offset mensaje_fin
  int 7
  int 0
  ret

function_b: 
  in al, pa
  not al
  out pb, al
  ret

function_c: 
  in al, pa
  and al,1
  jnz arqui
  ret

arqui: 
  mov bx, offset mensaje
  mov ax, offset mensaje_fin - offset mensaje
  int 7
  ret

org 2000h
mov dl,0
call ini_pio
loop: 
  call function_a
  call function_b
  call function_c
  cmp dl,0
  jz loop
call fin_programa
end