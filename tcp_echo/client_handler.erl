-module( client_handler ).

-compile( export_all ).





loop( Sock ) ->
  case gen_tcp:recv( Sock, 0 ) of
    {ok, Msg} ->
      tc_client_pool ! {msg, Msg},
      loop( Sock );
    {error, E} ->
      io:format( "ERROR~p~n", E)
  end.
