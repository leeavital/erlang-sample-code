-module( tc_client ).

-export( [loop/1] ).


loop( Sock ) ->
  case gen_tcp:recv( Sock, 0 ) of
    {ok, Msg} ->
      gen_tcp:send( Sock, Msg ),
      loop( Sock );
    _ ->
      io:format( "Terminating ~n" )
  end.
