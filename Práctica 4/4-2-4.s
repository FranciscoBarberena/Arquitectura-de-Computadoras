.data
base: .word 2
exponente: .word 4
result: .word 0

.code
daddi $a0,$0,base ;es como hacer mov $a0, offset base
daddi $a1,$0,exponente ;es como hacer mov $a0, offset exponente
jal potencia
sd $v0, result($0)
halt

potencia: 

    daddi $v0,$0,1
    ld $t0,0($a0) ;es como hacer mov t0,[a0]
    ld $t1,0($a1) ;es como hacer mov t1,[a1]

loop: 
    beqz $t1,terminar
    daddi $t1,$t1,-1
    dmul $v0,$v0,$t0
    j loop
terminar: 
    jr $ra