
-module( tc_app ).

-behaviour( application ).

-export( [start/2, stop/1] ).


start( _, _ ) ->
  {ok, Sock} = gen_tcp:listen( 8000, [{active, false}] ),
  {ok, Sup} = tc_sup:start_link(),
  io:format( "Spawned a sock~n" ),
  spawn( fun() -> loop( Sock ) end ),
  {ok, Sup}.

stop( _ ) ->
  Pid = none,
  {ok, Pid}.


loop( Sock ) ->
  io:format( "listening~n" ),
  case gen_tcp:accept( Sock ) of
    {ok, CliSock} ->
      io:format( "Accepted a client socket~n" ),
      tc_sup:add_client( CliSock ),
      loop( Sock );
    _ ->
      io:format( "error ~n" ),
      loop( Sock )
  end.
