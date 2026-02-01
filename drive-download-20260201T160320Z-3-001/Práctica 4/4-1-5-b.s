.data
A: .word 0
B: .word 2
C: .word

.text
ld $t0,A($0) 
ld $t1,B($0) 
beqz $t0,es_cero
slt $t2,$t1,$t0
beqz $t2,else
beq $t0,$t1, else
dsll $t0,$t0,1
sd $t0,C($0)
j fin
else: 
sd $t1,C($0)
j fin
es_cero: 
sd $0,C($0)
fin: 
halt