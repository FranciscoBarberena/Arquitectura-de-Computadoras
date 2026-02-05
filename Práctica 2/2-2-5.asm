;A)
data equ 40h
state equ 41h

org 1000h
msj db "INGENIERÍA E INFORMÁTICA"
fin db ?

org 1500h

poll: 
  push ax
  in al, state
  and al, 1
  pop ax
  jnz poll
  ret

imprimir_caracter_hand:
  call poll
  out data, al
  call poll
  jmp imprimir_palabra
  ret

imprimir_palabra:
  mov al, [bx]
  inc bx
  cmp bx, offset fin +1
  jnz imprimir_caracter_hand
  ret

org 2000h
mov bx, offset msj
mov cx,6
call imprimir_palabra
int 0
end

;B) A diferencia del PIO, el handshake no necesita configuración manual, ya que está hecho específicamente
;para impresoras. Esto lo hace mejor para este uso específico, pero menos versátil, ya que no se 
;pueden configurar qué bits son de salida o de entrada