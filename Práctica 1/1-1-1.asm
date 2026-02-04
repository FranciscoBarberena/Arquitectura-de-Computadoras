org 1000h

MENSAJE db "tengo 5 aaaaa"
fin db ?
cant db 0
a db "a"

org 2000h
mov bx, offset mensaje
mov cx,0h

checkeo: cmp byte ptr [bx],61h
jz es_a
inc bx
cmp bx, offset fin
jnz checkeo
jmp endd

es_a: inc cl
inc bx
cmp bx, offset fin
jnz checkeo
mov cant, cl

endd: hlt
end