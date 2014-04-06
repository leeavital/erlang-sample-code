-module( laggy_logger ).

-export( [init/0, loop/1] ).

init() ->
  spawn( laggy_logger, loop, [[]] ).


loop( Logs ) ->
  receive
    code_switch ->
      ?MODULE:loop( Logs );
    Msg ->
      NewLogs = [Msg] ++ Logs,
      case length( NewLogs ) of
        5 ->
          lists:foreach( fun(E) -> io:format( "~p~n", [E] ) end, NewLogs ),
          loop( [] );
        _ ->
          loop( NewLogs )
      end
    end.

