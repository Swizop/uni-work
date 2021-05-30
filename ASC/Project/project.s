.data
	host1:	  .space 4			# primul host
	host2:	  .space 4			# al doilea host
	matrix:   .space 1600 			# matrice de 20 * 20 * 4 (fiecare element are 4 bytes in memorie)
	n:	  .space 4			# numarul de linii = numarul de coloane 
	nrc:	  .space 4			# numarul cerintei
	nrMuchii: .space 4			# numarul de muchii de citit
	v:        .space 400			# int v[100];
	queue:    .space 400			# int queue[100];
	vizitat:  .space 400			# int gasit[100];
	mesaj:	  .space 20
	a:	  .asciiz "a"
	z:	  .asciiz "z"
	sp:	  .asciiz " "
	sp1:	  .asciiz "switch malitios index"
	sp2:	  .asciiz ": "
	sp3:	  .asciiz "host index "
	sp4:	  .asciiz "switch index "
	sp5:	  .asciiz "controller index "
	sp6:	  .asciiz "; "
	sp7:	  .asciiz "Cerinta invalida!"
	no:	  .asciiz "No"
	yes:	  .asciiz "Yes"
	nl:	  .asciiz "\n"
.text

main:
	li $v0, 5				# apel sistem READ WORD
	syscall
	
	sw $v0, n				# val. citita este in $v0 si o mut in n

	li $v0, 5				# apel sistem READ WORD
	syscall

	sw $v0, nrMuchii			# val. citita este in $v0 si o mut in nrMuchii

	lw $t0, nrMuchii			# iau nrMuchii in $t0
	lw $t6, n				# punem n in $t6
	li $t1, 0				# pe post de i din for-ul de mai sus

for_edges:

	bge $t1, $t0, readroles		# execut cat timp i < nrMuchii, i.e. cat timp $t1 < $t0
						# deci ies cand $t1 >= $t0
	li $v0, 5
	syscall
	move $t2, $v0				# $t2 este acum "left"
	
	li $v0, 5
	syscall
	move $t3, $v0				# $t3 este acum "right"

	# calculam, pentru inceput, left * n in $t4
	mul $t4, $t2, $t6			# $t4 = $t2 (left) * $t6 (n)
	# la rezultat, adaugam right
	add $t4, $t4, $t3			# $t4 = $t4 + $t3 (right)
	# il inmultim cu 4
	mul $t4, $t4, 4				# $t4 = $t4 * 4

	# trebuie acum ca matrix($t4) sa fie egal cu 1
	li $t5, 1
	sw $t5, matrix($t4)

	# analog pentru right, refolosim $t4
	mul $t4, $t3, $t6
	add $t4, $t4, $t2
	mul $t4, $t4, 4
	sw $t5, matrix($t4)

	addi $t1, 1				# $t1 := $t1 + 1 i.e. i++
	j for_edges

readroles:
	lw $t0, n				# punem n in $t0

	li $t1, 0				# pe post de "i"
	li $t2, 0				# sare locatii de memorie din 4 in 4

etloop:
	bge $t1, $t0, numarcerinta
	
	li $v0, 5
	syscall

	sw $v0, v($t2)				# mut din reg. $v0 la locatia de memorie v($t2)

	addi $t1, $t1, 1
	addi $t2, $t2, 4
	j etloop

numarcerinta:

	li $v0, 5				# apel sistem READ WORD
	syscall
	
	sw $v0, nrc				# val. citita este in $v0 si o mut in nrc
	lw $t0, nrc				# punem nrc in $t0
	li $t1, 1
	li $t2, 2	
	li $t3, 3					
	
	beq $t0, $t1, cerinta1
	beq $t0, $t2, cerinta2
	beq $t0, $t3, cerinta3
	j nu_exista_cerinta

nu_exista_cerinta:

	la $a0, sp7
	li $v0, 4 # PRINT STRING
	syscall
	j et_exit

cerinta1:

	lw $t0, n
	li $t1, 0	# "i"-ul curent
	li $t2, 0	# pentru accesarea locatiilor de memorie din 4 in 4
	li $t3, 3

cautare:

	bge $t1, $t0, et_exit

	lw $t4, v($t2)				
	beq $t4, $t3, afisare1
	
cont:
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	j cautare

afisare1:

	la $a0, sp1
	li $v0, 4 # PRINT STRING
	syscall

	la $a0, sp
	li $v0, 4 # PRINT STRING
	syscall

	move $a0, $t1
	li $v0, 1	# PRINT INT (WORD)
	syscall

	la $a0, sp2
	li $v0, 4 # PRINT STRING
	syscall

	j parcurge_linie

