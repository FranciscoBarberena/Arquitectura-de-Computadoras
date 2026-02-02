.data
vector: .byte 0, 1

.code
daddi $a1,$0, 10
jal fibonacci
halt

fibonacci:
    daddi $t0,$0,2 ;$t0 es desplazamiento
    loop:
        daddi $t0,$t0,-2
        lb $t1,vector($t0)
        daddi $t0,$t0,1
        lb $t2,vector($t0)
        dadd $t3,$t1,$t2
        daddi $t0,$t0,1
        sb $t3,vector($t0)
        daddi $t0,$t0,1
        daddi $a1, $a1,-1
        bnez $a1, loop
jr $ra