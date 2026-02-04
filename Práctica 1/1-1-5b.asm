org 1000h
NUMERO db "0"

org 2000h

mov bx, offset NUMERO
mov al, 1
bucle: 
  int 7
  inc NUMERO
  cmp NUMERO, 58
  jnz bucle
  int 0
end
