%%%-------------------------------------------------------------------
%% @doc enacltest public API
%% @end
%%%-------------------------------------------------------------------

-module(enacltest_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    {ok, Pid} = enacltest_sup:start_link(),
    {Pub, Priv} = enacltest_funs:generate_key(test),
    io:fwrite("Key: ~p ~p ~n", [binary_to_atom(aeser_api_encoder:encode(account_pubkey, Pub)), binary_to_atom(hexlify(Priv))]),
    {ok, Pid}.

stop(_State) ->
    ok.

hexlify(Bin) when is_binary(Bin) ->
    << <<(hex(H)),(hex(L))>> || <<H:4,L:4>> <= Bin >>.

hex(C) when C < 10 -> $0 + C;
hex(C) -> $a + C - 10.

%% internal functions
