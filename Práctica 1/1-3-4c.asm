org 1000h
a db 51 ;al
b db 5 ;ah
res dw 0 ;ax

org 3000h
MUL: 
  mov ch, ah
  mov dx,0
  mov dl,al
  mov ah,0
  loop: 
    add [bx],dx
    dec ch
    cmp ch,0
    jnz loop
  fin: ret
org 2000h

mov al,a
mov ah,b
mov bx, offset res
call mul
hlt
end