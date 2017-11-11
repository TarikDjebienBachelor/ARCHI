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
d:
	.long 1
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
	
	decl j
top4:
	movl $4,i
	decl d
	jnz _start
	jnz top4
	movl $1,d
top3:
	movl $3,i
	decl d
	jnz _start
	jnz top3
	movl $1,d
top2:
	movl $2,i
	decl d
	jnz _start
	jnz top2
	movl $1,d
top1:
	movl $1,i
	decl d
	jnz _start
	jnz top2
	movl $1,d
	jnz _start

	
done: 
        movl $1,%eax      /* Le code d\'esignant la fonction \`a utiliser
                             (dans ce cas sys exit) */
        movl $0,%ebx      /* 1 argument~: le code de retour du processus.  */
        int  $0x80        /* Appel au noyau (interruption 0x80).           */

