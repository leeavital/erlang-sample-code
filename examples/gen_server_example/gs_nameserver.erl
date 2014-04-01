-module( gs_nameserver ).

-behaviour( gen_server ).

-export( [init/1, handle_cast/2 ,handle_call/3, handle_info/2,
          terminate/2, code_change/3] ).




init( _ ) ->
  {ok, []}.



handle_cast( {add_name, Name},  State ) ->
  {noreply, [Name] ++ State  }.


handle_call( names, _From, State ) ->
  timer:sleep( 1000 ),
  {reply, State, State}.




handle_info( _Info, State) ->
  {noreply, State} .

terminate( _Reason, _State ) ->
  ok.

code_change(_, State, _ ) ->
  {ok, State}.


