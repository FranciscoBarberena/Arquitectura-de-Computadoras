.data
V: .word 5,2,6
suma: .word 0

.code
daddi $t5,$0,24 ;$t5 es el valor que tiene el desplazamiento cuando termina 
daddi $t1,$0,0 ;$t1 es el dezplazamiento
daddi $t3,$0,0 ;t3 es la suma acumulada de los valores
loop: ld $t0, V($t1)
      dadd $t3,$t3,$t0
      daddi $t1, $t1, 8
      bne $t5, $t1, loop ;checkeo si es el ultimo (desplazamiento = 24)
      sd $t3, suma($0)
halt