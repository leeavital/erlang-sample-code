-module( tcp_echo ).


-compile( export_all ).

main( Port ) ->
  {ok, LSock} = gen_tcp:listen( Port, [binary, {packet, 0}, {active, false} ] ),
  loop( LSock ).



loop( LSock ) ->
  case gen_tcp:accept( LSock ) of
    {ok, Sock} ->
      io:format( "accepted a socket" ),
      spawn( client_handler, init, [Sock] ),
      loop( LSock );
    _ ->
      io:format( "Error?" )
  end.
