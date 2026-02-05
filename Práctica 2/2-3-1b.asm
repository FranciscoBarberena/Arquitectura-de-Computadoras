;Esta resolución está modificada para que funcione en el simulador, imprimiendo en pantalla 
;el caracter ASCII del que uno escribe el binario usando las llaves 
;(hay asegurarse de que no estén todas las llaves apagadas, sino manda 0 y termina)

pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

org 1000h
var db ?

org 1500h
ini_pio:
  mov al, 0h
  out cb, al
  mov al,0ffh
  out ca, al
  ret
  
cpu_ready: 
  mov al,0FFh
  out pb, al
  ret
  
org 2000h
mov bx, offset var
call ini_pio
loop: 
  call cpu_ready
  in al, pa
  push ax
  mov var, al
  mov bx, offset var
  mov al,1
  int 7
  pop ax
  cmp al,0
  jz fin
  jmp loop
fin: 
  int 0
end