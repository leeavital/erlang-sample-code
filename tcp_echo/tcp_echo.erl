-module( tcp_echo ).


-compile( export_all ).

main( Port ) ->
  Pool = client_pool:init(),
  register(tc_client_pool, Pool),
  {ok, LSock} = gen_tcp:listen( Port, [binary, {packet, 0}, {active, false} ] ),
  spawn( fun() -> loop( LSock ) end ).



loop( LSock ) ->
  case gen_tcp:accept( LSock ) of
    {ok, Sock} ->
      spawn( client_handler, loop, [Sock] ),
      tc_client_pool ! {add_client, Sock},
      loop( LSock);
    _ ->
      io:format( "Error?" )
  end.