parcurge_linie:

	li $t5, 0			# pe post de j
	li $t9, 0	# pentru accesarea locatiilor de memorie din 4 in 4
	li $t7, 1
	for_columns:
		bge $t5, $t0, newline

		mul $t6, $t1, $t0
		add $t6, $t6, $t5
		mul $t6, $t6, 4
		
		lw $t8, matrix($t6)
		beq $t7, $t8, afisare2
			
		addi $t5, 1
		addi $t9, $t9, 4
		j for_columns
			

afisare2:

	lw $t6, v($t9)
	
	li $t8, 1
	beq $t8, $t6, host

	li $t8, 4
	beq $t8, $t6, controller

	li $t8, 2
	beq $t8, $t6, switch
	
	addi $t5, 1
	addi $t9, $t9, 4
	j for_columns

host:

	la $a0, sp3
	li $v0, 4 # PRINT STRING
	syscall

	move $a0, $t5
	li $v0, 1	# PRINT INT (WORD)
	syscall

	la $a0, sp6
	li $v0, 4 # PRINT STRING
	syscall

	addi $t5, 1
	addi $t9, $t9, 4
	j for_columns

switch:

	la $a0, sp4
	li $v0, 4 # PRINT STRING
	syscall

	move $a0, $t5
	li $v0, 1	# PRINT INT (WORD)
	syscall

	la $a0, sp6
	li $v0, 4 # PRINT STRING
	syscall

	addi $t5, 1
	addi $t9, $t9, 4
	j for_columns

controller:

	la $a0, sp5
	li $v0, 4 # PRINT STRING
	syscall

	move $a0, $t5
	li $v0, 1	# PRINT INT (WORD)
	syscall

	la $a0, sp6
	li $v0, 4 # PRINT STRING
	syscall

	addi $t5, 1
	addi $t9, $t9, 4
	j for_columns

newline:

	la $a0, nl
	li $v0, 4 # PRINT STRING
	syscall
	
	j cont

cerinta2:
	
	li $t0, 0		#index queue
	li $t1, 0		#lungime queue

	lw $t2, n		#numarul de noduri

	li $t3, 0		
	sw $t3, queue($t1)	#punem nodul 0 in array-ul queue

	li $t3, 1
	sw $t3, vizitat($t0)	#elementul cu indexul 0 a fost vizitat

	addi $t1, 1		#creste lungimea queue-ului

	li $t3, 1		#index nod curent
	

BFS:
	
	beq $t1, $t0, conexiune

	mul $t4, $t0, 4
	lw $t3, queue($t4)

	addi $t0, 1

	#verificam daca nodul curent este sau nu host
	mul $t5, $t3, 4
	lw $t6, v($t5)
	
	bne $t6, 1, nu_este_host

	#este host deci afisam "host index nr_index"

	la $a0, sp3
	li $v0, 4 # PRINT STRING
	syscall

	move $a0, $t3
	li $v0, 1	# PRINT INT (WORD)
	syscall

	la $a0, sp6
	li $v0, 4 # PRINT STRING
	syscall

	nu_este_host:

		li $t4, 0	#pe post de j

		for_columns2:

			beq $t4, $t2, BFS	#verificam daca s-a parcurs toate
		
			mul $t5, $t3, $t2
			add $t5, $t5, $t4
			mul $t5, $t5, 4
			
			lw $t6, matrix($t5)

			bne $t6, 1, nu_este_host_2

			mul $t7, $t4, 4
			lw $t8, vizitat($t7)
			beq $t8, 1, nu_este_host_2

			mul $t7, $t1, 4
			sw $t4, queue($t7)
			addi $t1, 1

			li $t8, 1
			mul $t7, $t4, 4
			sw $t8, vizitat($t7)

		nu_este_host_2:
		addi $t4, 1
		j for_columns2

	
afisare_yes:

	la $a0, yes
	li $v0, 4 # PRINT STRING
	syscall
	
	j et_exit

conexiune:

	la $a0, nl
	li $v0, 4 # PRINT STRING
	syscall
	
	#analizam daca toate nodurile au fost vizitate
	li $t0, 0
	li $t1, 0	

	li $t3, 1	#presupunem ca toate nodurile au fost vizitate, in cazul in care presupunerea e falsa $t3=0
	
	verificare:
		
		bge $t1, $t2, afisare_yes	#daca am verificat toate nodurile, sarim la afisare "Yes"
		
		lw $t4, vizitat($t0)
		beq $t4, 1, caz_afirmativ #verificam daca nodul a fost vizitat. in caz ca nu $t3=0

		la $a0, no
		li $v0, 4 # PRINT STRING
		syscall

		j et_exit #am afisat "No" si programul se termina

		caz_afirmativ:
			addi $t0, 4
			addi $t1, 1
			j verificare
