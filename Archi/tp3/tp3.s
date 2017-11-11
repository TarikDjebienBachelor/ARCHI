.data
a:
	.long 17
b:
	.long 10
r:
	.long 0

.text

.globl _start

_start:
        movl a,%eax      /* place la valeur de a ds eax */
	
       
        divl b            /* divise a par b      */
	movl %edx,r
	/*cmpl $0,r
	jnz _start*/

	movl $4,%eax      /* Le code d\'esignant la fonction \`a utiliser
                             (dans ce cas sys write) */
        movl $1,%ebx      /* 1 argument~: le num\'ero de la sortie 
                             standard.                                     */
        movl b,%ecx    /* 2 argument~: un pointeur sur le message \`a
                             afficher.                                     */
        movl $1,%edx      /* 3 argument~: le nombre de caract\`ere(s) \`a
                             afficher.                                     */


done: 
        movl $1,%eax      /* Le code d\'esignant la fonction \`a utiliser
                             (dans ce cas sys exit) */
        movl $0,%ebx      /* 1 argument~: le code de retour du processus.  */
        int  $0x80        /* Appel au noyau (interruption 0x80).           */

  

