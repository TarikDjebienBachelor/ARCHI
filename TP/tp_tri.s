.data

nb: 
	.long 11
liste:	
	.word 24,7,274,2,504,1,13,149,4,81,44
min:
	.word 999

.text
.globl _start
_start:

	  movl $liste, %ecx /* deplace la suite d'entiers dans %ecx */
bidule  : movw (%ecx), %ax  /* deplace la valeur d'adresse (%ecx) dans %ax */
	  cmp %ax, min      /* comparer %ax avec min = 999 */
	  jb jukilo       /* si %ax < 999  on va directement a jukilo sinon */
	  decl nb 	   /*decremente nb */
	  addw $2, %cx	   /* passe a la valeur suivante dans liste car un word vaut 2 bits */


jukilo	: mov %ax, min	    /*deplace %ax dans min */
	  decl nb	    /*decremente nb */
	  jz done	   /* continuer tant que nb est different de 0 */
	  addw $2, %cx	    /* passe a la valeur suivante dans liste */
	  jmp bidule	    /* retourner a bidule */


done:
        movl $1,%eax   /* Le code d\’esignant la fonction \‘a utiliser
                          (dans ce cas sys exit) */
        movl $0,%ebx   /* 1 argument~: le code de retour du processus. */
        int $0x80      /* Appel au noyau (interruption 0x80).          */
