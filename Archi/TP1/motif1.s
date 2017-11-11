/* auteur : GAMBA Yohann
   date : 02 Octobre 2007
   sujet : Tp1 - Architecture des ordinateurs 
*/

.data

msg:
        .byte  42
msg1:
        .byte  12
msg2:
	.byte  13
i:
	.long 5
j:
	.long 5
.text

.globl _start

_start:
        movl $4,%eax      /* Le code d\'esignant la fonction \`a utiliser
                             (dans ce cas sys write) */
        movl $1,%ebx      /* 1 argument~: le num\'ero de la sortie 
                             standard.                                     */
        movl $msg,%ecx    /* 2 argument~: un pointeur sur le message \`a
                             afficher.                                     */
        movl $1,%edx      /* 3 argument~: le nombre de caract\`ere(s) \`a
                             afficher.                                     */
        int  $0x80        /* Appel au noyau (interruption 0x80).           */

	decl i
	jnz _start


        movl $4,%eax      /* Le code d\'esignant la fonction \`a utiliser
                             (dans ce cas sys write) */
        movl $1,%ebx      /* 1 argument~: le num\'ero de la sortie 
                             standard.                                     */
        movl $msg1,%ecx    /* 2 argument~: un pointeur sur le message \`a
                             afficher.                                     */
        movl $1,%edx      /* 3 argument~: le nombre de caract\`ere(s) \`a
                             afficher.                                     */
        int  $0x80        /* Appel au noyau (interruption 0x80).           */
	
	movl $4,%eax      /* Le code d\'esignant la fonction \`a utiliser
                             (dans ce cas sys write) */
        movl $1,%ebx      /* 1 argument~: le num\'ero de la sortie 
                             standard.                                     */
        movl $msg2,%ecx    /* 2 argument~: un pointeur sur le message \`a
                             afficher.                                     */
        movl $1,%edx      /* 3 argument~: le nombre de caract\`ere(s) \`a
                             afficher.                                     */
        int  $0x80        /* Appel au noyau (interruption 0x80).           */
	
	movl $5,i
	decl j
	jnz _start
	
done: 
        movl $1,%eax      /* Le code d\'esignant la fonction \`a utiliser
                             (dans ce cas sys exit) */
        movl $0,%ebx      /* 1 argument~: le code de retour du processus.  */
        int  $0x80        /* Appel au noyau (interruption 0x80).           */

