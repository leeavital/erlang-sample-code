-module( tc_sup ).
-behaviour( supervisor ).


-export( [init/1] ).
-export( [start_link/0] ).
-export( [add_client/1] ).


start_link() ->
  supervisor:start_link( {local, ?MODULE}, ?MODULE, [] ).


add_client( Socket ) ->
  supervisor:start_child( ?MODULE, {cli, {tc_client, init, [ Socket ]}, temporary, infinity, worker, dynamic} ),
  tc_cli_serve:add_client( Socket ).


init( _ ) ->
    RestartStrat = one_for_one,
    MaxR = 1,
    MaxT = 1000,
    ChildSpec = [ {c_serve, {tc_cli_serve, start_link, []}, permanent, infinity, worker, dynamic} ],
    {ok, {{RestartStrat,MaxR,MaxT}, ChildSpec}}.
