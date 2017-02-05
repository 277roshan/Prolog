sum-up-numbers-simple(L, N):-
   length(L,0),
   N is 0.

sum-up-numbers-simple(L, N):-
   [Single] = L,
   number(Single),
   N is Single.

sum-up-numbers-simple(L, N):-
   [Single] = L,
   \+number(Single),
   N is 0.

sum-up-numbers-simple(L, N):-
   [First|Rest] = L,
   \+number(First),
   sum-up-numbers-simple(Rest, Rest_sum),
   N is Rest_sum.


sum-up-numbers-simple(L, N):-
   [First|Rest] = L,
   number(First),
   sum-up-numbers-simple(Rest, Rest_sum),
   N is First + Rest_sum.


   




