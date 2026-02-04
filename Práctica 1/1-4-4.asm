org 1000h
cantCaracteres db 0
cantVocales db 0
cantConsonantes db 0
cantLetras db 0
tieneX db 0
cadena db ?

org 1500h
leer_string:
  mov al,0
  mov bx, offset cadena
  leer:
    int 6
    cmp byte ptr [bx],'.'
    jz fin
    inc al
    inc bx
    jmp leer
  fin: ret
  
ES_LETRA:;recibe caracter en cl. Retorna boolean en CH
  cmp cl,'z'+1
  jns no_es
  cmp cl,'a'
  jns es
  cmp cl, 'A'
  js no_es
  cmp cl,'Z'
  js es
  no_es: mov ch,0h
  jmp terminar
  es: mov ch, 0ffh
  terminar: ret
  
ES_VOCAL:;recibe caracter en cl. Retorna boolean en CH
  cmp cl,'A'
  jz es
  cmp cl,'E'
  jz es
  cmp cl,'I'
  jz es
  cmp cl,'O'
  jz es
  cmp cl,'U'
  jz es
  cmp cl,'a'
  jz es
  cmp cl,'e'
  jz es
  cmp cl,'i'
  jz es
  cmp cl,'o'
  jz es
  cmp cl,'u'
  jz es
  jmp no_es
  ret
  
contar_letras:;recibe cadena en bx, cantCaracteres en cl. Devuelve AL
  mov al,0
  loop:
    push cx
    mov cl,[bx]
    call es_letra
    cmp ch,0FFH
    pop cx
    jnz seguir3
    inc al
    seguir3: inc bx
    dec cl
    jnz loop
  ret
  
contar_voc: ;recibe cadena en bx, cantCaracteres en cl. Devuelve AL
  mov al,0
  sig_caracter:
  push cx
  mov cl,[bx]
  call es_vocal
  cmp ch,0ffh
  pop cx
  jnz seguir
  inc al
  seguir: inc bx
  dec cl
  jnz sig_caracter
  ret
  
es_consonante:;recibe caracter en cl
  call es_letra
  cmp ch,0
  jz no_es
  call es_vocal
  cmp ch, 0
  jnz no_es
  jmp es
  ret
contar_consonantes: ;recibe cadena en bx, cantCaracteres en cl. Devuelve AL
  mov al,0
  avanzar_caracter:
  push cx
  mov cl,[bx]
  call es_consonante
  cmp ch,0ffh
  pop cx
  jnz seguirr
  inc al
  seguirr:
  inc bx
  dec cl
  jnz avanzar_caracter
  ret
contiene: ;recibe string en bx, caracter en cl y longitud en dl. Devuelve AL
  mov al, 0
  sig:
  cmp[bx],cl
  jz true
  inc bx
  dec dl
  jnz sig
  jmp terminar
  true: not al
  ret
  ret

org 2000h
push ax
call leer_string
cmp cadena,'.'
jz vacio
mov cantCaracteres, al
pop ax
mov bx, offset cadena
push ax
mov cl, cantCaracteres
call contar_voc
mov cantVocales,al
pop ax
push ax
mov bx, offset cadena
mov cl, cantCaracteres
call contar_consonantes
mov cantConsonantes,al
pop ax
push ax
mov bx, offset cadena
mov cl, cantCaracteres
call contar_letras
mov cantLetras,al
pop ax
mov bx, offset cadena
mov cl, 'x'
mov dl,cantCaracteres
push ax
call contiene
mov tieneX,al
pop ax
vacio:
hlt
end