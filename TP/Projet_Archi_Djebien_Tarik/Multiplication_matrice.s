/* Auteur: Djebien Tarik
   Enseignant: S.Meftali TD: lundi 10h15-11h45 TP: lundi 16h30-18h00 
   Groupe: MIMP 32 
   Date: 14 decembre 2009
   Objet: Projet Architecture Des Ordinateurs
   Theme: Affichage sur la sortie standard du produit matriciel 
   mail: tarik.djebien@etudiant.univ-lille1.fr 
*/

/*Segment de donnée */
.data
   var : .long 1
   indicei: .long 0
   indicej: .long 0
   indicek: .long 0
   resultat: .long 0
   temp1: .long 0


/* Segment de donnée pour l'Affichage du resultat C = A x B : */

   temp2:     .long 0
   var_compteur1: .long 0
   var_compteur2: .long 0
   char_virgule: .byte 44
   char_passage_à_la_ligne: .byte 10
   sortie_standard: .space 5

/* Matrice A */
  A : 
     .long 97,24,34,45,12
     .long 56,23,78,24,39
     .long 45,42,10,94,93
     .long 67,84,31,94,86
     .long 73,54,59,47,98

/* Matrice B */  
  B :
     .long 73,23,98,74,06
     .long 54,76,34,98,73
     .long 75,04,74,18,83
     .long 34,89,73,38,55
     .long 13,84,73,54,73

/* Matrice C */
  C :
     .space 100


/* Segment de Texte */
.text
.globl _start

_start:


/* Partie Calcul De la Matrice */

    movl $0, indicei	/* i <-- 0 */

iteration_sur_indice_i :
    movl $0, indicej	/* j <-- 0 */

iteration_sur_indice_j :
    movl $0, indicek	/* k <-- 0 */
    movl $0, resultat	/* resultat <-- 0 */

/* Calcul de l'element C[indicei][indicej] dans resultat */

iteration_sur_indice_k :

  /* Bkj est à l'indice k * 5 + j */
    movl indicek, %eax	/* %eax <-- k */
    movl $5, %ebx	/* %ebx <-- 5 */
    mul %ebx		/* %eax <-- k x 5 */
    movl %eax, %ebx	/* %ebx <-- k x 5 */
    addl indicej, %ebx  /* %ebx <-- k x 5 + j */

  /* Aik est à l'indice i * 5 + k */
    movl indicei, %eax	/* %eax <-- i */
    movl $5, %ecx	/* %ecx <-- 5 */
    mul %ecx		/* %eax <-- i x 5 */
    movl %eax, %ecx	/* %ecx <-- i x 5 */
    addl indicek, %ecx	/* %ecx <-- i x 5 + k */

    
    movl B(,%ebx,4), %ebx /* %ebx <-- Bkj */
    movl A(,%ecx,4), %eax /* %eax <-- Aik */
    mul %ebx		  /* %eax <-- Aik x Bkj */
    add %eax, resultat    /*resultat := resultat + Aik x Bkj */ 

    incl indicek	/* k <-- k + 1  */
    cmp $5, indicek	/* k <> 5 ? k = 5 ? */
    jne iteration_sur_indice_k /* repeter Tant Que (jumpIfNotEqual) k < 5 (on boucle 5 fois = dimension des matrices ) */

   /* On écrit Cij à l'indice i*5 + j  */
    movl indicei, %eax            /* %eax <-- i */
    movl $5, %ecx                 /* %ecx <-- 5 */
    mul %ecx                      /* %eax <-- i x 5 */
    movl %eax, %ecx               /* %ecx <-- i x 5 */
    addl indicej, %ecx            /* %ecx <-- i x 5 + j */

    movl resultat, %eax           /* %eax <-- resultat */
    movl %eax, C(,%ecx,4)         /* Cij <-- %eax */

    incl indicej	          /* j <-- j + 1 */
    cmp $5, indicej	          /* j <> 5 ? j = 5 ? */
    jne iteration_sur_indice_j    /* repeter Tant Que (jumpIfNotEqual) j < 5 (on boucle 5 fois = dimension des matrices ) */

    incl indicei                  /* i <-- i + 1 */
    cmp $5, indicei		  /* i <> 5 ? i = 5 ? */
    jne iteration_sur_indice_i    /* repeter Tant Que (jumpIfNotEqual) i < 5 (on boucle 5 fois = dimension des matrices ) */

