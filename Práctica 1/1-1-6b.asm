org 1000h
cant db 0
carac db ?

org 2000h
mov bx, offset carac
mov cx, 0
leer_caracter: 
  int 6
  cmp carac, 97
  jnz no_es_a
  inc cant
  no_es_a: 
    cmp carac, 46
  jnz leer_caracter
hlt
end

