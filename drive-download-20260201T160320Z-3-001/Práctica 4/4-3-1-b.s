.data
cadena: .asciiz "ArquiTectuRa de ComPutaDoras"
cant: .word 0
car: .ascii " "

.code
daddi $t0,$0,0 ;$t0 es cant
daddi $t1,$0,cadena ;$t1 es vector
daddi $t2,$0,0 ;$t2 es desplazamiento
lb $t5,car($0) ;$t5 es el caracter a contar
loop:
    lb $t3,cadena($t2) ;$t3 es el caracter del string, ocupa 1 byte
    beqz $t3,fin
    daddi $t2,$t2,1
    bne $t3,$t5,seguir ;checkea si cumple
    daddi $t0,$t0,1
seguir:
    j loop
fin: 
    sd $t0, cant($0)
    halt