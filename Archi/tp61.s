.data

m:
	.long 0           /* espace reservée a l'expression a lire */
msg:
        .byte 42          /* code ascii d'une étoile               */
a:
        .byte 0           /* nombre d'etoile a afficher            */
newline:
	.byte '\n'        /* permet un aaffichage plus clair       */
.text

.globl _start

_start:

        movl $3,%eax      /* Le code d\'esignant la fonction \`a utiliser (dans ce cas sys read).*/
        movl $0,%ebx      /* 1 argument~: le num\'ero de l'entr\'ee standard.                    */
        movl $m,%ecx      /* 3: capture la valeur lue est la place dans le registre %ecx.        */
        movl $1,%edx      /* 3 argument~: le nombre de caract\`ere(s) \`a afficher.              */
        int  $0x80        /* Appel au noyau (interruption 0x80).                                 */


        movb (%ecx),%bl   /* on recupere le code ascii de ce caractere que l'on range dans %ebx.  */
        subb $'0',%bl     /* on recupere le chiffre correspondant aux code ascii entrer dans %ebx.*/
	
	je done	          /* si ce nombre est egale a 0 on fait un saut jusqu'a l'interruption du programme done sinon*/ 

	movb %bl, a       /* on stocke ce nombre dans la variable a pour sauvegarder ce nombre.*/


_boucle:
        movl $4,%eax      /* Le code d\'esignant la fonction \`a utiliser (dans ce cas sys write).  */
        movl $1,%ebx      /* 1 argument~: le num\'ero de la sortie standard.                        */
        movl $msg,%ecx    /* 2 : affichage  d'une étoile qui correspendant au code ascii de msg(42).*/
        movl $1,%edx      /* 3 argument~: le nombre de caract\`ere(s) \`a afficher.                 */
        int  $0x80        /* Appel au noyau (interruption 0x80).                                    */

	decb a            /* on decremente la valeur lue et stockée dans a.*/
	jnz _boucle       /* tant que a est différent de zéro, au fait un saut jusqu'a la boucle sinon */ 



	/* affichage d'un retour a la ligne en fin de programme pour une meilleure visibilité       */

        movl $4,%eax      /* Le code d\'esignant la fonction \`a utiliser (dans ce cas sys write).  */
        movl $1,%ebx      /* 1 argument~: le num\'ero de la sortie standard.                        */
        movl $newline,%ecx/* 2 : retour a la ligne correspendant au code ascii 10.                  */
        movl $1,%edx      /* 3 argument~: le nombre de caract\`ere(s) \`a afficher.                 */
        int  $0x80        /* Appel au noyau (interruption 0x80).                                    */


done:
        movl $1,%eax      /* Le code d\'esignant la fonction \`a utiliser (dans ce cas sys exit).*/
        movl $0,%ebx      /* 1 argument~: le code de retour du processus.  */
        int  $0x80        /* Appel au noyau (interruption 0x80).           */
