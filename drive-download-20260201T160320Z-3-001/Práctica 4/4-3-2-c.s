.data
vector: .word 1,-1,2,-2,3,160,4,-4,-5,-5

.code

daddi $a0,$0,vector
daddi $a1,$0,10
jal modificar
halt

modificar:
    ld $t0, vector ($t1)
    daddi $t5,$0,2
    dmul $t0,$t0,$t5
    sd $t0,vector ($t1)
    daddi $a1, $a1, -1
    daddi $t1,$t1,8
    bnez $a1,modificar
jr $ra
