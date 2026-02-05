PA EQU 30h
CA EQU 32h
cb equ 33h
pb equ 31h

org 2000h
mov al, 0ffh
out ca, al
mov al,0h
out cb, al
mov al,11000011b
out pb, al
fin:
  int 0
  end
