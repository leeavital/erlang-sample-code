-module( tc_client ).

-export( [loop/2] ).


loop( Sock, ConnectedPool ) ->
  S = self(),
  spawn( fun() -> bind_sock(S, Sock) end ),
  loop( Sock, ConnectedPool, "anonymous" ).

loop( Sock, ConnectedPool, _Name ) ->
  receive
    {Sock, Msg} ->
      ConnectedPool ! {msg, Msg},
      loop( Sock, ConnectedPool );
    {msg, Msg} ->
      gen_tcp:send( Sock, Msg );
    _ ->
      io:format( "Terminating ~n" )
  end.


bind_sock( P, Sock ) ->
  io:format( "bind_sock" ),
  case gen_tcp:recv( Sock, 0 ) of
    {ok, Msg} ->
      P ! {Sock, binary_to_list(Msg)},
      bind_sock(P, Sock);
    {error, E} ->
      P ! {error, Sock, E}
  end.
