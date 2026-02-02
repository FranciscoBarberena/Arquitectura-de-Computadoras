.data
A: .word 10
B: .word 20
S: .word
P: .word
D: .word

.code
ld $t0, A($0)
ld $t1, B($0)
dadd $t3, $t1, $t0
sd $t3, S($0)
dmul $t3,$t1,$t0
daddi $t3,$t3,2
sd $t3, P($0)
dmul $t0,$t0,$t0
ddiv $t3,$t0,$t1
sd $t3, D($0)
halt