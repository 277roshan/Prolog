%author Roshan Thapaliya
%Structures of Programming Language: Logical Programming



% list is empty
sum-up-numbers-simple(L, N):-
   length(L,0),
   N is 0.

% there is 1 element and it is number
sum-up-numbers-simple(L, N):-
   [Single] = L,
   number(Single),
   N is Single.

% there is 1 element and it is not a number
sum-up-numbers-simple(L, N):-
   [Single] = L,
   \+number(Single),
   N is 0.

% there are more than 1 elements
% recursive call on the tail
% first element is not a number do not add up to the sum of rest
sum-up-numbers-simple(L, N):-
   [First|Rest] = L,
   \+number(First),
   sum-up-numbers-simple(Rest, Rest_sum),
   N is Rest_sum.

% there are more than 1 elements
% recursive call on the tail
% first element is a number so add up to the sum of rest
sum-up-numbers-simple(L, N):-
   [First|Rest] = L,
   number(First),
   sum-up-numbers-simple(Rest, Rest_sum),
   N is First + Rest_sum.


   

% list is empty
sum-up-numbers-general(L, N):-
   length(L,0),
   N is 0.

% there is 1 element and it is a list
sum-up-numbers-general(L, N):-
   [Single] = L,
   is_list(Single),
   sum-up-numbers-general(Single, A),
   N is A.


% there is 1 element and it is number
sum-up-numbers-general(L, N):-
   [Single] = L,
   number(Single),
   N is Single.

% there is 1 element and it is not a number and not a list
sum-up-numbers-general(L, N):-
   [Single] = L,
   \+number(Single),
   \+is_list(Single),
   N is 0.

% there are more than 1 elements
% recursive call on the tail
% first element is not a number do not add up to the sum of rest
sum-up-numbers-general(L, N):-
   [First|Rest] = L,
   \+number(First),
   \+is_list(First),
   sum-up-numbers-general(Rest, Rest_sum),
   N is Rest_sum.

% there are more than 1 elements
% recursive call on the tail
% first element is a number so add up to the sum of rest
sum-up-numbers-general(L, N):-
   [First|Rest] = L,
   number(First),
   sum-up-numbers-general(Rest, Rest_sum),
   N is First + Rest_sum.


% there are more than 1 elements
% recursive call on the tail
% first element is a list so recursive call
sum-up-numbers-general(L, N):-
   [First|Rest] = L,
   is_list(First),
   sum-up-numbers-general(Rest, Rest_sum),
   sum-up-numbers-general(First, First_sum),
   N is First_sum + Rest_sum.





% compare to see which is lesser than number

lesser-than-number(Number1,Number2, Lesser):-
	number(Number1),
	number(Number2),
	Number1=<Number2,
	Lesser is Number1.

lesser-than-number(Number1,Number2, Lesser):-
	number(Number1),
	number(Number2),
	Number2=<Number1,
	Lesser is Number2.

lesser-than-number(Number1,Number2, Lesser):-
	\+number(Number1),
	number(Number2),
	Lesser is Number2.

lesser-than-number(Number1,Number2, Lesser):-
	\+number(Number2),
	number(Number1),
	Lesser is Number1.
	 


%find min in a list

min-in-list(L, Value):-
	[First] = L,
	number(First),
	Value is First.

min-in-list(L, Value):-
	[First|Second] = L,
	number(First),
	min-in-list(Second, Rest_min),
	lesser-than-number(First, Rest_min, Less_val),
	Value is Less_val








	



