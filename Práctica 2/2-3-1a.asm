pa equ 30h
pb equ 31h
ca equ 32h
cb equ 33h

org 1500h

ini_pio:
  mov al, 0h
  out cb, al
  ret

pb_0:
  push ax
  mov al,0
  out pb,al
  pop ax
  ret

org 2000h
call ini_pio
call pb_0
mov al,85
out pb,al
call pb_0
mov al,78
out pb, al
call pb_0
mov al, 76
out pb, al
call pb_0
mov al, 80
out pb, al
mov al,255
out pb, al
int 0
end