.data
V: .word 5,2,6
suma: .word 0

.code
daddi $t5,$0,suma ;fin del vector em t5
daddi $t2,$0,V ;direccion del vector en t2
loop:
    ld $t0, 0($t2) ;dato del vector en t0
    dadd $t3,$t3,$t0 ;suma total en t3
    daddi $t2,$t2,8 ;aumento en 8 la direccion para pasar de elemento
    bne $t2,$t5,loop ;checkeo que no sea fin
sd $t3, suma($0)
halt