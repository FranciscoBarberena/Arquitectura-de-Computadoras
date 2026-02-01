.data
F: .word 
.text
DADDI $t0,$0,1 ;F
DADDI $t1,$0,1 ;i
daddi $t2,$0,6 ;N=5(esto hace el factorial de $t2-1, en este caso 6-1=5)
loop: 
    DMUL $t0,$t0,$t1
    DADDI $t1,$t1,1
    BNE $t1,$t2,loop
SD $t0,F($0)
halt  