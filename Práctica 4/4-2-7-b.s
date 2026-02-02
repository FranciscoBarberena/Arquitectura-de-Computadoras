.data
base: .word 2
exponente: .word 4
result: .word 0

.code
daddi $sp,$0,0x400
daddi $t0,$0,base
daddi $t1,$0,exponente
daddi $sp,$sp,-16
sd $t0,0($sp)
sd $t1,8($sp)
jal potencia
daddi $sp,$sp,16
sd $v0, result($0)
halt

potencia: 

    daddi $v0,$0,1
    ld $t0,0($sp) ;mov t0,[sp] (direccion de base)
    ld $t1,8($sp) ;mov t1,[sp+8] (direccion de exponente)
    ld $t0,0($t0) ;mov t0,[t0] (base)
    ld $t1,0($t1) ;mov t1,[t1] (exponente)

loop: 
    beqz $t1,terminar
    daddi $t1,$t1,-1
    dmul $v0,$v0,$t0
    j loop
terminar: 
    jr $ra