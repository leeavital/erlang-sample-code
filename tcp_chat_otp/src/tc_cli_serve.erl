-module( tc_cli_serve ).

-behaviour( gen_server ).


-export( [init/1, handle_cast/2, handle_call/3,code_change/3,terminate/2,handle_info/2] ).
-export( [start_link/0, send_message/1, add_client/1, get_state/0] ).






init( Socks ) ->
  {ok, Socks }.

start_link( ) ->
  gen_server:start_link( {local, ?MODULE}, ?MODULE, [], [] ).



send_message( Msg ) ->
  gen_server:cast( ?MODULE, {msg, Msg} ).


add_client( Cli ) ->
  gen_server:cast( ?MODULE, {add_cli, Cli} ).



get_state( ) ->
  gen_server:call( ?MODULE, get_state ).


handle_cast( {msg, Msg}, Socks ) ->
  io:format( "Sending a message to all clients~n" ),
  lists:foreach( fun(S) -> gen_tcp:send( S, Msg ) end, Socks ),
  {noreply , Socks};


handle_cast( {add_cli, Sock}, Socks ) ->
  io:format( "Added a client~n" ),
  {noreply, [Sock] ++ Socks}.





handle_call( get_state, _From, State ) ->
  {reply, State, State};


handle_call(_From, Arg, Socks ) ->
  io:format( "Got a bad message ~p~n", [Arg] ),
  {noreply, Socks}.


handle_info( _, State ) -> {ok, State}.

terminate(_Reason, _State) -> ok.

code_change(_OldVsn, State, _Extra) -> {ok, State}.





