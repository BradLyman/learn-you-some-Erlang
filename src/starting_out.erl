%%% # Numbers

%%% ## Variables

%%% Variables always start with an uppercase letter.
%%% Using an unbound variable will trigger an error on the CLI

One.

%%% A variable can only have a single value.

One = 1.

%%% For example, this works because 'One' already has a value of 1

Un = Uno = One = 1.

%%% Variables can be assigned using other varables.

Two = One + One.
Two = 2.

%%% This will fail because the statement is invalid, 'Two' cannot equal
%%% 'Two' plus one -- it's already been defined to equal two.

Two = Two + 1.

%%% The equals operator is not assigning values, instead it is performing
%%% pattern matching with the expression. This is why a variable can be
%%% 'rebound' to the same value:  the pattern matches.
%%%
%%% In the terminal a variable can be cleared.

f(Two).

%%% Or with zero args, all variables can be cleared.

f().

%%% This cannot be done in an actual Erlang program, but is perfectly do-able
%%% in the CLI.


%%% In the erlang shell **expressions need to be terminated with a period.**
%%% Expressions can be separated with commas, but the last expression needs
%%% a period. Also, only the expression followed by a period will produce
%%% output

2 + 15.
49 * 100.
5 / 2.
5 div 2.
5 rem 2.

%%% Erlang handles ints and floating point numbers transparently when doing
%%% arithmatic. Use 'div' and 'rem' to perform integer-to-integer division.
%%%
%%% Arithmatic obeys order-of-operations rules.

(50 * 100) - 4999.
-(50 * 100 - 4999).
-50 * (100 - 4999).

%%% Integers can be expressed with other bases, just enter the number as
%%% ```base#value```. Base must be between 2 and 36

2#101010.
8#0677.
16#AE.
26#abcde.

%%% ## Atoms

%%% Atoms start with a lowercase letter. Atoms cannot be changed or broken
%%% apart.

atom.
cat_atom.
'this atom has spaces, but needs to be in single quotes'.
atom = 'atom'.

%%% Atoms always exist and are never garbage collected.
%%% This means that Atoms should **never** be created from user-input.

%%% ## Boolean Logic

true and false.
true or false.
true xor false.
true xor true.
not false.
not (true and true).

%%% Boolean operators 'and' and 'or' do not short-circut the way similar
%%% operators in java/C++ might. Use 'andalso' or 'orelse' to get the
%%% short-circuting behavior.

%%% Equality operators

5 =:= 5. % true
1 =:= 0. % false
1 =/= 0. % true

%%% Comparing nubers with decimals require some extra operators because
%%% floats are weird.

5 =:= 5.0. % false
5 == 5.0. % true
5 =/= 5.0. % true
5 /= 5.0. % false

%%% Comparisons are unsurprising.

1 < 2.
1 < 1.
1 >= 1.
1 =< 1.

%%% Erlang will throw a fit if you do naughty things with types.
%%% Here, try adding a number to an atom.

5 + llama.

%%% Comparisons are allowed between types, there is a strict ordering
%%% predefined:
%%%     number < atom < reference < fun < port < pid < tuple < list < bit string

0 == false. % false, don't expect 'false' to equal 0 like in c
1 < false. % atoms are always greater than numbers


%%% ## Tuples

%%% Tuples can be defined with the curly bracket.

X = 10, Y = 4.
Point = {X, Y}.

%%% Extracting varues can be done with pattern matching.

{A, B} = Point.
A =:= X.
B =:= Y.
{_,C} = Point.
C =:= Y.

%%% A 'tagged tuple' is, by convention, a tuple containing a single atom
%%% followed by a single value.

PreciseTemp = {celsius, 18.342}.
{celsius, T} = PreciseTemp.

%%% Tagging the value can prevent misuse by accident.

{kelvin, 18.342} =:= PreciseTemp.
{kelvin, T} = PreciseTemp.


%%% ## Lists

%%% Lists are defined with square brackets and contain mixed data types

[1, 2, 3, {celsius, 123}, an_atom].

%%% Lists of just numbers might be surprising though.

[97, 98, 99]. % abc

%%% Erlang treats strings and list the same way. It kinda sucks tbh, but
%%% there are other ways to represent strings.

%%% Lists can be concatenated with the '++' operator

[1, 2, 3] ++ [4, 5].

%%% Items can be removed '--' operator.

[1, 2, 3, 3, 2] -- [2, 3].

%%% Chaining '--' on one line causes each to be evaluated right to left

[1, 2, 3] -- [2, 3] -- [3].

%%% The head and tail can be retrieved with built in functions (BIF)

hd([1, 2, 3]).
tl([1, 2, 3]).

%%% This can also be done with pattern matching

[Head|Tail] = [1, 2, 3].
Head =:= 1.
Tail =:= [2, 3].
[NewHead|NewTail] = Tail.
NewHead =:= 2.
NewTail =:= [3].

%%% Lists can be built with the pattern-matching syntax too.

TurboList = [5|Tail].
TurboList =:= [5, 2, 3].


%%% ## List Comprehensions

%%% A basic list comprehension is of the form '[Value || generator]'.

[2*N || N <- [1, 2, 3, 4]].

Menu = [{steak, 5.99}, {beer, 3.99}, {poutine, 3.50}, {kitten, 20.99}].
WithTax = [{Item, Price*1.07} || {Item, Price} <- Menu].

%%% Conditions can be added to restrict the generated values.

Filtered = [{Item, Price*1.07} || {Item, Price} <- Menu, Price > 4].

%%% Multiple generators and conditions can be used.

[{X+Y, X, Y} || X <- [1, 2], Y <- [2, 3]].
[{X+Y, X, Y} || X <- [1, 2, 3], Y <- [2, 3], X < 3].
[{X+Y, X, Y} || X <- [1, 2, 3], Y <- [2, 3], X < 3, X+Y > 3].

%%% Generators pattern-match and can also be used to filter.

Weather =
    [{toronto, rain}
    ,{montreal, storms}
    ,{london, fog}
    ,{paris, sun}
    ,{boston, fog}
    ,{vancouver, snow}
    ].

FoggyPlaces = [X || {X, fog} <- Weather].


