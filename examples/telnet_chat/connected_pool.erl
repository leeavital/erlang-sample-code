-module( connected_pool ).

-export( [loop/1] ).

loop( Clients ) ->
  receive
    {add_cli, PCli} ->
      io:format( "ConnectedPool added a client" ),
      loop( Clients ++ [PCli] );
    {msg, Msg} ->
      lists:foreach( fun(C) -> C ! {msg, Msg} end, Clients ),
      loop( Clients )
  end.
