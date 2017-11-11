.data

m:
	.space 30         /* espace reservée a l'expression a lire */
msg:
        .byte 42          /* code ascii d'une étoile               */
nb:
	.long 0           /* variable intermédiaire                */
res:
	.long 0           /* nombre d'etoile a afficher            */
newline:
	.byte '\n'        /* permet un aaffichage plus clair       */
.text

.globl _start

_start:

        movl $3,%eax      /* Le code d\'esignant la fonction \`a utiliser (dans ce cas sys read).*/
        movl $0,%ebx      /* 1 argument~: le num\'ero de l'entr\'ee standard.                    */
        movl $m,%ecx      /* 3: capture la valeur lue est la place dans le registre %ecx.        */
        movl $30,%edx     /* 3 argument~: le nombre de caract\`ere(s) \`a afficher.              */
        int  $0x80        /* Appel au noyau (interruption 0x80).                                 */
 

_comparer:

   	movb (%ecx),%dl   /* on recupere le code ascii de ce caracter que l on range dans %edx  */
 

	cmp $10, %edx     /* verifie si le caractere courant correspond a saut de ligne (équivalent de retour charriot)  */
	je _boucle        /* si oui ,  effectue un saut vers boucle                                                      */


	/* Ajout du chiffre nouvellement capturé à la valeur en cours */
	subl $'0',%edx
	movl %edx,nb      /*on sauve notre valeur courante parceque la multiplication modifie le registre %edx et %ebx */

	movl res,%eax     /* mise en mémoire dans %eax de la valeur actuelle de resultat */
	movl $10, %ebx    /* initialise le multiplicateur %ebx à 10                      */
	mull %ebx         /* décale eax vers la gauche                                   */

	movl nb,%edx      /*on remet la valeur courante dans %edx  */
	

	addl %edx, %eax   /* ajoute la valeur entrée à l'écran à resultat */
	movl %eax, res
	                      /* mise à jour de resultat */
        addl $1,%ecx      /* on déplace le pointeur sur le prochain caractère lue */
	
	jmp _comparer     /* retour à la capture d'une lettre */


_boucle:

	cmp $0,res        /* verifie si le résultat est zéro  */
	je done           /* si oui ,  effectue un saut vers done    */

        movl $4,%eax      /* Le code d\'esignant la fonction \`a utiliser (dans ce cas sys write).  */
        movl $1,%ebx      /* 1 argument~: le num\'ero de la sortie standard.                        */
        movl $msg,%ecx    /* 2 : affichage  d'une étoile qui correspendant au code ascii de msg(42).*/
        movl $1,%edx      /* 3 argument~: le nombre de caract\`ere(s) \`a afficher.                 */
        int  $0x80        /* Appel au noyau (interruption 0x80).                                    */

	decl res          /*décremente le résultat                                            */
	jnz _boucle       /*si resultat est different de 0, on fait un saut a la boucle sinon */



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

