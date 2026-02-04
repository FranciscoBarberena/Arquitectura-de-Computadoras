org 1000h
cant db 0
carac db ?

org 2000h
mov bx, offset carac
mov cx, 0
leer_caracter: 
  int 6
  inc cant
  cmp carac, 46
  jnz leer_caracter
hlt
end

