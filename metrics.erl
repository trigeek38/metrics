-module(metrics).
-author("Jeff Bell<jeff@5nineshq.com>").

-mod_title("Learning Site").
-mod_description("Site for learning Zotonic").
-mod_prio(10).

%% gen_server exports
-export([event/2]).
-export([datamodel/0]).

-include_lib("zotonic.hrl").

event({postback, {make_unavailable, Props}, _TriggerId, _TargetId}, Context) ->
    Id = proplists:get_value(id, Props),
    Node = proplists:get_value(node, Props),
    {ok, _} = m_rsc:update(Id, [{status, "down"}], Context),
    mod_signal:emit({node_status_changed, [{node_id, Node}]}, Context),
    Context;

event({postback, {make_available, Props}, _TriggerId, _TargetId}, Context) ->
    Id = proplists:get_value(id, Props),
    Node = proplists:get_value(node, Props),
    {ok, _} = m_rsc:update(Id, [{status, "up"}], Context),
    mod_signal:emit({node_status_changed, [{node_id, Node}]}, Context),
    Context.

datamodel() ->
    [
     {categories,
      [
       {node,
        undefined,
        [{title, <<"Node">>}]
        }
      ]
     }
    ].
