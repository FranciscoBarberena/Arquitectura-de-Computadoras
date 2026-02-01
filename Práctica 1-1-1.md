# Escribir un programa que declare un string llamado MENSAJE, almacenado en la memoria de datos, cuente la cantidad de veces que la letra ‘a’ (minúscula) aparece en MENSAJE y lo almacene en la variable CANT. Por ejemplo, si MENSAJE contiene “Hola, Buenas Tardes”, entonces CANT debe valer 3.

org 1000h

MENSAJE db "tengo 5 aaaaa"

fin db ?

cant db 0

a db "a"

org 2000h

mov bx, offset mensaje

mov cx,0h

checkeo: cmp byte ptr \[bx\],61h

jz es\_a

inc bx

cmp bx, offset fin

jnz checkeo

jmp endd

es\_a: inc cl

inc bx

cmp bx, offset fin

jnz checkeo

mov cant, cl

endd: hlt

end