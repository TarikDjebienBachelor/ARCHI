.data
msg:
        .byte   42
	.byte   42
	.byte   42
	.byte   42
	.byte   42
	.byte   10

msg2 : .byte 42
msg3 : .byte 10
Espace1:
	 .space 4
Espace2:
	 .space 4
Espace3:
	 .space 4
.text
.globl _start
_start:
movl $5, %ecx

boucle : movl %ecx,Espace1

        
	movl %ecx,%edx
boucle2 : movl %edx,Espace2


	movl $4,%eax   /* Le code d\’esignant la fonction \‘a utiliser
                          (dans ce cas sys write) */
        movl $1,%ebx   /* 1 argument~: le num\’ero de la sortie
                          standard.                                    */
        movl $msg2,%ecx /* 2 argument~: un pointeur sur le message \‘a
                          afficher.                                    */
        movl $1,%edx   /* 3 argument~: le nombre de caract\‘ere(s) \‘a
                         afficher.                                    */
	int   $0x80    /* Appel au noyau (interruption 0x80).          */
	
	movl Espace2,%edx
	
	movl %edx,Espace3

	movl $msg3,%edx

	movl Espace3,%edx
	
	decl %edx

jnz boucle2

	movl Espace1,%ecx

	loop boucle
	
done:
        movl $1,%eax   /* Le code d\’esignant la fonction \‘a utiliser
                          (dans ce cas sys exit) */
        movl $0,%ebx   /* 1 argument~: le code de retour du processus. */
        int $0x80      /* Appel au noyau (interruption 0x80).          */
