org 1000h
a db 51 ;al
b db 6 ;ah
res dw 0 ;ax

org 3000h
MUL: 
  mov ch, ah
  mov dx,0
  mov dl,al
  mov ah,0
  loop:
    dec ch
    cmp ch,0
    jz fin
    add ax,dx
    jmp loop
  fin: ret

org 2000h
mov al,a
mov ah,b
call mul
mov res,ax
hlt
end