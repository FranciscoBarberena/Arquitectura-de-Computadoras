org 1000h
NUMERO db "0"
LF db 10

org 2000h
mov bx, offset NUMERO
mov al,1
bucle: 
  int 7
  mov bx, offset LF
  int 7
  mov bx, offset NUMERO
  inc byte ptr [bx]
  cmp byte ptr [bx], 58
  jnz bucle
int 0
end