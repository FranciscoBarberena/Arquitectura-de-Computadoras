.data
tabla: .word 20,1,14,7,12,11
num: .word 7
long: .word 6
res: .word 0

.code
ld $t1,long($0)
ld $t2,num($0)
dadd $t3,$0,$0
dadd $t9,$0,$0
loop:
    ld $t4,tabla($t3)
    beq $t4,$t2,listo
    daddi $t1,$t1,-1
    bnez $t1,loop
    daddi $t3,$t3,8
    j fin
listo:
    daddi $t9,$0,1
    fin:
        sd $t9,res($0)
halt