.data
cant: .word 8
datos: .word 1,2,3,4,5,6,7,8
res: .word 0

.code
dadd $t1,$0,$0
ld $t2,cant($0)

loop:
    ld $t3,datos($t1)
    daddi $t2,$t2,-1
    dsll $t3,$t3,1
    sd $t3,res($t1)
    daddi $t1,$t1,8
    bnez $t2,loop
halt