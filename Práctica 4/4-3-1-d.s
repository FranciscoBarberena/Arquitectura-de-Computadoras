.data
string: .ascii ""

.code
daddi $t0,$0,97 ;ascii de a minuscula
daddi $t1,$t0,-96 ;cantidad de apariciones de la letra
daddi $t3,$0,0 ;desplazamiento
daddi $s0,$0,105 ;ascii de h+1
loop: 
    sb $t0, string($t3) ;guarda de a un byte (por eso sb)
    daddi $t1,$t1,-1
    beqz $t1, cambio
    daddi $t3,$t3,1
    j loop
cambio:
    daddi $t0,$t0,1 ;siguiente letra
    daddi $t1,$t0,-96 ;cantidad de apariciones (ascii-96)
    daddi $t3,$t3,1 ;aumento desplazamiento
    beq $s0,$t0,fin
    j loop
fin:
    sb $0,string($t3) ;guarda 0 para marcar fin de cadena
    halt
