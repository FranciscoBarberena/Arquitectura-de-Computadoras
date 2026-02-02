.data
A: .word 2,1,3
SUM: .word 0

.code
daddi $t3,$0,3
ld $t1, SUM($0)
daddi $t3,$0,3

loop:
    ld $t4,A($t2)
    dadd $t1,$t1,$t4
    daddi $t3,$t3,-1
    bnez $t3,loop
    sd $t1,SUM($0)
halt