cerinta3:

	li $v0, 5				# apel sistem READ WORD
	syscall
	sw $v0, host1				# val. citita este in $v0 si o mut in host1

	li $v0, 5				# apel sistem READ WORD
	syscall
	sw $v0, host2				# val. citita este in $v0 si o mut in host2

	la $a0, mesaj
    	li $v0, 8 
   	syscall

	lw $t0, n
	li $t1, 0	# "i"-ul curent
	li $t2, 0	# pentru accesarea locatiilor de memorie din 4 in 4
	li $t3, 3

cautare_switch_mal:

	bge $t1, $t0, BFS_3

	lw $t4, v($t2)				
	beq $t4, $t3, este_switch_mal

continua3:
	addi $t1, $t1, 1
	addi $t2, $t2, 4
	j cautare_switch_mal
	
este_switch_mal:

	li $t5, 0	# pe post de j
	li $t6, 0	# pentru accesarea locatiilor de memorie din 4 in 4
	li $t7, 1
	
	for_columns_3:

		bge $t5, $t0, continua3

		mul $t8, $t1, $t0
		add $t8, $t8, $t5
		mul $t8, $t8, 4
		
		lw $t9, matrix($t8)
		beq $t7, $t9, sterge_din_matrice
			
		addi $t5, 1
		addi $t6, $t6, 4
		j for_columns_3

		sterge_din_matrice:
			li $t4, 0
			sw $t4, matrix($t8)

			mul $t8, $t5, $t0
			add $t8, $t8, $t1
			mul $t8, $t8, 4
			sw $t4, matrix($t8)

			addi $t5, 1
			addi $t6, $t6, 4
			j for_columns_3

BFS_3:
	li $t0, 0		#index queue
	li $t1, 0		#lungime queue

	lw $t2, n		#numarul de noduri

	li $t3, 0		
	sw $t3, queue($t1)	#punem nodul 0 in array-ul queue


	#verificam daca nodul curent este sau nu host
	mul $t5, $t3, 4
	lw $t6, v($t5)
	
	bne $t6, 1, nu_este_host_sari

	#este host 

	lw $t8, host1
	beq $t3, $t8, scade

	lw $t8, host2
	beq $t3, $t8, scade

	nu_este_host_sari:

		li $t3, 1
		sw $t3, vizitat($t0)	#elementul cu indexul 0 a fost vizitat

		addi $t1, 1		#creste lungimea queue-ului

		li $t3, 1		#index nod curent
		li $9, 2		#scadem din el 1 daca gasim host1/host2

scade:
	addi $t9, $t9, -1
	li $t8, 0
	beq $9, $8, nu_este_criptat

	j nu_este_host_3

BFS_start:
	
	beq $t1, $t0, mesaj_codat

	mul $t4, $t0, 4
	lw $t3, queue($t4)

	addi $t0, 1

	#verificam daca nodul curent este sau nu host
	mul $t5, $t3, 4
	lw $t6, v($t5)
	
	bne $t6, 1, nu_este_host_3

	#este host 

	lw $t8, host1
	beq $t3, $t8, scade

	lw $t8, host2
	beq $t3, $t8, scade

	nu_este_host_3:

		li $t4, 0	#pe post de j

		for_columns3:

			beq $t4, $t2, BFS_start	#verificam daca s-a parcurs toate
		
			mul $t5, $t3, $t2
			add $t5, $t5, $t4
			mul $t5, $t5, 4
			
			lw $t6, matrix($t5)

			bne $t6, 1, nu_este_host_4

			mul $t7, $t4, 4
			lw $t8, vizitat($t7)
			beq $t8, 1, nu_este_host_4

			mul $t7, $t1, 4
			sw $t4, queue($t7)
			addi $t1, 1

			li $t8, 1
			mul $t7, $t4, 4
			sw $t8, vizitat($t7)

		nu_este_host_4:
		addi $t4, 1
		j for_columns3

nu_este_criptat:

	la $a0, mesaj
	li $v0, 4 # PRINT STRING
	syscall

	j et_exit

mesaj_codat:

	li $t0, 0

	et_for:
		lb $t1, mesaj($t0)
		beqz $t1, et_exit

		li $t2, 10
		lb $t3, a
		lb $t4, z

		sub $t5, $t1, $t3	#$t5=$t1-"a"
		sub $t5, $t2, $t5	#$t5=10-$t5
		sub $t5, $t4, $t5	#$t5="z"-$t5

		blt $t3, $t3, skip	#nu afisam elemente ce nu apartin alfabetului
		bgt $t3, $t4, skip	#nu afisam elemente ce nu apartin alfabetului

		move $a0, $t5
		li $v0, 11
		syscall

	skip:
		addi $t0, 1
		j et_for

et_exit:
	li $v0, 10
	syscall
