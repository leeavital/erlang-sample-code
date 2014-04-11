-module( tc_client ).

-export( [init/1] ).


init( Sock ) ->
  spawn( fun() -> loop(Sock) end ).


loop( Sock ) ->
  case gen_tcp:recv( Sock, 0 ) of
    {ok, Msg} ->
        io:format( "Message: ~p~n", [Msg] ),
        tc_cli_serve:send_message( Msg ),
        loop( Sock );
    _ ->
      io:format( "exiting..." ),
      exit
  end.
