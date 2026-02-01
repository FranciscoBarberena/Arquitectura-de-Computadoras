.data
vector: .word 1,-1,2,-2,3,-3,4,-4,-5,-5
pos: .byte 0

.code

daddi $a0,$0,vector
daddi $a1,$0,10
jal contar_positivos
sb $v0,pos($0)
halt

contar_positivos:
ld $t0, vector ($t1)
slti $t3,$t0,1
bnez $t3, seguir
daddi $v0,$v0,1

seguir:
    daddi $a1,$a1,-1
    daddi $t1,$t1,8
    bnez $a1,contar_positivos
jr $ra
