-module( client_handler ).

-compile( export_all ).

init( Sock ) ->
  loop( Sock ).


loop( Sock ) ->
  case gen_tcp:recv( Sock, 0 ) of
    {ok, Msg} ->
      gen_tcp:send( Sock, Msg ),
      loop( Sock );
    {error, E} ->
      io:format( "ERROR~p~n", E)
  end.
