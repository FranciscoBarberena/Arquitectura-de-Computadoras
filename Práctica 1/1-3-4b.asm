org 1000h
a db 51 ;al
b db 6 ;ah
res dw 0 ;ax

org 3000h
MUL: 
  mov ch, [bx+1]
  mov al,[bx]
  mov dx,0
  mov dl,[bx]
  mov ah,0
  loop:
    dec byte ptr[bx+1]
    cmp byte ptr[bx+1],0
    jz fin
    add ax,dx
    jmp loop
  fin: ret
  
org 2000h
mov bx, offset a
call mul
mov res,ax
hlt
end