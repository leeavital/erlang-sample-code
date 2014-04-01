-module( hot_loading ).
-export( [loop/1] ).




loop( State ) ->
  receive
    {add, E} ->
      loop( [E] ++ State );
    {reset} ->
      loop( [] );
    print ->
      io:format("listing ~p~n", [State]),
      loop( State );
    code_switch ->
      ?MODULE:loop( State ) % Fully qualified call
  end.
