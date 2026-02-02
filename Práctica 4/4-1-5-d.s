.data
L: .word 0 ; Resultado
N: .word 16 ; Argumento
.code
ld $t0,N($0) ; Argumento en t0
loop:
    dsrl $t0,$t0,1 ; Divide por 2 el argumento
    daddi $t1,$t1,1 ; Incrementa el resultado
    slti $t2,$t0,2
    beqz $t2,loop
sd $t1,L($0)
halt
