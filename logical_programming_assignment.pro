sum-up-numbers-simple(L, N):-
  [Single] = L,
   number(Single),
   N is Single.

sum-up-numbers-simple(L, N):-
   [Single] = L,
   \+number(Single),
   N is 0.



