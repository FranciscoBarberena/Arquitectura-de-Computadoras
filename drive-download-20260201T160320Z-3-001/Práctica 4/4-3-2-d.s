.data
vector: .byte 0

.code
daddi $a1,$0, 10
jal impares
halt

impares:
    daddi $t6,$0,0 ; contador
    daddi $t5,$0,2
    loop:
        dmul $t0,$t6,$t5 ; 2 x (posicion del impar del 0 al 9) 
        daddi $t0,$t0,1 ; resultadoAnterior+1
        sb $t0, vector ($t1)
        daddi $t6,$t6,1
        daddi $t1,$t1,1
        bne $a1,$t6,loop
jr $ra