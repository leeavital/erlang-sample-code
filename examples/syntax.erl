% The first directive in each file is the module name
%
% It has to match the name of the module. For example, this
% file is called syntax.erl
-module( syntax ).


% functions that are exported can be used elsewhere
-export([
  list_length/1,
  list_length2/1,
  list_length3/1
]).



% the first style pattern matching function arguments. 
% more like prolog
%
% the compiler will complain that H is unused in the second
% rule, so we will prepend an underscore
list_length( [] ) -> 0;
list_length( [_H|T] ) -> 1 + list_length( T ).


% the second style of pattern matching, more like ML
%
% we'll use an underscore in the second pattern to (once
% again) prevent the compiler from complaining
list_length2( L ) ->
  case L of
    [] -> 0;
    [_|T] -> 1 + list_length2( T )
  end.



% This is the tail recursive way to count a list. Notice that
% only the version with arity 1 is exposed
list_length3( L ) -> list_length3( L, 0 ).
list_length3( [], N ) -> N;
list_length3( [_|T], N ) -> list_length3(T, N + 1).
