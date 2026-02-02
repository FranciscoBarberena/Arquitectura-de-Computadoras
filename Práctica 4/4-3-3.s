.data
vocales: .asciiz "aeiouAEIOU"
string0: .asciiz "aaRRRRR"
string1: .asciiz "aaaRRR"
length: .word 0
difierenEn: .word 0
res: .word 0
.code
daddi $sp,$0,0x400
daddi $a0,$0,string0
daddi $a1,$0,string1
jal comparar
daddi $t1,$0,-1
beq $t1,$v0,iguales

daddi $a0,$0,string0
jal longitud
daddi $s0,$v0,0 ;s0 longitud de string0

daddi $a0,$0,string1
jal longitud
daddi $s1,$v0,0 ;s1 longitud de string1

slt $t0,$s0,$s1 ;como es menor estricto, si ambos string son iguales en longitud (pero no identicos), se cuentan las vocales del string0
beqz $t0,stringCeroMasGrande
daddi $a0,$0,string1 ;string1 mas grande
jal cant_vocales
sd $v0, res($0)
j finProg

stringCeroMasGrande:
    daddi $a0,$0,string0
    jal cant_vocales
    sd $v0, res($0)
    j finProg
iguales:
    sd $t1, res($0)
    j finProg
finProg:
    halt


;SUBRUTINAS

longitud:
    daddi $v0,$0,0
    loop:
        lbu $t0,0($a0)
        beq $t0,$0,fin1
        daddi $v0,$v0,1
        daddi $a0,$a0,1
        j loop
    fin1:
        jr $ra


contiene: ;Recibe direccion de string0 en $a0 y un caracter en $a1. 
          ;Devuelve en $v0 true or false dependiendo de si lo contiene
    daddi $v0,$0,0 ;boolean = false
    loop2:
        lbu $t0,0($a0)
        beq $t0,$a1, true ;encontre el caracter
        beqz $t0,fin2 ;no es el caracter y es el fin del string0
        daddi $a0,$a0,1 ;no es el caracter, pero no es el fin del string
        j loop2
    true:
        daddi $v0,$0,1 ;boolean = true
    fin2:
        jr $ra

es_vocal: ;Recibe caracter en $a1 y devuelve en $v0 true si es vocal y false si no lo es
    daddi $sp,$sp,-8
    sd $ra,0($sp)
    daddi $a0,$0,vocales
    jal contiene
    ld $ra,0($sp)
    daddi $sp,$sp,8
    jr $ra

cant_vocales: ;recibe string0 en $a0 y devuelve cantidad de vocales en $v0
    daddi $sp,$sp,-16
    sd $ra,0($sp)
    sd $s1,8($sp)
    daddi $s1,$0,0
    loop3:
        lbu $a1,0($a0)
        beqz $a1, fin3
        daddi $sp,$sp,-8
        sd $a0,0($sp)
        jal es_vocal
        ld $a0,0($sp)
        daddi $sp,$sp,8
        beqz $v0, no_es
        daddi $s1,$s1,1
        no_es:
            daddi $a0,$a0,1
            j loop3
    fin3:
        ld $ra,0($sp)
        daddi $v0,$s1,0
        ld $s1,8($sp)
        daddi $sp,$sp,16
        jr $ra

comparar: 
    daddi $sp,$sp,-56;comparar
    sd $s1, 0($sp) ;auxiliar para guardar direcciones
    sd $s2, 8($sp) ;desplazamiento
    sd $s3, 16($sp) ;caracter del string0
    sd $s4, 24($sp) ;caracter del string1
    sd $ra, 32($sp)
    sd $s5, 40($sp) ;longitud string0
    sd $s6, 48($sp) ;longitud string1
    daddi $sp,$sp,-8
    sd $a0,0($sp)
    jal longitud
    ld $a0,0($sp)
    daddi $sp,$sp,8
    daddi $s5,$v0,0
    daddi $s1,$a0,0 ;guardo la direccion del string0 en s1
    daddi $a0,$a1,0 ;guardo la direccion del string1 en a0
    daddi $sp,$sp,-8
    sd $a1,0($sp)
    jal longitud
    ld $a1,0($sp)
    daddi $a0,$s1,0 ;recupero la direccion del string0 en a0
    daddi $sp,$sp,8
    daddi $s6,$v0,0
    bne $s5,$s6,diferentesLongitudes
    daddi $s2,$0,0
    loop4: 
        dadd $a0,$s2,$a0 ;LOOP 4
        lbu $s3,0($a0)
        dadd $a1,$s2,$a1
        lbu $s4,0($a1)
        bne $s3,$s4,distintos
        daddi $s2,$s2,1
        bne $s2,$s6,loop4
        daddi $v0,$0,-1
        j fin4
    diferentesLongitudes:
        slt $t1,$s5,$s6
        beqz $t1,caso0
        caso1:
            daddi $v0,$s5,1
            j fin4
        caso0:
            daddi $v0,$s6,1
            j fin4
    distintos:
        daddi $v0,$s2,1
    fin4:
        ld $s1, 0($sp)
        ld $s2, 8($sp)
        ld $s3, 16($sp)
        ld $s4, 24($sp)
        ld $ra, 32($sp)
        ld $s5, 40($sp)
        ld $s6, 48($sp)
        daddi $sp,$sp,56
        jr $ra