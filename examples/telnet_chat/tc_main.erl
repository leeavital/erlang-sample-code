-module( tc_main ).

-export( [init/0] ).


init() ->
  {ok, LSock} = gen_tcp:listen(5678, [binary, {packet, 0}, {active, false}]),
  loop( LSock ).


loop( Sock ) ->
  case gen_tcp:accept( Sock ) of
    {ok, Cli} ->
      spawn( tc_client, loop, [Cli] ),
      loop( Sock );
    _ ->
      io:format( "error~n" )
  end.

