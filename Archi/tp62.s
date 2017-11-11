.data

m:
	.space 30         /* espace reserv�e a l'expression a lire */
msg:
        .byte 42          /* code ascii d'une �toile               */
nb:
	.long 0           /* variable interm�diaire                */
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
 

	cmp $10, %edx     /* verifie si le caractere courant correspond a saut de ligne (�quivalent de retour charriot)  */
	je _boucle        /* si oui ,  effectue un saut vers boucle                                                      */


	/* Ajout du chiffre nouvellement captur� � la valeur en cours */
	subl $'0',%edx
	movl %edx,nb      /*on sauve notre valeur courante parceque la multiplication modifie le registre %edx et %ebx */

	movl res,%eax     /* mise en m�moire dans %eax de la valeur actuelle de resultat */
	movl $10, %ebx    /* initialise le multiplicateur %ebx � 10                      */
	mull %ebx         /* d�cale eax vers la gauche                                   */

	movl nb,%edx      /*on remet la valeur courante dans %edx  */
	

	addl %edx, %eax   /* ajoute la valeur entr�e � l'�cran � resultat */
	movl %eax, res
	                      /* mise � jour de resultat */
        addl $1,%ecx      /* on d�place le pointeur sur le prochain caract�re lue */
	
	jmp _comparer     /* retour � la capture d'une lettre */


_boucle:

	cmp $0,res        /* verifie si le r�sultat est z�ro  */
	je done           /* si oui ,  effectue un saut vers done    */

        movl $4,%eax      /* Le code d\'esignant la fonction \`a utiliser (dans ce cas sys write).  */
        movl $1,%ebx      /* 1 argument~: le num\'ero de la sortie standard.                        */
        movl $msg,%ecx    /* 2 : affichage  d'une �toile qui correspendant au code ascii de msg(42).*/
        movl $1,%edx      /* 3 argument~: le nombre de caract\`ere(s) \`a afficher.                 */
        int  $0x80        /* Appel au noyau (interruption 0x80).                                    */

	decl res          /*d�cremente le r�sultat                                            */
	jnz _boucle       /*si resultat est different de 0, on fait un saut a la boucle sinon */



	/* affichage d'un retour a la ligne en fin de programme pour une meilleure visibilit�       */

        movl $4,%eax      /* Le code d\'esignant la fonction \`a utiliser (dans ce cas sys write).  */
        movl $1,%ebx      /* 1 argument~: le num\'ero de la sortie standard.                        */
        movl $newline,%ecx/* 2 : retour a la ligne correspendant au code ascii 10.                  */
        movl $1,%edx      /* 3 argument~: le nombre de caract\`ere(s) \`a afficher.                 */
        int  $0x80        /* Appel au noyau (interruption 0x80).                                    */

done:
        movl $1,%eax      /* Le code d\'esignant la fonction \`a utiliser (dans ce cas sys exit).*/
        movl $0,%ebx      /* 1 argument~: le code de retour du processus.  */
        int  $0x80        /* Appel au noyau (interruption 0x80).           */

