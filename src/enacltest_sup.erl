%%%-------------------------------------------------------------------
%% @doc enacltest top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(enacltest_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%% sup_flags() = #{strategy => strategy(),         % optional
%%                 intensity => non_neg_integer(), % optional
%%                 period => pos_integer()}        % optional
%% child_spec() = #{id => child_id(),       % mandatory
%%                  start => mfargs(),      % mandatory
%%                  restart => restart(),   % optional
%%                  shutdown => shutdown(), % optional
%%                  type => worker(),       % optional
%%                  modules => modules()}   % optional
init([]) ->
    Enacltest = #{id => enacltest_funs, 
                  start => {enacltest_funs, start_link, []},
                  restart => permanent,
                  type => worker
            },
    SupFlags = #{strategy => one_for_one,
                 intensity => 0,
                 period => 1},
    ChildSpecs = [Enacltest],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
