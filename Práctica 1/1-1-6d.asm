org 1000h
cant db 0
carac db ?

org 2000h
mov bx, offset carac - 1
mov cx, 0
leer_caracter: 
  inc bx
  int 6
  cmp byte ptr [bx], 46
  jz es_punto
  inc cant
  es_punto: 
    cmp byte ptr [bx], 46
    jnz leer_caracter
mov byte ptr [bx], 00
mov al, cant
mov bx, offset carac
int 7
hlt
end