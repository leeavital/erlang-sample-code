-module( processes ).

-compile( export_all ).


ping( ) ->
  receive
    {ping, From} ->
      io:format( "ping ~n" ),
      timer:sleep( 500 ),
      From ! {pong, self()}
  end.


pong( ) ->
  timer:sleep( 500 ),
  Ping = spawn( ?MODULE, ping, [] ),
  Ping ! {ping, self()},
  receive
    {pong, _} ->
      io:format( "pong~n" )
  end.




ping_pong() -> pong().

ping_pong_async() -> spawn(?MODULE, pong, [] ).




