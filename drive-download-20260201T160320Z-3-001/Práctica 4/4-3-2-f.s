.data
vector: .byte 0,1,2,3,4,5,6,7,8,9
vectorImpares: .byte 0

.code

.code
daddi $a1,$0, 10
jal seleccionar_impares
halt

seleccionar_impares:
    lb $t0, vector($t1) ;carga elemento en $t0, con desplazamiento $t1
    andi $t2,$t0,1 ;checkea si es par o impar
    beqz $t2, seguir ;si es par, salta y avanza
    sb $t0, vectorImpares($t5) ;si es impar, guarda en el nuevo vector
    daddi $t5, $t5, 1 ;si es impar, aumenta el desplazamiento del nuevo vector ($t5)

seguir:
    daddi $a1,$a1,-1
    daddi $t1, $t1, 1
    bnez $a1,seleccionar_impares
jr $ra
