.data
vector: .word 1,-1,2,-2,3,160,4,-4,-5,-5
max: .word 0

.code

daddi $a0,$0,vector
daddi $a1,$0,10
jal calcular_max
sd $v0, max($0)
halt

calcular_max:
    daddi $v0,$v0,-32768
    loop:
        ld $t0, vector ($t1)
        slt $t2, $t0,$v0
        bnez $t2, seguir
        dadd $v0,$0,$t0
    seguir:
        daddi $a1,$a1,-1
        daddi $t1,$t1,8
        bnez $a1,loop
jr $ra
