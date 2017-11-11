.data
UnNom :
      .long 43    /* d\'efinition d'un entier cod\'e sur~$4$ octets */
      .long 54    
      .long 23    /* on aurait pu d\'efinir cette suite d'entiers  */
      .long 32    /* par .long 43,54,32,76                         */
      .long 76
      .string "hello world" /* Des donn\'ees dont on ne se sert pas */
      .float 3.14
UnAutre:
          .space 4
.text
.globl _start 
_start:
         movl $5, %eax      /* EAX va nous servir de compteur indiquant le
                               nombre d'entiers restant \`a additionner   */
         movl $0, %ebx      /* EBX va contenir la somme de ces entiers    */
         movl $UnNom, %ecx  /* ECX va << pointer >> sur l'\'el\'ement
                               courant \`a additionner                    */
top:   addl (%ecx), %ebx  /* Additionne au contenu de EBX ce qui est 
                             point\'e par ECX et stocke le r\'esultat dans
                             EBX                                         */
         addl $4, %ecx      /* D\'eplace le << pointeur >> sur 
                               l'\'el\'ement suivant                     */
         decl %eax          /* D\'ecr\'emente le compteur EAX            */
         jnz top            /* Si le contenu de EAX est non nul alors 
                              ex\'ecuter le code \`a partir du label top */
done:    movl %ebx, UnAutre /* sinon, le resultat est stock\'e           
        movl    $0,%ebx     /* Ces instructions permettent d'invoquer de */ 
        movl    $1,%eax     /* terminer l'ex\'ecution d'un programme     */
        int     $0x80       /* assembleur et sont indispensable          */
 /* Utilisateur d'emacs, veillez \`a ajouter une ligne vide apr\`es
 ce commentaire afin de ne pas provoquer un Segmentation fault */