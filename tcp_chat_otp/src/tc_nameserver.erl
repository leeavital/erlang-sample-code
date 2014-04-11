-module( tc_nameserver ).


-behaviour( gen_server ).

-export( [start_link/0, set_name/2, get_name/1] ).

-export( [init/1, handle_call/3, handle_cast/2, code_change/3, handle_info/2, terminate/2] ).


start_link() ->
  gen_server:start_link( {local, ?MODULE}, ?MODULE,  [ dict:new() ], [] ).


set_name( Sock, Name ) ->
  gen_server:cast( ?MODULE, {set_name, Sock, Name}).

get_name(Sock) ->
  gen_server:call( ?MODULE, {get_name, Sock} ).


init( _ ) ->
  {ok, dict:new() }.

handle_call( {get_name, Sock}, _From, Names) ->
  case dict:find( Sock, Names ) of
    {ok, Name} ->
      {reply, Name, Names};
    error ->
      {reply, "Anonymous", Names}
  end.


handle_cast( {set_name, Sock, Name}, Names  ) ->
  NewState = dict:store( Sock, Name, Names ),
  io:format( "~p~n", [NewState] ),
  {noreply, NewState}.


handle_info( _, State ) ->
  {noreply, State}.

terminate( _Reason, _State ) ->
  ok.


code_change(_, _, State ) ->
  {ok, State}.
