-module( tc_cli_serve ).

-behaviour( gen_server ).


-version( "1" ).

-export( [init/1, handle_cast/2, handle_call/3,code_change/3,terminate/2,handle_info/2] ).
-export( [start_link/0, send_message/2, add_client/1, get_state/0] ).






init( Socks ) ->
  {ok, Socks }.

start_link( ) ->
  gen_server:start_link( {local, ?MODULE}, ?MODULE, [], [] ).



send_message( Msg, SockFrom ) ->
  gen_server:cast( ?MODULE, {msg, Msg, SockFrom} ).


add_client( Cli ) ->
  gen_server:cast( ?MODULE, {add_cli, Cli} ).



get_state( ) ->
  gen_server:call( ?MODULE, get_state ).


handle_cast( {msg, Msg}, Socks ) when is_bitstring( Msg ) ->
  handle_cast( {msg, binary_to_list(Msg)}, Socks );


% handle_cast( {msg, "/name " ++ Name, Sock}, Socks ) ->
%   tc_nameserver:set_name( Sock, Name ),
%   {noreply, Socks};


handle_cast( {msg, Msg, FromSock}, Socks ) when is_list( Msg ) ->
  io:format( "Sending a message to all clients~n" ),
  % UName = tc_nameserver:get_name( FromSock ),
  % lists:foreach( fun(S) -> gen_tcp:send( S, UName ++ Msg ) end, Socks ),

  lists:foreach( fun(S) -> gen_tcp:send( S, ">" ++  Msg ) end, Socks ),
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

code_change(_OldVsn, State, _Extra) -> io:format("changing code~n"), {ok, State}.





