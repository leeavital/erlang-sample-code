-module( patterns ).

-export( [read_it/1, read_it2/1] ).


% the pertinent line here is
%
%  {ok, D} = file:read_file( F ),
%
% if we don't get a tuple that starts with the ok atom, we'll have problems
read_it( F ) when is_list( F ) ->
  {ok, D} = file:read_file( F ),
  io:format( "~p", [D] ).



% this version deals with not getting a tuple of the form
% {ok, _} from file:read_file
read_it2( F ) when is_list( F ) ->
  case file:read_file( F ) of
    {ok, D} ->
      io:format( "~p", [D] );
    {error, Err} ->
      io:format( "error: ~p", [Err] )
    end.
