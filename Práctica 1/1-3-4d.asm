org 1000h
a db 51 ;al
b db 6 ;ah
res dw 0 ;ax

org 3000h
MUL:
  mov bx, sp
  add bx, 2
  mov ch, [bx+2]
  mov cl, [bx]
  loop:
    add ax,[bx]
    dec ch
    cmp ch,0
    jz fin
    jmp loop
  fin: ret

org 2000h
mov al,b
mov ah,0
push ax
mov al,a
mov ah,0
push ax
mov ax,0
call mul
hlt
end

