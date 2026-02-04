org 1000h
caracter db 1

org 2000h

mov bx, offset caracter
mov al, 1
bucle: 
  int 7
  inc caracter
  cmp caracter, 255
  jnz bucle
  int 7
  int 0
end

