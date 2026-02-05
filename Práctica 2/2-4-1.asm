pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

org 1000h
bait db 00000001b

org 1500h
ini_pio:
  push ax
  mov al, 0h
  out cb, al
  mov al, 0FFh
  out ca,al
  pop ax
  ret
rotar_izq_n:; n es CL (cantidad de rotaciones)
  push bx
  push ax
  mov bx, sp
  add bx, 6
  mov bx, [bx]
  mov al, [bx]
  add [bx],al
  jnc no_hay_carry
  add byte ptr [bx],1
  no_hay_carry:
    pop ax
    pop bx
    dec cl
    jnz rotar_izq_n
    ret
rotar_der_n:; n es CL (cantidad de rotaciones)
  push ax
  mov al,8
  sub al,cl
  mov cl, al
  pop ax
  rotar: 
    push bx
    push ax
    mov bx, sp
    add bx, 6
    mov bx, [bx]
    mov al, [bx]
    add [bx],al
    jnc no_hay_carry2
    add byte ptr [bx],1
    no_hay_carry2:
      pop ax
      pop bx
      dec cl
      jnz rotar
  ret

org 2000h
call ini_pio
inicio: 
  mov dx, 7
loop: 
  mov al, bait
  out pb,al
  mov ax, offset bait
  push ax
  mov cl,1
  call rotar_izq_n
  pop ax
  dec dx
  jnz loop
mov dx, 7
loop2: 
  mov al, bait
  out pb,al
  mov ax, offset bait
  push ax
  mov cl,1
  call rotar_der_n
  pop ax
  dec dx
  jnz loop2
jmp inicio
int 0
end