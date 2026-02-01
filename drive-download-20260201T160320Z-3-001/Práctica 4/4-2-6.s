.data
vector: .word 2,3,4,5
longitud: .word 10

.code
daddi $a0,$0,vector ; mov a0, offset vector
daddi $sp,$0,0x400
ld $a1, longitud($0) ; mov a1, longitud
jal vector_cuadrado
halt

vector_cuadrado:

    
    daddi $t0,$0,0 ; desplazamiento en $t0
    daddi $sp,$sp,-8
    sd $ra, 0($sp) ; salvo direccion de retorno en el final de la pila
    loop: 
        beqz $a1,fin
        daddi $sp,$sp,-24 ; guardo los parametros y temporales
        sd $a0, 16($sp)
        sd $a1, 8($sp)
        sd $t0, 0($sp)
        dadd $a0,$a0,$t0
        daddi $a1,$0,2
        jal potencia
        ld $t0,0($sp)
        ld $a0, 16($sp)
        ld $a1, 8($sp)
        daddi $sp, $sp,24 ; recupero los parametros y temporales
        sd $v0, vector($t0) ; guardo resultado en memoria
        daddi $t0,$t0,8 ; aumento desplazamiento
        daddi $a1,$a1,-1 ; disminuyo longitud del vector
        j loop
        
    fin: 
        ld $ra,0($sp)
        daddi $sp,$sp,8
        jr $ra

potencia: 

    daddi $v0,$0,1
    ld $t0,0($a0) ;  es como hacer mov t0,[a0]
    dadd $t1,$0,$a1 ; guardo exponente en temporal porque no quiero que cambie en memoria

lazo: 
    beqz $t1,terminar
    daddi $t1,$t1,-1
    dmul $v0,$v0,$t0
    j lazo
terminar: 
    jr $ra