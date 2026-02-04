org 1000h
LETRA db "A"

org 2000h
mov bx, offset LETRA
mov al, 1
bucle: int 7
inc LETRA
cmp LETRA, 91
jnz bucle
int 0
end

