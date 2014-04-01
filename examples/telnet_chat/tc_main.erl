-module( tc_main ).

-export( [init/0] ).


init() ->
  {ok, LSock} = gen_tcp:listen(8999, [binary, {packet, 0}, {active, false}]),
  ConnectedPool = spawn( connected_pool, loop, [ [] ] ),
  loop( LSock, ConnectedPool ).


loop( Sock, ConnectedPool ) ->
  case gen_tcp:accept( Sock ) of
    {ok, Cli} ->
      CliP = spawn( tc_client, loop, [Cli, ConnectedPool] ),
      ConnectedPool ! {add_cli, CliP},
      loop( Sock, ConnectedPool );
    _ ->
      io:format( "error~n" )
  end.

