# Reduccion de polimeros

Este algoritmo trata de reducir una cadena de un polimero, cuyas moléculas
reacionan entre si siguiendo una regla.

Las moléculas de un polimero se definen como un string. Cada molécula es un
carácter del string y tiene un tipo y una polaridad.

El tipo de una molécula lo define la letra, y la polaridad su capitalización.

Por tanto:
  - *a* y *e* son moléculas de distinto tipo y misma polaridad
  - *a* y *A* son moléculas del mismo tipo y distinta polaridad
  - *a* y *E* son moléculas de distinto tipo y distinta polaridad

Dos moléculas reacionan si son del mismo tipo pero tienen distinta polaridad,
de ser así desaparecen de la cadena.

Por ejemplo:
  - Aa reacionan y desaparecen
  - aBbA reacciona Bb y desaparecen y queda aA que reacionan y desaparecen
  - abcBA cadena base, no reacciona nada

Considerando la cadena: dabAcCaCBAcCcaDA

  1. dabA**cC**aCBAcCcaDA  Se elimina cC
  2. dab**Aa**CBAcCcaDA    Esto genera Aa, reacionan y se elimina
  3. dabCBA**cCc**aDA      Se ha generado cC o Cc una de las dos reacciona
  4. dabCBAcaDA            LLegamos a un caso base donde no reacciona nada

Dada una cadena de moléculas que conforman un polímero, se debe llegar al caso
base, donde no haya ninguna molécula que reacciona con otra.