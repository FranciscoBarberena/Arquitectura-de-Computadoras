.data
A: .word 10
B: .word 0xF ; valor basura, tiene que tener 1 si A es impar y 0 si A es par

.code
ld $t0,A($0) ; Numero a analizar en t0
andi $t1,$t0,1 ;checkeo ultimo digito
sd $t1, B($0) ; guardo 1 en B si a es impar, y 0 si A es par
halt