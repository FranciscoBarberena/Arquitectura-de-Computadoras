.data
cadena: .asciiz "ArquiTectuRa de ComPutaDoras"
cant: .word 0

.code
daddi $t0,$0,0 ;$t0 es cant
daddi $t1,$0,cadena ;$t1 es vector
daddi $t2,$0,0 ;$t2 es desplazamiento
loop:
    lb $t3,cadena($t2) ;$t3 es el caracter del string, ocupa 1 byte
    beqz $t3,fin
    daddi $t2,$t2,1
    slti $t5,$t3,65
    bnez $t5, seguir ;si es menor a 'A', avanzo en string
    slti $t5,$t3,91
    beqz $t5, seguir ;si es mayor a 'Z', avanzo en string   
    daddi $t0,$t0,1 ;si esta en el rango, incremento y sigo
seguir:
    j loop
fin: 
    sd $t0, cant($0)
    halt