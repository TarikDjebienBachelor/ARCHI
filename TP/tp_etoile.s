.data

msg:
        .byte   42     /* on a le caractere etoile sur le code ASCII 42 */
	.byte   42	
	.byte   42
	.byte   42
	.byte   42
	.byte   10	/* passage à la ligne code ASCII 10 */

Espace1:
	 .space 4        /* variable intermediaire */


.text
.globl _start
_start:

movl $5, %ecx		/* compteur initialiser a 5 */

	
boucle:	movl %ecx,Espace1

	movl $4,%eax   /* Le code d\’esignant la fonction \‘a utiliser
                          (dans ce cas sys write) */
        movl $1,%ebx   /* 1 argument~: le num\’ero de la sortie
                          standard.                                    */
        movl $msg,%ecx /* 2 argument~: un pointeur sur le message \‘a
                          afficher.                                    */
        movl $1,%edx   /* 3 argument~: le nombre de caract\‘ere(s) \‘a
                         afficher.                                    */
	int   $0x80    /* Appel au noyau (interruption 0x80).          */
	

	movl Espace1,%ecx
	
	decl %ecx
	jnz boucle   /* decremente CX si ce registre est non nul */

	
done:
        movl $1,%eax   /* Le code d\’esignant la fonction \‘a utiliser
                          (dans ce cas sys exit) */
        movl $0,%ebx   /* 1 argument~: le code de retour du processus. */
        int $0x80      /* Appel au noyau (interruption 0x80).          */
