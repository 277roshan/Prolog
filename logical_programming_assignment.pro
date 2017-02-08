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
	 
%number exists check
number-exists([Y|T]):-
	number(Y);
	number-exists(T).


%greater than or equal to number helper
greater-than-number(Number1,Number2, Greater):-
	number(Number1),
	number(Number2),
	Number1>=Number2,
	Greater is Number1.

greater-than-number(Number1,Number2, Greater):-
	number(Number1),
	number(Number2),
	Number2>=Number1,
	Greater is Number2.
	

%find min in a list
min-in-list(L, Value):-
	[First] = L,
	number(First),
	Value is First.

min-in-list(L, Value):-
	[First,Second] = L,
	lesser-than-number(First, Second, Less_val),
	Value is Less_val.

min-in-list(L, Value):-
	number-exists(L),
	[First|Second] = L,
	number-exists(Second),
	min-in-list(Second, Rest_min),
	lesser-than-number(First, Rest_min, Less_val),
	Value is Less_val.

min-in-list(L, Value):-
	number-exists(L),
	[First|Second] = L,
	\+number-exists(Second),
	Value is First.


%get all numbers greater than given number
greater-than-numbers(L, Check, Numbers):-
	[X|Y] = L,
	number(X),
	greater-than-number(X, Check, Greater),
	Greater=\=Check,
	greater-than-numbers(Y, Check, Numbers_),
	append([Greater], Numbers_, Numbers).

greater-than-numbers(L, Check, Numbers):-
	[X|Y] = L,
	number(X),
	greater-than-number(X, Check, Greater),
	Greater=:=Check,
	greater-than-numbers(Y, Check, Numbers_),
	append([],Numbers_, Numbers).

greater-than-numbers(L, Check, Numbers):-
	[X|Y] = L,
	\+number(X),
	greater-than-numbers(Y, Check, Numbers_),
	append([],Numbers_, Numbers).

greater-than-numbers(L, Check, Numbers):-
	length(L,0),
	number(Check),
	append([],[],Numbers).


% smallest number in L2
% take L1 number bigger than smallest number in L2
% find smallest of these numbers
min-above-min(L1, L2, N):-
	min-in-list(L2, Min_Val),
	greater-than-numbers(L1,Min_Val, Filtered_numbers),
	min-in-list(Filtered_numbers, Ans),
	N is Ans.

min-above-min(L1, L2, N):-
	\+min-in-list(L2, Min_Val),
	min-in-list(L1, Ans),
	N is Ans.


% create a simple list from nested

nested-to-simple(L, Simple):-
	[First|Rest] = L,
	is_list(First),
	nested-to-simple(First, Simple_First),
	nested-to-simple(Rest, Simple_Rest),
	append(Simple_First, Simple_Rest, Simple).

nested-to-simple(L, Simple):-
	[First|Rest] = L,
	\+is_list(First),
	nested-to-simple(Rest, Simple_Rest),
	append([First], Simple_Rest, Simple).

%Base case
nested-to-simple([],[]).


simple-intersection(L1, L2, N):-
	[First|Rest] = L1,
	member(First, L2),
	simple-intersection(Rest,L2,M),
	append([First],M, N).

simple-intersection(L1, L2, N):-
	[First|Rest] = L1,
	\+member(First, L2),
	simple-intersection(Rest,L2,M),
	append([],M, N).

simple-intersection(L1, L2, N):-
	[First] = L1,
	member(First, L2),
	simple-intersection(Rest,L2,M),
	append([First],M, N).

simple-intersection(L1, L2, N):-
	[First] = L1,
	\+member(First, L2),
	simple-intersection(Rest,L2,M),
	append([],M, N).

%base case
simple-intersection([], L2, []).


%remove element from simple list

remove-element(L, E, Ans):-
	[X|Y] = L,
	member(E,[X]),
	remove-element(Y, E, Ans2),
	append([],Ans2,Ans).

remove-element(L, E, Ans):-
	[X|Y] = L,
	\+member(E,[X]),
	remove-element(Y, E, Ans2),
	append([X],Ans2,Ans).

remove-element(L, E, Ans):-
	[X] = L,
	member(E,[X]),
	append([],Ans2,Ans).

remove-element(L, E, Ans):-
	[X] = L,
	\+member(E,[X]),
	append([X],Ans2,Ans).

remove-element(L, E, Ans):-
	length(L,0),
	append([],[],Ans).


%remove duplicates

remove-duplicates(L, Ans):-
	[X|Y] = L,
	remove-element(L, X, Val),
	remove-duplicates(Val, Ans2),
	append([X],Ans2,Ans).

remove-duplicates(L, Ans):-
	[X] = L,
	append([],[],Ans).

remove-duplicates(L, Ans):-
	length(L,0),
	append([],[],Ans).



%common-unique-elements(L1,L2,N):-
%	[First|Rest] = L1
%	nested-to-simple(L1, L1_simple),
%	nested-to-simple(L2, L2_simple),

	








