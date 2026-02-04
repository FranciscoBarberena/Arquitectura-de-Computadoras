org 1000h
a db 51 ;al
b db 5 ;ah
res dw 0 ;ax

org 3000h
MUL:
  push cx
  push dx
  mov ax,0
  mov cx,0
  mov dx,0
  mov bx, sp
  add bx, 6
  mov bx, [bx]
  mov ch, [bx+1]
  mov dl, [bx]
  loop:
    add ax, dx
    dec ch
    jz fin
    jmp loop
  fin: 
    pop dx
    pop cx
    ret

org 2000h
mov ax,offset b
push ax
mov ax,offset a
push ax
call mul
hlt
end