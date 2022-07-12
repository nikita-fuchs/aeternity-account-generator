-module(enacltest_funs).
-export([start_link/0]).

-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2, code_change/3]).
-export([test/1, generate_key/1]).

-define(SERVER, ?MODULE).

-record(state, {}).


start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, {}, []).

%% @private
init({}) ->
    {ok, #state{}}.



test(Params) ->
    gen_server:call(?MODULE, {test, Params}).

generate_key(Params) ->
    gen_server:call(?MODULE, {generate_key, Params}).


% here the function to handle the generate_key call with params
handle_call({generate_key, Seed}, _From, State) ->
    #{ public := PK, secret := SK} = enacl:sign_keypair(),
  %%  Reply = #{ public => PK, private => SK },
    {reply, {PK,SK}, State};
%% @private    
handle_call({test, Params}, _From, State) ->
    {reply, Params, State};
%% @private
handle_call(_Request, _From, State) ->
    {reply, {error, unknown_call}, State}.

%% @private
handle_cast(_Msg, State) ->
    {noreply, State}.

%% @private
handle_info(_Info, State) ->
    {noreply, State}.

%% @private
terminate(_Reason, _State) ->
    ok.

%% @private
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.


