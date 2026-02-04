org 1000h
num1 dw 0
num2 dw 0
longitud dw 0
resultadoMultiplicacion dw ?
cocienteDivision dw ? ;Acá se almacena el porcentaje de aprobados, es la celda 1008h
restoDivision dw ?
resultadoPorcentaje dw ?
cantAprobados dw ?
promedio dw ?
sumaVector dw ?
vector db ?

org 3000h
CANT_APROBADOS:
  cmp byte ptr [bx],'.'
  jz listo
  cmp byte ptr [bx],4
  js seguirr
  inc cx
  seguirr:
  inc bx
  dec ax
  jnz CANT_APROBADOS
  listo: ret
  
div: ;recibe op1 en cx y op2 en dx. Devuelve cociente en AX y resto en bx
  cmp dx,0
  jz division_por_cero
  mov ax,0
  restar:
  cmp cx,dx
  js terminar_division
  jz sin_resto
  sub cx,dx
  inc ax
  jmp restar
  terminar_division:
  mov bx,cx
  jmp fin
  sin_resto:
  inc ax
  mov bx,0
  jmp fin
  division_por_cero: mov ax,-1
  mov bx,-1
  fin: ret
  
mul: ;recibe op1 en cx y op2 en dx. Devuelve resultado en AX
  mov ax,0
  cmp dx,0
  jz terminar_mul
  sumar:
  add ax,cx
  dec dx
  jnz sumar
  terminar_mul:ret
  
porcentaje:;recibe cantAprobados en AX y cantNotas en BX. Devuelve cociente en AX y resto en bx
  mov cx,ax
  mov dx,100
  push ax
  call mul
  mov cx,ax
  pop ax
  mov dx,bx
  call div
  ret

sumarVector:; recibe direccion de vector en bx y longitud en ax. Devuelve sumaVector en cx
  mov cx,0
  loop:
    add cl, [bx]
    inc bx
    dec ax
    cmp ax,0
    jnz loop
  ret

org 2000h
mov bx, offset vector
leer_nota:
  int 6
  cmp byte ptr [bx],'.'
  jnz seguir
  jmp termino
  seguir:
    sub byte ptr [bx],48
    inc bx
    inc longitud
    jmp leer_nota
termino:
  mov ax, longitud
  mov cx,0
  mov bx, offset vector
  call CANT_APROBADOS
  mov cantAprobados,cx
  mov cx,num1
  mov dx,num2
  push ax
  call mul
  mov resultadoMultiplicacion,ax
  pop ax
  push cx
  mov ax,cantAprobados
  mov bx, longitud
  call porcentaje
  mov cocienteDivision,ax ;Almacena porcentaje de aprobados en memoria (1008h)
  mov restoDivision,bx
  mov bx, offset vector
  mov ax, longitud
  call sumarVector
  mov sumaVector, cx
  mov cx, sumaVector
  mov dx, longitud
  call div
  mov promedio, ax
  add promedio, 48
  mov bx, offset promedio
  mov al, 1
  int 7 ;imprime promedio
hlt
end