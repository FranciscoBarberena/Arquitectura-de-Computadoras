.data
V: .word 5,2,6
suma: .word 0

.text
daddi $t2,$0,0
ld $t1, V($t2)
daddi $t2,$t2,8
ld $t3, V($t2)
daddi $t2,$t2,8
ld $t4, V($t2)
dadd $t5,$t1,$t3
dadd $t5,$t5,$t4
sd $t5, suma($0)
halt