/* Affichage du Produit Matriciel C = A x B */

/* On souhaite afficher sur la sortie standard les coefficients Cij de la matrice C= A x B */

    movl $0, %ecx  /* %ecx <-- 0 */

label_boucleconversion:
    movl %ecx, temp2  /* temp2 <-- %ecx */
    movl C(,%ecx,4), %eax  /* %eax <-- Cij */
    movl $0, sortie_standard  
    movl $4, %ebx             /* %ebx <-- 4 */
    movb $0, sortie_standard(,%ebx,1)
    movl $5, var_compteur1  /* var_compteur1 <-- 5 */
    movl $0, var_compteur2  /* var_compteur2 <-- 0 */

label_0:
    cmp $0, %eax  /* %eax <> 0 ? %eax = 0 ? */
    je label_1    /* On effectue un saut conditionnel (jumpIfEqual) si %eax = 0 */ 

    decl var_compteur1  /* var_compteur1 <-- var_compteur1 - 1 */
    incl var_compteur2  /* var_compteur2 <-- var_compteur2 + 1 */
    movl $0, %edx       /* %edx <-- 0 */
    mov  $10, %bx	/* %bx <-- 10 */
    div %bx             /* reste de la division euclidienne */
    addl $48, %edx	/* %edx <-- %edx + 48 */
    movl var_compteur1, %ebx  /* %ebx <-- var_compteur1 */
    movb %dl, sortie_standard(,%ebx,1)

    jmp label_0  /* On effectue un saut inconditionnel au label_0 */
    
/*Le resultat à afficher est dans sortie_standard.*/
/*On doit donc le lire à partir de var_compteur1. */
      
/*var_compteur2 = nombre de chiffres que contient le nombre = 5 * var_compteur1 */

label_1:
    movl $sortie_standard, %ecx /* %ecx <-- sortie_standard */
    movl $4, %eax               /* %eax <-- 4 */
    movl $1, %ebx               /* %ebx <-- 1 */
    movl $5, %edx               /* %edx <-- 5 */
    int $0x80                   /* Appel au noyau (interruption 0x80) */



    movl $4, %eax               /* %eax <-- 4 */
    movl $1, %ebx               /* %ebx <-- 1 */
    movl $char_virgule, %ecx    /* %ecx <-- , */
    movl $1, %edx               /* %edx <-- 1 */
    int $0x80                   /* Appel au noyau (interruption 0x80) */

    incl temp2                  /* temp2 <-- temp2 + 1 */

    movl $0, %edx               /* %edx <-- 0 */
    movl temp2, %eax            /* %eax <-- temp2 */
    mov $5, %bx                 /* %bx <-- 5 */
    div %bx                     /* reste de la division euclidienne */
    cmp $0, %edx                /* %edx <> 0 ? %edx = 0 ? */
    jne label_pasdesautdeligne  /* Saut Conditionnelle (jumpIfNotEqual) si %edx > 0 (on boucle 5 fois = dimension des matrices ) */
                                /* sinon si %edx = 0 faire */
    movl $4, %eax               /* %eax <-- 4 */
    movl $1, %ebx               /* %ebx <-- 1 */
    movl $char_passage_à_la_ligne, %ecx /* %ecx <--  caractere de passage à la ligne */
    movl $1, %edx               /*  %edx <-- 1 */
    int $0x80                   /* Appel au noyau (interruption 0x80) */

label_pasdesautdeligne:        
    movl temp2, %ecx            /*  %ecx <-- temp2 */
    cmp $25, %ecx               /*  %edx <> 25 ? %ecx = 25 ? */
    jne label_boucleconversion  /*  Saut Conditionnelle (jumpIfNotEqual) si la matrice C n'est pas completement remplie vers le debut */ 
                                /*  de la boucle qui porte le label_boucleconversion */

/* Instructions Obligatoires pour terminer le fichier source assembleur */
done:
    movl  $0, %ebx
    movl  $1, %eax
    int   $0x80
