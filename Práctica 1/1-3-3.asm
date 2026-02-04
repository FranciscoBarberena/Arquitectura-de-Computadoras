org 1000h
mensaje db "FULL MAYUSCULA"
aux db ?

org 3000h
ES_MAYUS:
  mov cl, [bx]
  cmp cl, 91
  jns no
  jmp seguir
  no: 
    mov ah, 0
  jmp seguirr
  jmp fin
  seguir:
  cmp cl, 64
  js no
  mov ah, 0FFh
  cmp ah,0
  jnz A_MINUS
  jmp seguirr
  fin: 
    ret

A_MINUS:
add byte ptr[bx], 32
seguirr: inc bx
dec al
cmp al,0
jnz string_a_minus
ret


STRING_A_MINUS: jmp ES_MAYUS
ret

org 2000h
mov ch,0
mov bx, offset mensaje
mov al,offset aux - offset mensaje
call STRING_A_MINUS
mov bx, offset mensaje
mov al,offset aux - offset mensaje
int 7
hlt
end